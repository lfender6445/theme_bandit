module ThemeBandit
  module ImageParser

    # return array of images to download
    def get_image_files
      image_tag_values
    end

    def image_tag_values
      document.css('img').map do |img|
        clean_image(img.attributes['src'].value)
      end
    end

    def clean_image(url)
      # "//i.imgur.com/dry2bJGb.jpg"
      if match = url.match(/^\/\//)
        new_url = url.gsub(match[0], 'http://')
      end
      new_url || url
    end

  end
end
