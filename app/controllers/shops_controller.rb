class ShopsController < ApplicationController
  before_action :set_shop, only: %i[ show edit update destroy ]

  # GET /shops or /shops.json
  def index
    @shops = Shop.all
  end

  # GET /shops/1 or /shops/1.json
  def show
  end

  # GET /shops/new
  def new
    books = (1..2).map { Book.new }
    @form = ShopForm.new(Shop.new(books: books))
  end

  # GET /shops/1/edit
  def edit
    @form = ShopForm.new(Shop.find(params[:id]))
  end

  # POST /shops or /shops.json
  def create
    books = (1..2).map { Book.new }
    @form = ShopForm.new(Shop.new(books: books))

    if @form.validate(shop_params)
      @form.save
      redirect_to shop_path(@form.model)
    else
      render :new
    end
  end

  # PATCH/PUT /shops/1 or /shops/1.json
  def update
    @form = ShopForm.new(Shop.find(params[:id]))

    if @form.validate(shop_params)
      @form.save
      redirect_to shop_path(@shop)
    else
      render :edit
    end
  end

  # DELETE /shops/1 or /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, notice: "Shop was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shop_params
      params.fetch(:shop, {}).permit(:id, :name, :address, books_attributes: [:id, :title, :description])
    end
end
