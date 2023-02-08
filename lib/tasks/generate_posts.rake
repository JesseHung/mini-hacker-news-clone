desc "Generate 100 posts & mock votes"
task :generate_posts => :environment do
  posts = []

  100.times do |time|
    post = Post.new
    post.url = "https://www.google.com/"
    post.title = "the #{time + 1} post"
    post.content = "content of the #{time + 1} post"
    post.user_id = User.order('RANDOM()').first.id
    posts << post
  end

  Post.import! posts
  puts "generated 100 posts"

  upvotes = []
  1000.times do |time|
    post = Post.order('RANDOM()').first
    user = User.order('RANDOM()').first

    upvotes << post.post_upvotes.new(user_id: user.id)
  end

  PostUpvote.import! upvotes
  puts "generated 1000 votes"
end