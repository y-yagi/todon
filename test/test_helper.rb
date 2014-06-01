ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
#require 'pry-rescue/minitest'

include FactoryGirl::Syntax::Methods

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
end

class MiniTest::Spec
  DatabaseCleaner.strategy = :transaction
  before do
    DatabaseCleaner.start
  end

  after do
    DatabaseCleaner.clean
  end
end

class IntegrationSpec < MiniTest::Spec
  include Capybara::DSL
#  include Capybara::Assertions
  include Rails.application.routes.url_helpers

  DatabaseCleaner.strategy = :truncation

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

  OmniAuth.config.test_mode = true
end
MiniTest::Spec.register_spec_type(/Integration/, IntegrationSpec)
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


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
