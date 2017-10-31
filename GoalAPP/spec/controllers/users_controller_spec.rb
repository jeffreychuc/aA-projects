require 'spec_helper'
require 'rails_helper'


RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders the new template" do
      get :new, {}
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's email and password" do
        post :create, params: { user: { username: "mr.puddles", password: "" } }
        expect(response).to render_template("new")
        #errors present because of no password
        expect(flash[:errors]).to be_present
      end
      it "validates that the password is at least 6 characters long" do
        post :create, params: { user: { username: "mr.puddles", password: "aaaaa" } }
        expect(response).to render_template("new")
        #errors present because of no password
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects user to user show on success" do
        post :create, params: { user: { username: "mr.boots", password: "password" } }
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end
end
