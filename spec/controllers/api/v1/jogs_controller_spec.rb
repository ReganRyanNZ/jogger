require 'rails_helper'

describe Api::V1::JogsController do
  before(:each) { request.headers['Accept'] = "application/vnd.regan-ryan.v1" }

  describe "GET #show" do
    context "when requested by owner" do
      before(:each) do
        @user = FactoryGirl.create :user
        @jog = FactoryGirl.create :jog, user: @user
        request.headers['Authorization'] =  @user.auth_token
        get :show, params: {id: @jog.id}, format: :json
      end

      it "returns the information about a jog on a hash" do
        jog_response = json_response
        expect(jog_response[:time]).to eql @jog.time
      end

      it "returns 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when requested by admin/manager" do
      [:admin, :manager].each do |role|
        before(:each) do
          @user = FactoryGirl.create :user
          @jog = FactoryGirl.create :jog, user: @user
          @auth_user = FactoryGirl.create :user, role: role
          request.headers['Authorization'] =  @auth_user.auth_token

          get :show, params: {id: @jog.id}, format: :json
        end

        it "returns the information about a jog on a hash" do
          jog_response = json_response
          expect(jog_response[:time]).to eql @jog.time
        end

        it "returns 200" do
          expect(response).to have_http_status(200)
        end
      end
    end

    context "when unauthorized" do
      before(:each) do
        @user = FactoryGirl.create :user
        @jog = FactoryGirl.create :jog, user: @user
        @bad_user = FactoryGirl.create :user
        request.headers['Authorization'] =  @bad_user.auth_token

        get :show, params: {id: @jog.id}, format: :json
      end

      it "returns 401" do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "POST #create" do

    context "when successfully created" do
      before(:each) do
        @user = FactoryGirl.create :user
        @jog_attributes = FactoryGirl.attributes_for :jog
        request.headers['Authorization'] =  @user.auth_token
        post :create, params: { jog: @jog_attributes }, format: :json
      end

      it "renders the json representation for the user record just created" do
        jog_response = json_response
        expect(jog_response[:time]).to eql @jog_attributes[:time]
      end

      it "returns 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when not created" do
      before(:each) do
        @user = FactoryGirl.create :user
        request.headers['Authorization'] =  @user.auth_token
        @invalid_jog_attributes = { distance: 12345, date: "2016-01-09 10:30:14" } # no time
        post :create, params: { jog: @invalid_jog_attributes }, format: :json
      end

      it "renders an errors json" do
        jog_response = json_response
        expect(jog_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        jog_response = json_response
        expect(jog_response[:errors][:time]).to include "can't be blank"
      end

      it "returns 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @jog = FactoryGirl.create :jog, user: @user
      request.headers['Authorization'] =  @user.auth_token
    end

    context "when successfully updated" do
      before(:each) do
        patch :update, params: { id: @jog.id, jog: { time: 2000 } }, format: :json
      end

      it "renders the json representation for the updated jog" do
        jog_response = json_response
        expect(jog_response[:time]).to eql 2000
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

          patch :update, params: { id: @jog.id, jog: { time: 2000 } }, format: :json
        end

        it "renders the json representation for the updated jog" do
          jog_response = json_response
          expect(jog_response[:time]).to eql 2000
        end

        it "returns 200" do
          expect(response).to have_http_status(200)
        end
      end
    end

    context "when not updated" do
      before(:each) do
        patch :update, params: { id: @jog.id, jog: { time: nil } }, format: :json
      end

      it "renders an errors json" do
        jog_response = json_response
        expect(jog_response).to have_key(:errors)
      end

      it "returns 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when deleted by owner" do
      before(:each) do
        @user = FactoryGirl.create :user
        @jog = FactoryGirl.create :jog, user: @user
        request.headers['Authorization'] =  @user.auth_token
        delete :destroy, params: { id: @jog.id }, format: :json
      end

      it "returns 204" do
        expect(response).to have_http_status(204)
      end
    end

    context "when deleted by admin/manager" do
      [:admin, :manager].each do |role|
        before(:each) do
          @user = FactoryGirl.create :user
          @jog = FactoryGirl.create :jog, user: @user
          @auth_user = FactoryGirl.create :user, role: role
          request.headers['Authorization'] =  @auth_user.auth_token

          delete :destroy, params: { id: @jog.id }, format: :json
        end

        it "returns 204" do
          expect(response).to have_http_status(204)
        end
      end
    end

    context "when unauthorized" do
      before(:each) do
        @user = FactoryGirl.create :user
        @jog = FactoryGirl.create :jog, user: @user
        @bad_user = FactoryGirl.create :user
        request.headers['Authorization'] =  @bad_user.auth_token

        delete :destroy, params: { id: @jog.id }, format: :json
      end

      it "returns 401" do
        expect(response).to have_http_status(401)
      end
    end
  end
end