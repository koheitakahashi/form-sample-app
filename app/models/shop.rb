class Shop < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :books
end
