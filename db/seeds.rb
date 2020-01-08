20.times do |n|
  name  = FFaker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "123456"
  user = User.create!(first_name: name)
  3.times do |n|
    title = FFaker::Book.title
    user.posts.create!(title: title)
  end
end
