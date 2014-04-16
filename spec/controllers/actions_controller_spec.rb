require 'spec_helper'

describe ActionsController do
  let!(:action) { FactoryGirl.create :action }
  context "#index" do
    it "is successful" do
      get :index
      expect(response).to be_success
    end

    it "assigns actions to equal all actions" do
      get :index
      expect(assigns(:actions)).to match_array Action.all
    end
  end

end