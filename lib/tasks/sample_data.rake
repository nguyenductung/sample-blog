namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  User.create!(name: "Nguyen Duc Tung",
               email: "nguyen.duc.tung@framgia.com",
               password: "123456",
               password_confirmation: "123456",
               admin: true)
                 
  User.create!(name: "Example User",
               email: "example@railstutorial.org",
               password: "123456",
               password_confirmation: "123456",
               admin: true)
                 
  98.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@gmail.com"
    password  = "123456"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do |n|
    title = "Entry #{n+1}"
    content = Faker::Lorem.paragraph((5..20).to_a.sample)
    users.each { |user| user.entries.create!(title: title, content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end