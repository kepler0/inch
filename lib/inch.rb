require "inch/version"

module Inch
  class << self
    # Returns true if Texas is run in verbose mode
    attr_accessor :verbose

    # Returns true if warnings are enabled
    attr_accessor :warnings
  end
end

require 'pp'

require_relative 'inch/cli'
require_relative 'inch/source_parser'
require_relative 'inch/code_object'
require_relative 'inch/runner'

require 'yard'

alias :yard_logger :log
yard_logger.level = Logger::UNKNOWN # basically disable YARD's logging