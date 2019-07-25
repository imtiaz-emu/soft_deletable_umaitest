require 'rails_helper'
require 'faker'


RSpec.describe ListsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # List. As you add validations to List, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
        title: Faker::Lorem.sentence,
        description: Faker::LordOfTheRings.quote,
        is_deleted: false
    }
  }

  let(:invalid_attributes) {
    {
        title: '',
        description: Faker::LordOfTheRings.quote,
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

  describe "GET show" do
    it "assigns the requested list as @list" do
      list = List.create! valid_attributes
      get :show, params: {id: list.to_param}
      expect(assigns(:list)).to eq(list)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new List" do
        expect {
          post :create, params: {list: valid_attributes}
        }.to change(List, :count).by(1)
      end

      it "assigns a newly created list as @list" do
        post :create, params: {list: valid_attributes}
        expect(assigns(:list)).to be_a(List)
        expect(assigns(:list)).to be_persisted
      end

      it "redirects to the created list" do
        post :create, params: {list: valid_attributes}
        expect(response.status).to eql(201)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved list as @list" do
        post :create, params: {list: invalid_attributes}
        expect(assigns(:list)).to be_a_new(List)
      end

      it "re-renders the 'new' template" do
        post :create, params: {list: invalid_attributes}
        expect(response.status).to eql(422)
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
        put :update, params: {id: list.to_param, list: new_attributes}
        list.reload
      end

      it "assigns the requested list as @list" do
        list = List.create! valid_attributes
        put :update, params: {id: list.to_param, list: valid_attributes}
        expect(assigns(:list)).to eq(list)
      end

      it "redirects to the list" do
        list = List.create! valid_attributes
        put :update, params: {id: list.to_param, list: valid_attributes}
        expect(response.status).to eql(200)
      end
    end

    describe "with invalid params" do
      it "assigns the list as @list" do
        list = List.create! valid_attributes
        put :update, params: {id: list.to_param, list: invalid_attributes}
        expect(assigns(:list)).to eq(list)
      end

      it "re-renders the 'edit' template" do
        list = List.create! valid_attributes
        put :update, params: {id: list.to_param, list: invalid_attributes}
        expect(response.status).to eql(422)
      end
    end
  end

  describe "DELETE completely destroy" do
    it "destroys the requested list" do
      list = List.create! valid_attributes
      expect {
        delete :completely_delete, params: {id: list.to_param}
      }.to change(List, :count).by(-1)
    end

    it "redirects to the lists list" do
      list = List.create! valid_attributes
      delete :completely_delete, params: {id: list.to_param}
      expect(response.status).to eql(204)
    end
  end

end