module Nyoro
  class Photo
    RATIO_1_1 = "1_1"
    RATIO_1_2 = "1_2"
    RATIO_2_1 = "2_1"
    RATIO_2_3 = "2_3"
    RATIO_3_2 = "3_2"

    SUPPORTED_RATIOS = {
      "11": RATIO_1_1,
      "12": RATIO_1_2,
      "21": RATIO_2_1,
      "23": RATIO_2_3,
      "32": RATIO_3_2,
    }

    def self.ratio_for(width, height)
      ratio = (height.to_f / width.to_f).round(2)
      ratio_key =
        case ratio
        when (2.85..999)
          "12"
        when (1.35..1.84)
          "23"
        when (0.85..1.34)
          "11"
        when (0.6..0.84)
          "32"
        else
          "21"
        end.to_sym
      SUPPORTED_RATIOS[ratio_key]
    end
  end
end
