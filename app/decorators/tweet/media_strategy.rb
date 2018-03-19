module Tweet::MediaStrategy
  def self.new(strategy, view_context)
    @strategy = const_get(strategy.to_s.camelize).new(view_context)
  end

  def call(medias)
    @strategy.call(medias).html_safe
  end

  class MediaBuilder
    attr_reader :view_context

    alias_method :h, :view_context

    def initialize(view_context)
      @view_context = view_context
    end

    def build_photo(photo, ratio = Nyoro::Photo::RATIO_1_1, **options)
      content = h.image_container(photo.url, ratio)
      build_item(content, options)
    end

    def build_video(video, options = {})
      content = h.content_tag(:div, video.url)
      build_item(content, options)
    end

    def build_item(content, options = {})
      classname = ["tweet-media-item"]
      classname.push("tweet-media-item-main") if options[:main]
      classname.push("tweet-media-item-more") if options[:more]
      h.content_tag :div, content, class: classname.join(" ")
    end
  end

  class Single < MediaBuilder
    def call(medias)
      photos = medias[:photos]
      video = medias[:video]
      ratios = medias[:ratios]

      if photos.present?
        h.content_tag :div, class: "tweet-media-item" do
          build_photo(photos[0], ratios[0])
        end
      else
        build_video(video)
      end
    end
  end

  class Double < MediaBuilder
    def call(medias)
      photos = medias[:photos]
      video = medias[:video]
      ratios = medias[:ratios]

      h.content_tag :div, class: "tweet-medias-group horizontal" do
        h.concat(build_video(video)) if video.present?
        h.concat(photos.map do |photo|
          build_photo(photo)
        end.join("").html_safe)
      end
    end
  end

  class Triple < MediaBuilder
    def call(medias)
      photos = medias[:photos]
      video = medias[:video]

      main_item =
        if video.present?
          build_video(video, main: true)
        else
          photo = photos.slice!(0)
          build_photo(photo, Nyoro::Photo::RATIO_1_2, main: true)
        end

      other_items = photos
        .map { |photo| build_photo(photo) }
        .join("")
        .html_safe

      h.content_tag :div, class: "tweet-medias-group horizontal" do
        h.concat(main_item)
        h.concat(h.content_tag :div, other_items, class: "tweet-medias-group vertical")
      end
    end
  end
end
