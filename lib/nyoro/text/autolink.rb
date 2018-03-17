module Nyoro
  module Text
    module Autolink
      extend Twitter::TwitterText::Autolink

    extend self

      PROTOCOL_REGEX = /(\w+:\/\/|^)(w{3}.)?/

      LINK_TEXT_BLOCK = -> (entity, text) { text.gsub(PROTOCOL_REGEX, '') }

      OPTIONS = {
        username_class: "pre-p pre-username",
        hashtag_class: "pre-p pre-hashtag",
        url_class: "pre-p pre-url",
        username_url_base: "http://moon.co.jp/",
        hashtag_url_base: "http://moon.co.jp/hashtags/",
        username_include_symbol: true,
        suppress_no_follow: true,
        link_text_block: LINK_TEXT_BLOCK,
      }

      def link_to_cashtag(entity, chars, options = {})
        "$#{entity[:cashtag]}"
      end

      def auto_link(text)
        super(text, OPTIONS)
      end
    end
  end
end
