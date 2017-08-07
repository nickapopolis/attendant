class RecordSerializer < ActiveModel::Serializer
  attributes :id, :s3_url, :status, :user
end
