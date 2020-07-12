class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :links
  mount_uploader :image , ImageUploader

  default_scope -> { order(created_at: :desc) }
  validates :user_id, :title, :content, presence: true
  validate  :image_size
  
  # アップロード画像のサイズを検証
  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "should be less than 5MB")
    end
  end

  def self.search(params)
    micropost = Micropost
    micropost = micropost.where(category_id: params[:category_id]) if params[:category_id].present?    
    return micropost
  end
end
