require 'mumukit/core'

I18n.load_translations_path File.join(__dir__, '..', 'locales', '*.yml')

require_relative '../mumukit/inspection/version'

module Mumukit
  module Inspection
    def self.parse_binding_name(binding)
      if binding.start_with? 'Intransitive:'
        binding[13..-1]
      elsif binding.empty?
        nil
      else
        binding
      end
    end

    def self.parse(s)
      not_match = s.match /^Not:(.*)$/
      if not_match
        NegatedInspection.new(parse_base_inspection(not_match[1]))
      else
        parse_base_inspection(s)
      end
    end

    private

    def self.parse_base_inspection(s)
      target_match = s.match /^(.*):(.*)$/
      if target_match
        TargetedInspection.new(target_match[1], target_match[2])
      else
        PlainInspection.new(s)
      end
    end

    class BaseInspection
      def to_h
        {negated: negated?, type: type, target: target}.compact
      end
    end

    class PositiveInspection < BaseInspection
      attr_accessor :type

      def negated?
        false
      end
    end

    class PlainInspection < PositiveInspection
      def initialize(type)
        @type = type
      end

      def target
        struct type: :anyone
      end
    end

    class TargetedInspection < PositiveInspection
      def initialize(type, target)
        @type = type
        @target = target
      end

      def target
        if @target == '*'
          struct type: :anyone
        elsif @target == '^'
          struct type: :tail
        elsif @target.start_with? '~'
          struct type: :like, value: @target[1..-1]
        elsif @target.start_with? '='
          struct type: :named, value: @target[1..-1]
        else
          struct type: :named, value: @target
        end
      end
    end

    class NegatedInspection < BaseInspection
      def initialize(inspection)
        @inspection = inspection
      end

      def negated?
        true
      end

      def target
        @inspection.target
      end

      def type
        @inspection.type
      end
    end
  end
end

require_relative '../mumukit/inspection/i18n'
