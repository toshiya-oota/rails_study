ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"


class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  # Run tests in parallel with specified workers
  parallelize(:workers => :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class PolicyTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include Devise::Test::IntegrationHelpers
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Add more helper methods to be used by all tests here...
  def assert_permit(user, record, action)
    msg = "User #{user.inspect} should be permitted to #{action} #{record}, but isn't permitted"
    assert permit(user, record, action), msg
  end

  def refute_permit(user, record, action)
    msg = "User #{user.inspect} should NOT be permitted to #{action} #{record}, but is permitted"
    assert_not permit(user, record, action), msg
  end

  def permit(user, record, action)
    cls = self.class.superclass.to_s.gsub(/Test/, '')
    cls.constantize.new(user, record).public_send("#{action}?")
  end
end
