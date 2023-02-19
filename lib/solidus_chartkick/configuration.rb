# frozen_string_literal: true

module SolidusChartkick
  class Configuration
    attr_accessor :expressions

    def initialize
      @expressions = Array.new
    end
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    alias config configuration

    def configure
      yield configuration
    end
  end
end
