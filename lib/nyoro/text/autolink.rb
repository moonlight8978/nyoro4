module Nyoro
  module Text
    # Implement and override some methods from Twitter's Autolink
    # Primary use is for decorators so they can auto-link
    # usernames, hashtags, urls
    module Autolink
      extend Twitter::TwitterText::Autolink

    extend self
      # Regex to remove http:// and www. from url
      PROTOCOL_REGEX = /(\w+:\/\/|^)(w{3}.)?/
      # Block to edit url text
      LINK_TEXT_BLOCK = -> (entity, text) { text.gsub(PROTOCOL_REGEX, '') }
      # CSS class for @username wrapper tag
      USERNAME_CLASS = "pre-p pre-username".freeze
      # CSS class for url wrapper tag
      URL_CLASS = "pre-p pre-url".freeze
      # CSS class for hashtag wrapper tag
      HASHTAG_CLASS = "pre-p pre-hashtag".freeze
      # URL base for auto-linked hashtags
      HASHTAG_URL_BASE = "/hashtags/".freeze
      # URL base for auto-linked usernames
      USERNAME_URL_BASE = "/".freeze

      OPTIONS = {
        username_class: USERNAME_CLASS,
        hashtag_class: HASHTAG_CLASS,
        url_class: URL_CLASS,
        username_url_base: USERNAME_URL_BASE,
        hashtag_url_base: HASHTAG_URL_BASE,
        username_include_symbol: true,
        suppress_no_follow: true,
        link_text_block: LINK_TEXT_BLOCK,
      }.freeze

      # Override to pass options
      def auto_link(text)
        super(text, OPTIONS)
      end

      # Cashtags will not be auto-linked
      def link_to_cashtag(entity, chars, options = {})
        "$#{entity[:cashtag]}"
      end
    end
  end
end
