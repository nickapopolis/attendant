class DashboardsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_s3_direct_post, only: [:show]

	def show
		@record = Record.new
		@records = current_user.records
    @react_props = { records: @records, user: current_user, s3_url: @s3_direct_post.url, s3_fields: @s3_direct_post.fields }
	end

	private
	  def set_s3_direct_post
	    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
	  end
end
