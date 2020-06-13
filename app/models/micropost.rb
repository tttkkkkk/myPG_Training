class Micropost < ApplicationRecord
  belongs_to :user
  has_many :links
  accepts_nested_attributes_for :links

  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true

  def self.search(params)
    micropost = Micropost
    micropost = micropost.where(category_id: params[:category_id]) if params[:category_id].present?    
    return micropost
  end
end
