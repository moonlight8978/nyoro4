module HasExtractableContent
  extend ActiveSupport::Concern
  included do
    # code ...
  end

  # instance methods go here
  def extract_hashtags
    extractor = Nyoro::Text::Extractor.new
    hashtags = extractor.extract_hashtags self.content do |hashtag|
      hashtag.downcase!
    end
    hashtags.uniq
  end

  def extract_mentioned_users
    extractor = Nyoro::Text::Extractor.new
    usernames = extractor.extract_mentioned_screen_names(self.content)
      .compact
      .uniq
    users = User.where(username: usernames)
  end

  module ClassMethods
    # static methods go here
    # def static_method
    #
    # end
  end
end
