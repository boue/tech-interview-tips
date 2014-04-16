require 'spec_helper'

describe QuestionsController do

  before(:each) { QuestionsController.any_instance.stub(:check_current_user)
   }
      # Note: .and_return('variable')  can be added on to stub in line 5.  This is often needed for the stub to be correct.

  context "#index" do
    let(:user) { User.create name:"strand" }
    let(:first_question)  { Question.create user_id: user.id,
                                            title: "flab jab",
                                            tag_list: "jab" }
    let(:second_question) { Question.create user_id: user.id,
                                            title: "flib jib",
                                            tag_list: "jib" }
    let(:third_question) { Question.create user_id: user.id,
                                        title: "flib flab"}                                        
    context "by default" do
      # when I go to all questions '/questions'
      # then I expect to see all questions with answers

      before(:each) do
        answer = Answer.create user_id: user.id,
                               content: "foom",
                               question_id: second_question.id
        get :index
      end

      it "returns questions with answers" do
        expect(assigns(:questions)).to include(second_question)
      end

      it "does not return questions without answers" do
        expect(assigns(:questions)).to_not include(first_question)
      end

    end

    context "by search terms" do
      # When I search for 'ruby'
      # then I expect to see questions with the text 'ruby' in order of most answered.

      before(:each) do
        answer = Answer.create user_id: user.id,
                               content: "foom",
                               question_id: second_question.id
        second_answer = Answer.create user_id: user.id,
                               content: "foom",
                               question_id: first_question.id
        get :index, { search: "flab" }
      end

      it "returns questions with search text in title if they have answers" do
        expect(assigns(:questions)).to include(first_question)
      end

      it "does not return questions without search text in title" do
        expect(assigns(:questions)).to_not include(second_question)
      end

      it "does not return questions with search text in title if they do not have answers" do
        expect(assigns(:questions)).to_not include(third_question)
      end
    end

    context "unanswered questions" do
      # When I get unanswered questions
      # then I expect to see questions that don't have answers
      before(:each) do
        answer = Answer.create user_id: user.id,
                               content: "foom",
                               question_id: second_question.id
        get :index, { unanswered: "true" }
      end

      it "returns questions without answers" do
        expect(assigns(:questions)).to include(third_question)
      end

      it "does not return questions with answers" do
        expect(assigns(:questions)).to_not include(second_question)
      end
    end  

    context "sort by tags" do
      # When I search for tag of 'ruby'
      # then I expect to see questions with the tag of ruby in order of most answered.
      before(:each) do
        answer = Answer.create user_id: user.id,
                               content: "foom",
                               question_id: second_question.id
        second_answer = Answer.create user_id: user.id,
                               content: "foom",
                               question_id: first_question.id
        get :index, { tag: "jab" }
      end

      it "returns questions tagged with tag that was searched for" do
        expect(assigns(:questions)).to include(first_question)
      end

      it "does not return questions not tagged with searched for tag" do
        expect(assigns(:questions)).to_not include(second_question)
      end
    end
  end

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

