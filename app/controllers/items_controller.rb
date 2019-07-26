class ItemsController < ApplicationController
  before_action :set_list
  before_action :set_item, only: [:show, :edit, :update, :destroy, :soft_destroy]
  before_action :set_deleted_item, only: %i[restore]

  # GET /tasks
  # GET /tasks.json
  def index
    @items = Item.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @item = Item.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @item = @list.items.new(item_params)

    respond_to do |format|
      if @item.save
        @items = @list.items
        format.js
      else
        format.js { render json: @item.errors }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.js
      else
        format.js { render json: @item.errors }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @item.hard_delete
    respond_to do |format|
      format.js
    end
  end

  def soft_destroy
    @item.soft_delete
    respond_to do |format|
      format.js { render "items/destroy.js.erb" }
    end
  end

  def restore
    @item.restore
    respond_to do |format|
      format.js { render "items/destroy.js.erb" }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:name)
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_deleted_item
    @item = Item.only_deleted.find(params[:id])
  end
end
