require_relative 'helper'

class TestConfigure < MiniTest::Test
  def setup
    @subject = ThemeBandit
  end

  def test_configuration
    @subject.configure do |config|
      config.foo = 'bar'
    end
    assert_equal @subject.configuration.foo, 'bar'
  end
end
