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

		#todo move processing into anoter api call, and put it in a background process
		params = {
		  image_url: record.s3_url,
		  tasks: 'plate',
		  topn: 1,
		  country: 'ca'
		}

		data = ALPR.recognize(params: params)

		# unless data.results.any?
		# 	return render json: { error: 'ALPR could not find a plate in this image', status: 400 }
		# end

		render json: { record: record, data: data }
	end

	private
		def record_params
			params.require(:record).permit(:s3_url)
		end
end
