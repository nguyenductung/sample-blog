class Entry < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :title,   presence: true, length: { maximum: 200 }
  validates :content, presence: true, length: { maximum: 6000 }
  validates :user_id, presence: true
end
