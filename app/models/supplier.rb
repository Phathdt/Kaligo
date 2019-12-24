class Supplier < ApplicationRecord
  has_many :offers
  has_many :hotels, through: :offers
end
