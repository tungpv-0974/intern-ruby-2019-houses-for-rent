require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST #create" do
    let!(:user){FactoryBot.create :user}
    describe "Login success" do
      before{post :create, params:{session:{email: user.email, password: user.password, remember_me: 0}}}

      context "Return to success response" do
        it{expect(response.status).to eq 302}
      end

      context "Check login success" do
        it{expect(session[:user_id]).to eq user.id}
      end

      context "Check remember" do
        it{expect(cookies.permanent[:remember_token]).to eq user.remember_token}
      end

      context "Redirect to home page" do
        it{expect(response).to redirect_to user}
      end
    end

    describe "Login fail" do
      context "Invalid email" do
        before{post :create, params:{session:{email: nil, password: "123456", remember_me: 0}}}

        it{expect(response).to render_template :new}
      end

      context "Invalid password" do
        before{post :create, params:{session:{email: user.email, password: nil, remember_me: 0}}}

        it{expect(response).to render_template :new}
      end
    end
  end
end
