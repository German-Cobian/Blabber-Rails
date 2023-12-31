class Conversation < ApplicationRecord
  belongs_to :user
  has_many :users, through: :participants
  has_many :participants, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  validates :title, presence: true
  accepts_nested_attributes_for :participants
end
