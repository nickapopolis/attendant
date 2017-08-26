if Rails.env.development?
  Aws.config.update(
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
    region: 'us-east-1',
    endpoint: 'http://localhost:5001',
    force_path_style: true
  )
else
  Aws.config.update(
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
    region: 'us-east-1'
  )
end


S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['AWS_ATTENDANT_BUCKET'])

if !S3_BUCKET.exists?
  S3_BUCKET.create({
    acl: "private",
    create_bucket_configuration: {
      location_constraint: "us-east-1",
    },
    grant_full_control: "GrantFullControl",
    grant_read: "GrantRead",
    grant_read_acp: "GrantReadACP",
    grant_write: "GrantWrite",
    grant_write_acp: "GrantWriteACP",
  })
end