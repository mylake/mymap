class Place < ApplicationRecord
  belongs_to :map
  belongs_to :user
  has_many :commands
end
