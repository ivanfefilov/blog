require 'faker'

5.times do
  user = User.new(:name => Faker::Name.name,
                  :email => Faker::Internet.email,
                  :password => '123456')
  if user.save
    3.times do
       user.posts.create(:title => Faker::Lorem.sentence,
                        :body =>  Faker::Lorem.paragraphs(4))
    end
  else
    puts "User wasn't created: #{user.errors.full_messages}"
  end
end

User.all.each do |user|
  Post.all.each do |post|
    unless post.user == user
      user.scores.create(:post_id => post.id, :value => rand(5)+1 )
    end
    (rand(3)).times do
      user.comments.create(:post_id => post.id, :body => Faker::Lorem.paragraph)
    end
  end
end
