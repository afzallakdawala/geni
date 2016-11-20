class User < ActiveRecord::Base
  has_many :timelogs, dependent: :destroy
  validates :name, presence: true, uniqueness: true, format: {with: /\A[a-zA-Z]*\z/, message: "no special characters or numbder, only letters"}
end
