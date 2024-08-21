# frozen_string_literal: true

module Gibbler

  module VERSION
    def self.to_s
      load_config
      [@version[:MAJOR], @version[:MINOR], @version[:PATCH]].join('.')
    end
    alias_method :inspect, :to_s
    def self.load_config
      require 'yaml'
      @version ||= YAML.load_file(::File.join(GIBBLER_LIB_HOME, '..', 'VERSION.yml'))
    end
  end

end
