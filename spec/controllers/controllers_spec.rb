require 'spec_helper'

describe QuestionsController do

  context "#show" do
    let(:question) { FactoryGirl.create :question }
    it "is successful" do
      get :show, id: question.id
      expect(response).to be_success
    end

    it "assigns @question to the Question found by id" do
      get :show, id: question.id
      expect(assigns(:question)).to eq question
    end
  end

  context "#create" do
    it "if given valid parameters, it creates a new question" do
      expect {
        post(:create, question: FactoryGirl.attributes_for(:question))
      }.to change{Question.count}.by(1)
    end
  end

end