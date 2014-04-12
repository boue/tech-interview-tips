class QuestionSerializer < ActiveModel::Serializer
  attributes :title, :content, :url

  has_many :answers

  # embed :ids

  def url
    question_url(object)
  end

end