namespace :elasticsearch do
  desc "Reindexing Elasticsearch (searchkick gem)"
  task reindex: :environment do
    classes = [Feed::Tweet, Tweet::Hashtag, User]
    classes.each { |c| c.search_index.delete }
    classes.each(&:reindex)
  end
end
