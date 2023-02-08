desc "Update post points of all the points"
task :update_posts_points => :environment do

  Post.all.find_in_batches do |posts_batch|
    posts_batch.each do |post|
      # 權重分數 = (P-1) / (T+2)^G
      # 假定 G 為 1.8
      post.points = (post.voted_points - 1) / (post.hour_past + 2) ** 1.8
      post.save!
      sleep(1)
    end
    sleep(1)
  end
  puts "Update posts points at #{Time.now}"
end