class Command < ApplicationRecord
  belongs_to :map
  belongs_to :place
end
