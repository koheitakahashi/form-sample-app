class BookForm < YAAF::Form
  attr_accessor :id, :title, :description

  def initialize(attributes = nil, book: Book.new)
    @book = book

    if attributes.present?
      super(attributes)
    else
      self.id = @book.id
      self.title = @book.title
      self.description = @book.description
    end

    @book.assign_attributes(title: title, description: description)

    @models = [@book]
  end

  def to_model
    @book
  end
end
