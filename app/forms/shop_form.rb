class ShopForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :shop

  attribute :name, :string
  attribute :address, :string

  validates :name, presence: true
  validates :address, presence: true

  delegate :persisted?, to: :shop

  def initialize(attributes = nil, shop: Shop.new)
    @shop = shop
    @books = shop.books
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return false if invalid? || invalid_books?

    ActiveRecord::Base.transaction do
      shop.assign_attributes(attributes)
      shop.save!
      @books.each(&:save!) if @books.present?
    end

    true
  end

  def to_model
    shop
  end

  def books
    if shop.books.present?
      shop.books
    else
      Array.new(2, Book.new)
    end
  end

  def books_attributes=(attributes)
    attributes.each do |_i, book_params|
      if book_params['id'].nil?
        shop.books.build(book_params)
        next
      else
        @books.find { _1.id == book_params['id'].to_i }.assign_attributes(book_params)
      end
    end
  end

  private

  def default_attributes
    {
      name: shop.name,
      address: shop.address,
    }
  end

  def invalid_books?
    results = @books.map do |book|
      next false unless book.invalid?

      errors.add(:books, book.errors.full_messages.join)
      true
    end

    results.any?
  end
end
