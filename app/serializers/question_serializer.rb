class QuestionSerializer < ActiveModel::Serializer
  attributes :title, :content, :url

  has_many :answers, serializer: AnswerSerializer

  # embed :ids

  def url
    question_url(object)
  end

  # def search
  # end


end