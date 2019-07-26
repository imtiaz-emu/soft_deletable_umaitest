require 'rails_helper'
require 'faker'


RSpec.describe ListsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # List. As you add validations to List, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
        title: Faker::Lorem.sentence,
        description: Faker::Movie.quote,
        is_deleted: false
    }
  }

  let(:invalid_attributes) {
    {
        title: '',
        description: Faker::Movie.quote,
        is_deleted: false
    }
  }

  let(:item_valid_attributes) {
    {
        name: Faker::Lorem.sentence,
        is_deleted: false
    }
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all lists as @lists" do
      list = List.create! valid_attributes
      get :index, {}
      expect(assigns(:lists)).to eq([list])
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new List" do
        expect {
          post :create, xhr: true, params: {list: valid_attributes}
        }.to change(List, :count).by(1)
      end

      it "assigns a newly created list as @list" do
        post :create, xhr: true, params: {list: valid_attributes}
        expect(assigns(:list)).to be_a(List)
        expect(assigns(:list)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved list as @list" do
        post :create, xhr: true, params: {list: invalid_attributes}
        expect(response.status).to eql(200)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {
            title: Faker::Lorem.sentence
        }
      }

      it "updates the requested group" do
        list = List.create! valid_attributes
        put :update, xhr: true, params: {id: list.to_param, list: new_attributes}
        list.reload
      end

      it "assigns the requested list as @list" do
        list = List.create! valid_attributes
        put :update, xhr: true, params: {id: list.to_param, list: valid_attributes}
        expect(assigns(:list)).to eq(list)
      end

      it "send a succss response" do
        list = List.create! valid_attributes
        put :update, xhr: true, params: {id: list.to_param, list: valid_attributes}
        expect(response.status).to eql(200)
      end
    end

    describe "with invalid params" do
      it "assigns the list as @list" do
        list = List.create! valid_attributes
        put :update, xhr: true, params: {id: list.to_param, list: invalid_attributes}
        expect(assigns(:list)).to eq(list)
      end

      it "send a success response" do
        list = List.create! valid_attributes
        put :update, xhr: true, params: {id: list.to_param, list: invalid_attributes}
        expect(response.status).to eql(200)
      end
    end
  end

  describe "DELETE hard delete" do
    it "destroys the requested list" do
      list = List.create! valid_attributes
      expect {
        delete :destroy, xhr: true, params: {id: list.to_param}
      }.to change(List, :count).by(-1)
    end

    it "destroys the requested list and its items" do
      list = List.create! valid_attributes
      2.times {list.items.create! item_valid_attributes}
      expect {
        delete :destroy, xhr: true, params: {id: list.to_param}
      }.to change(Item, :count).by(-2)
    end
  end

  describe "DELETE soft delete" do
    it "soft deletes the requested list" do
      list = List.create! valid_attributes
      expect {
        delete :soft_destroy, xhr: true, params: {id: list.to_param}
      }.to change(List.only_deleted, :count).by(1)
    end

    it "soft deletes the requested list and its items" do
      list = List.create! valid_attributes
      2.times {list.items.create! item_valid_attributes}
      expect {
        delete :soft_destroy, xhr: true, params: {id: list.to_param}
      }.to change(Item.only_deleted, :count).by(2)
    end
  end

  describe "Restore List" do
    it "restore the requested list" do
      list = List.create! valid_attributes.merge(is_deleted: true)
      expect {
        patch :restore, xhr: true, params: {id: list.to_param}
      }.to change(List.not_deleted, :count).by(1)
    end

    it "restore the requested list and its items" do
      list = List.create! valid_attributes.merge(is_deleted: true)
      2.times {list.items.create! item_valid_attributes.merge(is_deleted: true)}
      expect {
        patch :restore, xhr: true, params: {id: list.to_param}
      }.to change(list.items.not_deleted, :count).by(2)
    end
  end

end