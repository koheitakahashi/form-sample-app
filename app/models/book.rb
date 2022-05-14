class Book < ApplicationRecord
  belongs_to :shop

  validates :title, presence: true
end
