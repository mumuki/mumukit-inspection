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

        key = key_for binding, inspection

        ::I18n.t key,
                 binding: t_binding(binding),
                 target: t_target(inspection),
                 must: t_must(inspection)
      rescue
        '<unknown expectation>'
      end

      alias t translate

      private

      def key_for(binding, inspection)
        if inspection.target.type == :named
          "expectation_#{inspection.type}_named"
        elsif inspection.target.type == :like
          "expectation_#{inspection.type}_like"
        elsif inspection.target.type == :tail
          "expectation_#{inspection.type}_tail"
        elsif inspection.target.type == :anyone && binding
          "expectation_#{inspection.type}"
        else binding
          "expectation_#{inspection.type}_tail"
        end
      end

      def t_binding(binding)
        binding ? "<strong>#{binding}</strong>" : ::I18n.t("expectation_solution")
      end

      def t_must(parsed)
        ::I18n.t("expectation_#{parsed.must}")
      end

      def t_target(parsed)
        "<strong>#{parsed.target.value}</strong>"
      end
    end
  end
end
