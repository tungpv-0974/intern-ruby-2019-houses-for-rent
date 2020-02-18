require 'rails_helper'
include SessionsHelper

RSpec.describe PostsController, type: :controller do
  describe "GET #new" do
    let!(:user){FactoryBot.create :user}
    context "when loged in" do
      before do
        log_in user
        get :new
      end

      it "Return to success response" do
        expect(response).to  be_success
      end

      it "Render new form" do
        expect(response).to render_template :new
      end
    end

    context "when not loged in" do
      before {get :new}

      it "Redirect to login" do
        expect(response).to redirect_to login_path
      end
    end
  end
end
