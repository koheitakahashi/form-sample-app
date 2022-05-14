class ShopForm < Reform::Form
  property :name
  validates :name, presence: true

  property :address
  validates :address, presence: true

  collection :books do
    property :title
    validates :title, presence: true
    property :description
  end
end
