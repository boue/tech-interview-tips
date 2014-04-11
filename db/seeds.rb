# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = ["Ruby", "Javascript", "Object Oriented Programming", "Design Patterns", "Ruby on Rails", "Algorithms", "Miscellaneous", ]

categories.each do |category|
  Category.create(content: category)
end

questions = ["What is the difference between a symbol and string?", "What are class variables? How do you define them?", "What is restful routing?", "How can you implement caching in rails?", "What is a polymorphic association?"]

questions.each do |question|
  Question.create(title: question, content: question, views: 1, user_id: 1)
end
