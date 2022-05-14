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
    @form = ShopForm.new
  end

  # GET /shops/1/edit
  def edit
    @form = ShopForm.new(shop: Shop.find(params[:id]))
  end

  # POST /shops or /shops.json
  def create
    @form = ShopForm.new(shop_params)

    if @form.save
      redirect_to shop_path(@form.shop)
    else
      render :new
    end
  end

  # PATCH/PUT /shops/1 or /shops/1.json
  def update
    @form = ShopForm.new(shop_params, shop: Shop.find(params[:id]))

    if @form.save
      redirect_to shop_path(@form.shop)
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
