require 'helper'

describe ThemeBandit::RackGenerator do

  supported_engines = ['slim', 'haml', 'erb']

  supported_engines.each do |engine|
    describe "#builds a recipe #{engine}" do

      before do
        stub_request_stack
        @engine = engine
        configure_and_write_files
        ThemeBandit::RackGenerator.build
      end

      after do
        `rm -rf theme`
      end

      it 'Gemfile' do
        assert File.file?("#{Dir.pwd}/theme/Gemfile")
      end

      it 'config.ru' do
        assert File.file?("#{Dir.pwd}/theme/config.ru")
      end

      it 'config.ru' do
        assert File.file?("#{Dir.pwd}/theme/app/application.rb")
      end

      describe 'app/views/templates' do
        it "build .#{@engine} file" do
          assert File.file?("#{Dir.pwd}/theme/app/views/templates/index.#{@engine}")
        end
      end
    end

    private

    def configure_and_write_files
      ThemeBandit.configure do |config|
        config.template_engine = @engine
        config.url = 'http://www.example.com'
      end
      ThemeBandit::DocumentWriter.new(load_html_fixture, @url).write
    end
  end

end


