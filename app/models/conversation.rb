class Conversation < ApplicationRecord
  belongs_to :user

  has_many :users

  validates :title, presence: true

end
