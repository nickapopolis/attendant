class RecordsController < ApplicationController
	before_action :authenticate_user!

	def index

	end

	def create
		record = Record.new(record_params)
		record.status = :uploaded
		record.user = current_user
		unless record.save
			return render json: { error: 'record could not save to db' }, status: :unporcessable_entity
		end

		ProcessRecordJob.perform_later(record)
		#search = Alpr.new(record.s3_url)
		#analysis_data = search.output

		#todo move processing into anoter api call, and put it in a background process
		# params = {
		#   image_url: record.s3_url,
		#   tasks: 'plate',
		#   topn: 1,
		#   country: 'ca'
		# }

		# analysis_data = ALPR.recognize(params: params)
		# unless analysis_data.plate.results.any?
		# 	return render json: { error: 'ALPR could not find a plate in this image', status: 400 }
		# end

		# record.update({analysis_data: analysis_data, analyzed_at: DateTime.now, plate: analysis_data.plate.results[0].plate})

		render json: record
	end

	private
		def record_params
			params.require(:record).permit(:s3_url)
		end
end
