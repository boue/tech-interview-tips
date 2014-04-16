require 'spec_helper'

describe AnswersController do
  render_views

  context "#show" do
    let(:answer) { FactoryGirl.create :answer }
    it "is successful" do
      get :show, id: answer.id
      expect(response).to render_template(:show)
    end

    it "assigns @answer to the answer found by id" do
      get :show, id: answer.id
      expect(assigns(:answer)).to eq answer
    end
  end

  context "#create" do
    before :each do
      @user = FactoryGirl.create :user
      @question = FactoryGirl.create :question
    end

    it "if given valid parameters, it creates a new answer" do
      expect {
        AnswersController.any_instance.stub(:current_user).and_return(@user)
        post(:create, answer: { content: "Test answer", question_id: @question.id.to_s }
          )
      }.to change{Answer.count}.by(1)
    end

    it "creates a new action as a result of creating a new answer" do
      expect {
        AnswersController.any_instance.stub(:current_user).and_return(@user)
        post(:create, answer: { content: "Test answer", question_id: @question.id.to_s }
          )
        }.to change{ Action.count }.by(1)
    end
  end

end
