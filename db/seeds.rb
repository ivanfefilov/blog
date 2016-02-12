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
