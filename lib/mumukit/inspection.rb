require 'mumukit/core'

I18n.load_translations_path File.join(__dir__, '..', 'locales', '*.yml')

require_relative '../mumukit/inspection/version'

module Mumukit
  class Inspection
    attr_accessor :type, :target, :negated
    alias negated? negated

    def initialize(type, target, negated=false)
      @type = type
      @target = target
      @negated = negated
    end

    def self.parse_binding(binding_s)
      if binding_s.start_with? 'Intransitive:'
        binding_s[13..-1]
      elsif binding_s.empty?
        nil
      else
        binding_s
      end
    end

    def self.parse(insepection_s)
      raise "Invalid inspection #{insepection_s}" unless insepection_s =~ /^(Not\:)?([^\:]+)\:?(.+)?$/
      Inspection.new($2, Mumukit::Inspection::Target.parse($3), $1.present?)
    end
  end
end

require_relative '../mumukit/inspection/target'
require_relative '../mumukit/inspection/expectation'
require_relative '../mumukit/inspection/i18n'
