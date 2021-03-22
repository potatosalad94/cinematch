class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :watchlists
  has_many :movies, through: :watchlists

  has_many :events, dependent: :destroy
  has_and_belongs_to_many :attended_events, class_name: 'Event'

  has_many :friend_sent, class_name: 'Friendship',
                         foreign_key: 'sent_by_id',
                         inverse_of: 'sent_by',
                         dependent: :destroy
  has_many :friend_request, class_name: 'Friendship',
                            foreign_key: 'sent_to_id',
                            inverse_of: 'sent_to',
                            dependent: :destroy
  has_many :friends, -> { merge(Friendship.friends) },
           through: :friend_sent, source: :sent_to
  has_many :pending_requests, -> { merge(Friendship.not_friends) },
           through: :friend_sent, source: :sent_to
  has_many :received_requests, -> { merge(Friendship.not_friends) },
           through: :friend_request, source: :sent_by

  validates :email, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
