class AnswerSerializer < ActiveModel::Serializer
  attributes :content, :url

  def url
   answer_url(object)
  end

end