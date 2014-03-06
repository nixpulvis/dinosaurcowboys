# Upload
# A file to be stored in the cloud via paperclip.
#
class Upload < ActiveRecord::Base
  # The user that created this upload.
  belongs_to :user

  # The paperclip file object itself.
  has_attached_file :file, styles: { medium: '300x300>', thumb: '50x50#' }
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

  # Delegate some of the methods to the paperclip object.
  delegate :url, to: :file
end
