# Upload
# A file to be stored in the cloud via paperclip.
#
class Upload < ActiveRecord::Base
  # The model that this upload belongs to.
  belongs_to :uploadable, polymorphic: true

  # The paperclip file object itself.
  has_attached_file :file, styles: { medium: '300x300>', thumb: '50x50#' }
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

  # Delegate some of the methods to the paperclip object.
  delegate :url, to: :file

  # Delete the file before offing yourself.
  before_destroy do
    # TODO: Delete the file.
  end
end
