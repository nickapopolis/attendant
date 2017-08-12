class RecordsController < ApplicationController
	before_action :authenticate_user!

	def index

	end

	def create
		record = Record.new(record_params)
		record.status = :uploaded
		record.user = current_user
		unless record.save
			return render json: { error: 'record could not save to db', status: :unporcessable_entity }
		end

		ProcessRecordJob.perform_now(record, current_user.id)

		render json: record
	end

	private
		def record_params
			params.require(:record).permit(:s3_url)
		end
end
