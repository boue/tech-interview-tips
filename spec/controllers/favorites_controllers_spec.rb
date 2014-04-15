require 'spec_helper'

describe FavoritesController do
  context "#create" do
    let(:question) { FactoryGirl.create :question }
    it "should create a new favorite" do
    @user = FactoryGirl.create :user
      expect {
        FavoritesController.any_instance.stub(:current_user).and_return(@user)
        post(:create, question_id: question.id.to_s)
      }.to change{Favorite.count}.by(1)
    end

    it "should not create a new favorite if params are not provided" do
    @user = FactoryGirl.create :user
      expect {
        FavoritesController.any_instance.stub(:current_user).and_return(@user)
        post(:create, question_id: nil)
      }.to raise_error
    end
  end

end
