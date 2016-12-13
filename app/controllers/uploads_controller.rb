class UploadsController < ApplicationController

  def photo_upload_form_data
    @uploader = Photo.new.photo
    @uploader.success_action_status = '201'
    render json: {
      utf8: '',
      key: @uploader.key,
      AWSAccessKeyId: @uploader.aws_access_key_id,
      acl: @uploader.acl,
      policy: @uploader.policy,
      signature: @uploader.signature,
      success_action_status: @uploader.success_action_status
    }
  end

  def process_photo_upload

  end
end