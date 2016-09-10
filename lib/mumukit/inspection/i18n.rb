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
        binding = expectation[:binding]
        inspection = Mumukit::Inspection.parse expectation[:inspection]

        ::I18n.t "expectation_#{inspection.type}",
                 binding: "<strong>#{binding}</strong>",
                 target: "<strong>#{inspection.target}</strong>",
                 must: t_must(inspection)
      rescue
        '<unknown expectation>'
      end

      alias t translate

      private

      def t_must(parsed)
        ::I18n.t("expectation_#{parsed.must}")
      end
    end
  end
end