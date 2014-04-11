require 'spec_helper'

describe QuestionsController do

  context "#show" do
    let(:question) { FactoryGirl.create :question }
    it "is successful" do
      get :show, id: question.id
      expect(response).to render_template(:show)
    end

    it "assigns @question to the Question found by id" do
      get :show, id: question.id
      expect(assigns(:question)).to eq question
    end
  end

  context "#new" do
    it "is successful" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns @question to the Question found by id" do
      get :new
      expect(assigns(:question)).to be_a_new Question
    end
  end

  context "#create" do
    before :each do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
    end

    it "if given valid parameters, it creates a new question" do
      expect {
        post(:create, question: FactoryGirl.attributes_for(:question))
      }.to change{Question.count}.by(1)
    end

    xit "if given invalid parameters, it renders new view" do
      expect {
        get
        post :create, :question => {}
          # , question: {:title => new_title , :content => nil} )
      }.to render_template :new
      end
    end

end
