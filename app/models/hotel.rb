class Hotel < ApplicationRecord
  has_many :offers
  has_many :suppliers, through: :offers

  validates_uniqueness_of :name
end
