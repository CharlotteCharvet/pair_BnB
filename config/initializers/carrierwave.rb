 require 'carrierwave/storage/fog'

 CarrierWave.configure do |config|

    config.fog_provider           = 'fog/aws'
    config.fog_credentials = {
      :provider               => 'AWS',            # required
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],     # required
      :aws_secret_access_key  => ENV['AWS_ACCESS_SECRET_KEY'],  # required
      :region                 => 'ap-southeast-1'
    }
    config.fog_use_ssl_for_aws = false
    config.fog_directory       = ENV['S3_BUCKET']          # required
  end