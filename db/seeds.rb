10.times do |iteration|
  article = Article.new
  article.title = Faker::Lorem.sentence
  article.content = Faker::Lorem.paragraph
  article.save!
end
