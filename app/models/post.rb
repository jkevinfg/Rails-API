class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true 
  validates :content, presence: true
  validates :published, inclusion: { in: [true, false] } #for booleans 
  validates :user_id, presence: true 
end
