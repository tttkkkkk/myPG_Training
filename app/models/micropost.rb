class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :links, dependent: :destroy
  mount_uploader :image , ImageUploader

  default_scope -> { order(created_at: :desc) }
  validates :user_id, :category_id, :title, :content, presence: true
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

  # CSV_HEADER
  CSV_EXPORT_HEADER = [
    'ID', '内容', 'ユーザーID', 'コード', '件名', 'カテゴリID'
  ]
  HEADER_COLUMN_MAPPING = {
    'ID' => 'id','内容' => 'content','ユーザーID' => 'user_id', 'コード' => 'code', '件名' => 'title', 'カテゴリID' => 'category_id'
  }
  def to_export_row
    [id, content, user_id, code ,title ,category_id]
  end

end
