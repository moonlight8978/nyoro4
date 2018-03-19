module Tweet::MediaDecorator
  # Medias
  def medias
    if photos.present?
      build_medias
    end
  end

  def ratios
    object.photos.map.with_index do |_photo, index|
      Nyoro::Photo.ratio_for(widths[index], heights[index])
    end
  end

  def build_medias
    total_medias = photos.size + video.size
    strategy =
      case total_medias
      when 1
        :single
      when 2
        :double
      when 3
        :triple
      end

    medias_html = ::Tweet::MediaStrategy.new(strategy, h)
      .call({ photos: photos, video: video, ratios: self.ratios })
    h.content_tag :div, medias_html, class: "tweet-medias"
  end

  # Transfrom photos' width into array
  def widths
    object.widths.split(",").map(&:to_f)
  end

  # Transfrom photos' height into array
  def heights
    object.heights.split(",").map(&:to_f)
  end
end
