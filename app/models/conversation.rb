class Conversation < ApplicationRecord
  belongs_to :user
  has_many :users, through: :participants
  has_many :participants, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  validates :title_1, presence: true
  validates :title_2, presence: true
  accepts_nested_attributes_for :participants, allow_destroy: true

  def self.find_by_participants(user1, user2)
    joins(:participants)
      .where(participants: { user_id: [user1.id, user2.id] })
      .group(:id)
      .having('COUNT(participants.id) = 2')
      .first
  end
end
