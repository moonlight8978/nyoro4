namespace :tweet do
  desc "Create tagging/mentioning for existing tweets/replies"
  task tagging: :environment do
    Tweet::Tagging.delete_all
    Tweet::Mentioning.delete_all
    
    Feed::Tweet.all.each do |tweet|
      Tweet::Tagging.tag(tweet)
      Tweet::Mentioning.mention(tweet)
    end

    Tweet::Reply.all.each do |reply|
      Tweet::Tagging.tag(reply)
      Tweet::Mentioning.mention(reply)
    end
  end
end
