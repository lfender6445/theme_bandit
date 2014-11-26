require_relative 'helper'

describe ThemeBandit::Downloader do

  before do
    @url = 'https://www.example.com/'
    stub_request(:get, @url).to_return(body: load_html_fixture)
  end

  describe '.get_theme' do
    before do
      @subject = ThemeBandit::Downloader
    end

    it 'requires url configuration' do
      ThemeBandit.configure { |config| config.url = nil }
      @subject.get_theme
      assert_equal(ThemeBandit::Logger.message, 'Invalid configuration, please configure through ./bin wrapper')
    end

    describe 'attributes' do
      before do
        @instance = @subject.new(@url)
      end

      it '#url' do
        assert_equal(@instance.url, @url)
      end

      it '#options' do
        assert_equal(@instance.options, {})
      end

      it '#document returns html' do
        assert_kind_of(String, @instance.document)
      end
    end

  end
end
