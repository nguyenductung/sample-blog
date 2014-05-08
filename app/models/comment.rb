class Comment < ActiveRecord::Base
  belongs_to :entry
  belongs_to :user
  validates :entry_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 6000 }
  default_scope -> { order('created_at DESC') }
end
