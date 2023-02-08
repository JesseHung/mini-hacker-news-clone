require 'faker'
require 'securerandom'

desc "Generate 100 test users"
task :generate_test_users => :environment do
  users = []

  100.times do |time|
    user = User.new
    user.email = Faker::Internet.email
    user.password = SecureRandom.hex(10)
    users << user
  end

  User.import! users
  puts "generated 100 test users"
end