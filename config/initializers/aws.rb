Aws.config.update(
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
  region: 'us-east-1',
)

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['AWS_ATTENDANT_BUCKET'])