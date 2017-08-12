class ProcessRecordJob < ApplicationJob
  queue_as :default

  def perform(record, current_user_id)
    # \/ this is how we can do it with the locally installed OpenALPR and gem. but it is missing CA configs
    # download = open(record.s3_url)
    # path_to_file = "#{Rails.root.to_s}/tmp/#{URI.unescape(download.base_uri.to_s).split('/')[-2..-1].join}"
    # IO.copy_stream(download, path_to_file)
    # alpr = Alpr.new(path_to_file)

    # old approach
    analysis_params = {
      image_url: record.s3_url,
      tasks: 'plate',
      topn: 1,
      country: 'ca'
    }

    analysis_data = ALPR.recognize(params: analysis_params)

    unless analysis_data.plate.results.any?
      error = { message: 'ALPR could not find a lincence plate in this image', status: 400 }
    end

    if record.update({
      analysis_data: analysis_data,
      analyzed_at: DateTime.now,
      plate: analysis_data.plate.results[0].plate,
      status: :processed}) && !error
    else
      error = { message: 'Could not save processed data to server', status: 400 }
    end

    if error
      ActionCable.server.broadcast("attendant_#{current_user_id}_info", status: error.status, type: :error, message: error.message)
    else
      ActionCable.server.broadcast("attendant_#{current_user_id}_info", status: 200, type: :add, record: RecordSerializer.new(record))
    end
  end
end
