if Rails.env.production?
    Paperclip::Attachment.default_options[:url] = 'cubic-assets.amazonaws.com'
    Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
    Paperclip::Attachment.default_options[:s3_host_name] = 's3-us-west-2.amazonaws.com'
end
