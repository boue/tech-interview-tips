require 'spec_helper'

describe KudosController do
  context "#create" do
    before :each do
      @current_user = FactoryGirl.create(:user)
      controller.stub(:current_user).and_return(@current_user)
      @new_question = Question.create(user_id: @current_user.id,
                                      title: "What evs")
      @new_answer = Answer.create(user_id: @current_user.id,
                                  question_id: @new_question.id,
                                  content: "Evs")
    end
    context "when an answer is given" do
      before :each do
        @answer_params = { answer_id: @new_answer.id,
                           user_id: @current_user.id,
                           kudosible_id: @new_answer.id,
                           kudosible_type: "answer" }
      end
      context "when the current user kudos an answer" do
        it "creates a new kudo for an unkudo-ed answer" do
          expect { post :create, @answer_params }.to change { Kudo.count }.by(1)
        end

        it "does not create a new kudo a kudo-ed answer" do
          kudo = Kudo.new
          kudo.user_id = @current_user.id
          @new_answer.kudos << kudo
          kudo.save
          expect { post :create, @answer_params }.to change { Kudo.count }.by(0)
        end

        it "creates a new action when a new kudo is given" do
          expect { post :create, @answer_params }.to change { Action.count }.by(1)
        end
      end
    end
    context "when a question is given" do
      before :each do
        @question_params = {  question_id: @new_question.id,
                              user_id: @current_user.id,
                              kudosible_id: @new_question.id,
                              kudosible_type: "question" }
      end
      context "when the current user kudos a question" do
        it "creates a new kudo for a unkudo-ed question" do
          expect { post :create, @question_params }.to change { Kudo.count }.by(1)
        end

        it "does not create for a new kudo for a kudo-ed question" do
          kudo = Kudo.new
          kudo.user_id = @current_user.id
          @new_question.kudos << kudo
          kudo.save
          expect { post :create, @question_params }.to change { Kudo.count }.by(0)
        end
      end
    end
  end
end