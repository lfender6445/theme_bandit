require_relative 'helper'

  describe ThemeBandit::CSSParser do

    before do
      #parse index.html fixture with Nokogiri
      document = Nokogiri::HTML(load_html_fixture)

      #Create a struct and include the CSSParser module
      CSSParser = Struct.new(:document) do
        include ThemeBandit::CSSParser
      end

      #create new instance of CSSParser and set the document instance variable to the parsed fixture
      @css_parser = CSSParser.new(document)
    end

    it 'parses only <link> tags with rel="stylesheet"' do
      assert_equal(@css_parser.link_tags.map{|tag| tag.to_s}, [
          "<link rel=\"stylesheet\" href=\"/css/style.css\">",
          "<link rel=\"stylesheet\" href=\"/css/style_with_import.css\">"
      ])
    end
  end