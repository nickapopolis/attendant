class RecordsController < ApplicationController
	before_action :authenticate_user!

	def index

	end

	def create
		@record = Record.new(record_params)
		@record.status = :uploaded
		@record.user = current_user

		@record.save
	end

	private
		def record_params
			params.require(:record).permit(:s3_url)
		end
end
