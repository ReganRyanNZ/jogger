require 'rails_helper'

describe Api::V1::UsersController do
  before(:each) { request.headers['Accept'] = "application/vnd.regan-ryan.v1" }

  describe "GET #show" do
    context "when requested by self" do
      before(:each) do
        @user = FactoryGirl.create :user
        request.headers['Authorization'] =  @user.auth_token
        get :show, params: {id: @user.id}, format: :json
      end

      it "returns the information about a user on a hash" do
        user_response = json_response
        expect(user_response[:email]).to eql @user.email
      end

      it "returns 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when requested by admin/manager" do
      [:admin, :manager].each do |role|
        before(:each) do
          @user = FactoryGirl.create :user
          @auth_user = FactoryGirl.create :user, role: role
          request.headers['Authorization'] =  @auth_user.auth_token

          get :show, params: {id: @user.id}, format: :json
        end

        it "returns the information about a user on a hash" do
          user_response = json_response
          expect(user_response[:email]).to eql @user.email
        end

        it "returns 200" do
          expect(response).to have_http_status(200)
        end
      end
    end

    context "when unauthorized" do
      before(:each) do
        @user = FactoryGirl.create :user
        @bad_user = FactoryGirl.create :user
        request.headers['Authorization'] =  @bad_user.auth_token

        get :show, params: {id: @user.id}, format: :json
      end

      it "returns 401" do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "POST #create" do

    context "when successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, params: { user: @user_attributes }, format: :json
      end

      it "renders the json representation for the user record just created" do
        user_response = json_response
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

      it "returns 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when not created" do
      before(:each) do
        #invalid with no email
        @invalid_user_attributes = { password: "12345678", password_confirmation: "12345678" }
        post :create, params: { user: @invalid_user_attributes }, format: :json
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it "returns 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      request.headers['Authorization'] =  @user.auth_token
    end

    context "when successfully updated" do
      before(:each) do
        patch :update, params: { id: @user.id, user: { email: "newmail@example.com" } }, format: :json
      end

      it "renders the json representation for the updated user" do
        user_response = json_response
        expect(user_response[:email]).to eql "newmail@example.com"
      end

      it "returns 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when updated by admin/manager" do
      [:admin, :manager].each do |role|
        before(:each) do
          @auth_user = FactoryGirl.create :user, role: role
          request.headers['Authorization'] =  @auth_user.auth_token

          patch :update, params: { id: @user.id, user: { email: "newmail@example.com" } }, format: :json
        end

        it "renders the json representation for the updated user" do
          user_response = json_response
          expect(user_response[:email]).to eql "newmail@example.com"
        end

        it "returns 200" do
          expect(response).to have_http_status(200)
        end
      end
    end

    context "when not updated" do
      before(:each) do
        patch :update, params: { id: @user.id, user: { email: "bademail.com" } }, format: :json
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end

      it "returns 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when deleted by self" do
      before(:each) do
        @user = FactoryGirl.create :user
        request.headers['Authorization'] =  @user.auth_token
        delete :destroy, params: { id: @user.id }, format: :json
      end

      it "returns 204" do
        expect(response).to have_http_status(204)
      end
    end

    context "when deleted by admin/manager" do
      [:admin, :manager].each do |role|
        before(:each) do
          @user = FactoryGirl.create :user
          @auth_user = FactoryGirl.create :user, role: role
          request.headers['Authorization'] =  @auth_user.auth_token

          delete :destroy, params: { id: @user.id }, format: :json
        end

        it "returns 204" do
          expect(response).to have_http_status(204)
        end
      end
    end

    context "when unauthorized" do
      before(:each) do
        @user = FactoryGirl.create :user
        @bad_user = FactoryGirl.create :user
        request.headers['Authorization'] =  @bad_user.auth_token

        delete :destroy, params: { id: @user.id }, format: :json
      end

      it "returns 401" do
        expect(response).to have_http_status(401)
      end
    end
  end
end