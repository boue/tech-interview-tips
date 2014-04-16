require 'spec_helper'

  describe FavoritesController do
    let!(:favorite) { FactoryGirl.create :favorite }
    let!(:user) { FactoryGirl.create :user }

    context "#destroy" do
      it "deletes the favorite" do
        expect{
          delete :destroy, id: user.id, favorite_id: favorite.id
        }.to change{ Favorite.count }.by(-1)
      end

    end

  end