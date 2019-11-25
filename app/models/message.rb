class Message < ApplicationRecord
  validates :body, presence: true, unless: :image_presence?
  belongs_to :user
  belongs_to :group
  mount_uploader :image, ImageUploader

  def image_presence?
    image.file.present?
  end
end
