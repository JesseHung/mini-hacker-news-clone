desc "Update comments points of all the points"
task :update_comments_points => :environment do

  Comment.all.find_in_batches do |comments_batch|
    comments_batch.each do |comment|
      # 權重分數 = (P-1) / (T+2)^G
      # 假定 G 為 1.8
      comment.points = (comment.voted_points - 1) / (comment.hour_past + 2) ** 1.8
      comment.save!
      sleep(1)
    end
    sleep(1)
  end
  puts "Update comments points at #{Time.now}"
end