require 'mumukit/inspection/version'

module Mumukit
  module Inspection
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
        {negated: negated?, type: type, target: target}
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
        nil
      end
    end

    class TargetedInspection < PositiveInspection
      attr_accessor :target

      def initialize(type, target)
        @type = type
        @target = target
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
