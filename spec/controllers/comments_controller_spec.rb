require 'spec_helper'

describe CommentsController do
  let(:fake_comment){FactoryGirl.create(:comment)}
  let(:fake_question){FactoryGirl.create(:question)}

  context "show" do
    before(:each) { get :show, id: fake_comment.id }
    it "assigns fake_comment to a variable" do
      expect(assigns(:comment)).to eq fake_comment
    end

    it "renders fake_comment to json" do
      @comment = { comment: assigns(:comment) }.to_json
      expect(response.body).to eq @comment
    end
  end

  context "new" do
    before(:each) { get :new, id: fake_comment.id }
    it "renders comment to json" do
      @comment = { comment: assigns(:comment) }.to_json
      expect(response.body).to eq @comment
    end
  end

  context "#create" do
    before :each do
      @current_user = FactoryGirl.create(:user)
      controller.stub(:current_user).and_return(@current_user)
      @new_question = Question.create(user_id: @current_user.id,
                                      title: "What evs")
      @new_answer = Answer.create(user_id: @current_user.id,
                                  question_id: @new_question.id,
                                  content: "Evs")
      @comment_params = {
        comment: {
          question_id: @new_question.id,
          answer_id: @new_answer.id,
          content: "Wahhhh?",
          user_id: @current_user.id
        }
      }

      @comment_params2 = {
        comment: {
          question_id: @new_question.id,
          answer_id: @new_answer.id,
          user_id: @current_user.id
        }
      }
    end


    it "should create a new comment with correct params" do
      comment = Comment.new
      expect { post(:create, @comment_params) }.to change{Comment.count}.by(1)
    end

    it "should not create a new comment with incorrect params" do
      comment = Comment.new
      expect { post(:create, @comment_params2) }.to change{ Comment.count }.by(0)
    end

    it "should create a new action when a new comment is created" do
      comment = Comment.new
      expect { post(:create, @comment_params) }.to change{Action.count}.by(1)
    end
  end

  context "destroy" do
    before :each do
      @current_user = FactoryGirl.create(:user)
      controller.stub(:current_user).and_return(@current_user)
      @new_question = Question.create(user_id: @current_user.id,
                                      title: "What evs")
      @new_answer = Answer.create(user_id: @current_user.id,
                                  question_id: @new_question.id,
                                  content: "Evs")
      @comment_params = {
        comment: {
          question_id: @new_question.id,
          answer_id: @new_answer.id,
          content: "Wahhhh?",
          user_id: @current_user.id
        }
      }

      @kill_this = post(:create, @comment_params)
    end

    xit "should delete a comment" do
      comment = Comment.find(@kill_this.id)
      expect { comment.destroy }.to change{Comment.count}.by(-1)
    end

    it "doesn't redirect if comment is not deleted correctly" do
      expect{
          delete :destroy, id: fake_comment.id, comment: fake_comment
          }.not_to redirect_to("/")
          # seperate test response.status.should be(200)
    end
  end

end