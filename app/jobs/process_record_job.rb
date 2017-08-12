require 'open-uri'

class ProcessRecordJob < ApplicationJob
  queue_as :default

  def perform(record)
    open('image.png', 'wb') do |image|
      image << open(record.s3_url).read
    end

    aplr = Alpr.new(image)
    record.update({analysis_data: alpr.output, analyzed_at: DateTime.now, plate: alpr.output.plate.results[0].plate})
  end
end
