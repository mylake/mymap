class Map < ApplicationRecord
  has_many :places
  has_many :commands
end
