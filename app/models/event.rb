class Event < ApplicationRecord
  has_one_attached :photo
  validates :name, presence: { message: "Event name can't be blank!" }

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_and_belongs_to_many :attendees, class_name: 'User'
end
