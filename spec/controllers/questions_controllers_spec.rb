require 'spec_helper'

describe QuestionsController do

  before(:each) { QuestionsController.any_instance.stub(:check_current_user)
   }
      # Note: .and_return('variable')  can be added on to stub in line 5.  This is often needed for the stub to be correct.

  context "#show" do
    let(:question) { FactoryGirl.create :question }
    xit "is successful" do
      QuestionsController.any_instance.stub(:set_question_redirect)
      get :show, id: question.id
      expect(response).to render_template(:show)
    end

    xit "assigns @question to the Question found by id" do
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

    it "if given invalid parameters, it renders new view" do
      get :new
      expect {
        post :create, :question => {}
          # , question: {:title => new_title , :content => nil} )
      }.to render_template :new
    end

    it "creates a new action as a result of creating a new question" do
      expect {
        post(:create, question: FactoryGirl.attributes_for(:question))
        }.to change{ Action.count }.by(1)
    end

  end

end

