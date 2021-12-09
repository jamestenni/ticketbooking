class OrderlineItemsController < ApplicationController
  before_action :set_orderline_item, only: %i[ show edit update destroy ]

  # GET /orderline_items or /orderline_items.json
  def index
    @orderline_items = OrderlineItem.all
  end

  # GET /orderline_items/1 or /orderline_items/1.json
  def show
  end

  # GET /orderline_items/new
  def new
    @orderline_item = OrderlineItem.new
  end

  # GET /orderline_items/1/edit
  def edit
  end

  # POST /orderline_items or /orderline_items.json
  def create
    @orderline_item = OrderlineItem.new(orderline_item_params)

    respond_to do |format|
      if @orderline_item.save
        format.html { redirect_to @orderline_item, notice: "Orderline item was successfully created." }
        format.json { render :show, status: :created, location: @orderline_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @orderline_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orderline_items/1 or /orderline_items/1.json
  def update
    respond_to do |format|
      if @orderline_item.update(orderline_item_params)
        format.html { redirect_to @orderline_item, notice: "Orderline item was successfully updated." }
        format.json { render :show, status: :ok, location: @orderline_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @orderline_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orderline_items/1 or /orderline_items/1.json
  def destroy
    @orderline_item.destroy
    respond_to do |format|
      format.html { redirect_to orderline_items_url, notice: "Orderline item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orderline_item
      @orderline_item = OrderlineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def orderline_item_params
      params.require(:orderline_item).permit(:order_id, :product_id, :price, :quantity)
    end
end
