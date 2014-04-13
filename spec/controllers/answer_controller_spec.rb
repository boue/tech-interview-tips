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

  # context "#new" do
  #   # problem due to no new view, instead is a partial _new
  #   it "is successful" do
  #     get :new
  #     expect(response).to render_template(partial: :_new)
  #   end

    # it "assigns @answer to the answer found by id" do
    #   get :new
    #   expect(assigns(:answer)).to be_a_new Answer
    # end
  # end

  context "#create" do
    before :each do
      @user = FactoryGirl.create :user
      @question = FactoryGirl.create :question
    end

  # needs work
    it "if given valid parameters, it creates a new answer" do
      expect {
        AnswersController.any_instance.stub(:current_user).and_return(@user)
        post(:create, answer: { content: "Test answer", question_id: @question.id.to_s }
          )
      }.to change{Answer.count}.by(1)
    end

  #   xit "if given invalid parameters, it renders new view" do
  #     expect {
  #       get
  #       post :create, :question => {}
  #         # , question: {:title => new_title , :content => nil} )
  #     }.to render_template :new
  #     end
  end

end
