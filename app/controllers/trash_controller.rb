class TrashController < ApplicationController
  def index
    @lists = List.includes(:items).only_deleted
    @items = Item.only_deleted
  end
end