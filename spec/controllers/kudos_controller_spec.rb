require 'spec_helper'

describe KudosController do
  before(:each) { KudosController.any_instance.stub(:check_current_user)
   }

  context "#create" do

    # before :each do
    #   new_user = FactoryGirl.create(:user)
    #   new_answer = FactoryGirl.create(:answer)
    # end

    context "when an answer is given" do
      before :each do
        new_user = FactoryGirl.create(:user)
        new_question = Question.create(user_id: new_user.id, title: "What evs")
        new_answer = Answer.create(user_id: new_user.id, question_id: new_question.id, content: "Evs")
      end

      context "when the current user has not given kudos to the answer" do

        it "creates a new kudo" do
          expect {
            post :create, :kudosible_id => new_answer.id,
                          :user_id => new_user.id
          }.to change { Kudo.count }.by(1)
        end

      end

      context "when the current user has given kudos to the answer" do

        it "does not create a new kudo" do
          Kudo.create(kudosible_id: new_answer.id, user_id: new_user.id)
          expect {
            post :create, :kudosible_id => new_answer.id,
                          :user_id => new_user.id
          }.not_to change { Kudo.count }.by(1)
        end
      end

    end


    # context "when default params are provided" do
    #   context "when the current user has not given kudos to the question" do
    #     it "creates a new kudo"
    #   end

    #   context "when the current user has given kudos to the question" do
    #     it "does not create a new kudo"
    #   end
    # end

  end

end