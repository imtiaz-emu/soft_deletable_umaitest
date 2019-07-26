require 'rails_helper'
require 'faker'

RSpec.describe ItemsController, type: :controller do

  let(:valid_attributes) {
    {
        name: Faker::Lorem.sentence,
        is_deleted: false
    }
  }

  let(:invalid_attributes) {
    {
        name: nil,
        is_deleted: false
    }
  }

  let(:list_valid_attributes) {
    {
        title: Faker::Lorem.sentence,
        description: Faker::Movie.quote,
        is_deleted: false
    }
  }

  let(:valid_session) { {} }

  before(:each) do
    @list = List.create! list_valid_attributes
  end

  describe "GET #edit" do
    it "returns a success response" do
      item = @list.items.create! valid_attributes
      get :edit, xhr: true, params: {id: item.to_param, list_id: @list.to_param}
      expect(response).to be_successful
    end

    it "raises a routing error" do
      item = @list.items.create! valid_attributes
      expect {
        get :edit, xhr: true, params: {id: item.to_param}
      }.to raise_error(ActionController::UrlGenerationError)
    end

    it "raises a validation error" do
      expect {
        item = Item.create! valid_attributes
        get :edit, xhr: true, params: {id: item.to_param, list_id: @list.to_param}
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end


  describe "POST #create" do
    context "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, xhr: true, params: {item: valid_attributes, list_id: @list.to_param}
        }.to change(Item, :count).by(1)
      end

      it "creates a neew item under a list" do
        expect {
          post :create, xhr: true, params: {item: valid_attributes, list_id: @list.to_param}
        }.to change(@list.items.not_deleted, :count).by(1)
      end
    end

    context "with invalid params" do
      it "returns a routing error" do
        expect{
          post :create, xhr: true, params: {item: valid_attributes}
        }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
            name: Faker::Movie.quote
        }
      }

      it "updates the requested item" do
        item = @list.items.create! valid_attributes
        put :update, xhr: true, params: {id: item.to_param, item: new_attributes, list_id: @list.to_param}
        item.reload
      end

      it "sends a success response" do
        item = @list.items.create! valid_attributes
        put :update, xhr: true, params: {id: item.to_param, item: new_attributes, list_id: @list.to_param}
        expect(response.status).to eql(200)
      end
    end

    context "with invalid params" do
      it "should response a validation error" do
        item = @list.items.create! valid_attributes
        item.update(invalid_attributes)
        expect(item.errors.messages).to eq({:name=>["can't be blank"]})
      end
    end
  end

  describe "DELETE Hard Destory" do
    it "destroys the requested item" do
      item = @list.items.create! valid_attributes
      expect {
        delete :destroy, xhr: true, params: {id: item.to_param, list_id: @list.to_param}
      }.to change(Item, :count).by(-1)
    end

    it "removes item from the list" do
      2.times {@list.items.create! valid_attributes}
      expect {
        delete :destroy, xhr: true, params: {id: Item.last.to_param, list_id: @list.to_param}
      }.to change(@list.items, :count).by(-1)
    end
  end

  describe "DELETE Soft Destory" do
    it "destroys the requested item" do
      item = @list.items.create! valid_attributes
      expect {
        delete :destroy, xhr: true, params: {id: item.to_param, list_id: @list.to_param}
      }.to change(Item, :count).by(-1)
    end

    it "removes item from the list" do
      2.times {@list.items.create! valid_attributes}
      expect {
        delete :destroy, xhr: true, params: {id: Item.last.to_param, list_id: @list.to_param}
      }.to change(@list.items, :count).by(-1)
    end
  end

  describe "Restore Item" do
    it "restore the requested list" do
      3.times {@list.items.create! valid_attributes.merge(is_deleted: true)}
      expect {
        patch :restore, xhr: true, params: {id: Item.last.to_param, list_id: @list.to_param}
      }.to change(@list.items.not_deleted, :count).by(1)
    end
  end

end
