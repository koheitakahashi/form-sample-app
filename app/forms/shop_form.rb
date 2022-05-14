class ShopForm < YAAF::Form
  attr_accessor :shop, :id, :name, :address
  attr_writer :shops_attributes, :books_attributes

  validates :name, presence: true
  validates :address, presence: true

  delegate :persisted?, to: :shop

  def initialize(attributes = nil, shop: Shop.new)
    @shop = shop
    @attributes = (attributes || {})

    if attributes.present?
      super(shop_attributes)
    else
      self.id = @shop.id
      self.name = @shop.name
      self.address = @shop.address
    end

    @shop.assign_attributes(name: name, address: address)

    super(@attributes)

    @models = [@shop, books].flatten
  end

  def books
    return @books if defined?(@books)
    @books = []

    if shop.books.present?
      shop.books.each do |book|
        attr = books_attributes.values&.find { |val| val["id"].to_i == book.id }
        @books << BookForm.new(attr, book: book)
      end
    else
      2.times { @books << BookForm.new(books_attributes&.dig(_1.to_s), book: shop.books.build) }
    end

    @books
  end

  def to_model
    shop
  end

  private

  def shop_attributes
    @shop_attributes ||= { name: @attributes[:name], address: @attributes[:address] }
  end

  def books_attributes
    @books_attributes ||= (@attributes[:books_attributes] || {} )
  end
end
