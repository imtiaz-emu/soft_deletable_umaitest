class TrashController < ApplicationController
  def index
    @lists = List.includes(:items).only_deleted
    @items = Item.includes(:list).only_deleted.collect{|item| item unless item.list.is_deleted}.compact
  end
end