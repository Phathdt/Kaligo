class Supplier < ApplicationRecord
  has_many :offers
  has_many :hotels, through: :offers

  validates_uniqueness_of :name
end
