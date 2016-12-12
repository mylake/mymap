class Place < ApplicationRecord
  belongs_to :map
  has_many :commands
end
