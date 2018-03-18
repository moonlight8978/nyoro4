module Nyoro
  # Use to store, map special characters
  module Text
    HTML_MAP = {
      space: "&nbsp;",
      middot: "&middot;",
    }

    # map key to HTML character
    def self.html_map(key)
      HTML_MAP[key].html_safe
    end
  end
end
