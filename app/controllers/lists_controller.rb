class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy, :soft_destroy]
  before_action :set_deleted_list, only: %i[restore]

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.includes(:items).all
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        @lists = List.all
        format.js
      else
        format.js { render json: @list.errors}
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        @lists = List.all
        format.js
      else
        format.js { render json: @list.errors }
      end
    end
  end


  def destroy
    @list.hard_delete
  end

  def soft_destroy
    @list.soft_delete

    respond_to do |format|
      format.js { render "lists/destroy.js.erb" }
    end
  end

  def restore
    @list.restore
    respond_to do |format|
      format.js { render "lists/destroy.js.erb" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    def set_deleted_list
      @list = List.only_deleted.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:title, :description, :is_deleted)
    end
end
