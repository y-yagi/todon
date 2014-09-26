ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/sound/reporter'
require 'minitest/slow_test/reporter'
require 'minitest/metadata'
#require 'pry-rescue/minitest'

class ActiveSupport::TestCase
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include MiniTest::Metadata

  OmniAuth.config.test_mode = true

  Capybara.default_driver = :rack_test
  Capybara.javascript_driver = :webkit

  WebMock.disable_net_connect!(allow_localhost: true)

  before do
    if metadata[:js]
      Capybara.current_driver = Capybara.javascript_driver
    else
      Capybara.current_driver = Capybara.default_driver
    end
  end

  after do
    Capybara.reset_sessions!
  end
end

Minitest::Sound.success = '/home/yaginuma/Dropbox/tmp/music/other/ff4_09_fanfare.mp3'
Minitest::Sound.failure = '/home/yaginuma/Dropbox/tmp/music/other/mdai.mp3'
Minitest::Sound.during_test = '/home/yaginuma/Dropbox/tmp/music/other/rs1_25_beatthemup.mp3'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new, Minitest::SlowTest::Reporter.new, Minitest::Sound::Reporter.new]


module ValidateAttribute
  def self.included(base)
    base.send :include, InstanceMethods
  end

  module InstanceMethods
    def valid_attribute?(attribute_name)
      self.valid?
      self.errors[attribute_name].blank?
    end
  end
end

ActiveRecord::Base.send(:include, ValidateAttribute) if defined?(ActiveRecord::Base)

def login
  visit login_path
  click_link 'google-login'
end
