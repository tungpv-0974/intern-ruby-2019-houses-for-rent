20.times do |n|
  first_name  = FFaker::NameVN.first_name
  middle_name =  FFaker::NameVN.middle_name
  name = [first_name, middle_name].join(" ")
  last_name  = FFaker::NameVN.last_name
  email = "example-#{n+1}@railstutorial.org"
  password = "123456"
  user = User.create!(first_name: name, last_name: last_name, email: email,
  password: password)
  3.times do |n|
    title = FFaker::Book.title
    user.posts.create!(title: title)
  end
end
