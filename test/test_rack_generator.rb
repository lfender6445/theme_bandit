require_relative 'helper'

describe ThemeBandit::RackGenerator do

  supported_engines = %w(slim haml erb)

  supported_engines.each do |engine|
    describe "#builds #{engine} recipe" do

      before do
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

      it 'application.rb' do
        assert File.file?("#{Dir.pwd}/theme/app/application.rb")
      end

      describe 'app/views/templates' do
        it "build .#{engine} file" do
          assert File.file?("#{Dir.pwd}/theme/app/views/templates/index.#{engine}")
        end
      end
    end

    private

    def configure_and_write_files
      prep_config
      ThemeBandit.configure do |config|
        config.template_engine = @engine
        config.url = test_url
        config.gem_root = Dir.pwd
      end
      stub_request_stack
      ThemeBandit::DocumentWriter.new(load_html_fixture, ThemeBandit.configuration.url).write
    end
  end

end
