module Mumukit::Inspection

  class Mumukit::Inspection::NegatedInspection
    def must
      'must_not'
    end
  end

  class Mumukit::Inspection::PositiveInspection
    def must
      'must'
    end
  end

  module I18n
    class << self
      def translate(expectation)
        binding = Mumukit::Inspection.parse_binding_name expectation[:binding]
        inspection = Mumukit::Inspection.parse expectation[:inspection]

        ::I18n.t "expectation_#{inspection.type}",
                 binding: "<strong>#{binding}</strong>",
                 target: "<strong>#{t_target inspection}</strong>",
                 must: t_must(inspection)
      rescue
        '<unknown expectation>'
      end

      alias t translate

      private

      def t_must(parsed)
        ::I18n.t("expectation_#{parsed.must}")
      end

      def t_target(parsed)
        if parsed.target.is_a? OpenStruct
          ::I18n.t("expectation_#{parsed.target.type}", value: parsed.target.value)
        else
          parsed.target
        end
      end
    end
  end
end
