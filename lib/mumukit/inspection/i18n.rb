module Mumukit::Inspection::I18n
  class << self
    def translate(e)
      e = e.as_v2
      key = key_for e.binding, e.inspection
      ::I18n.t key,
      binding: t_binding(e.binding),
      target: t_target(e.inspection),
      must: t_must(e.inspection)
    rescue
      '<unknown expectation>'
    end

    alias t translate

    private

    def key_for(binding, inspection)
      "expectation_#{inspection.type}#{inspection.target ? inspection.target.i18n_suffix : nil }"
    end

    def t_binding(binding)
      binding.present? ? "<strong>#{Mumukit::Inspection.parse_binding_name binding}</strong>" : ::I18n.t("expectation_solution")
    end

    def t_must(parsed)
      ::I18n.t("expectation_#{parsed.negated? ? 'must_not' : 'must' }")
    end

    def t_target(parsed)
      "<strong>#{parsed.target.value}</strong>" if parsed.target
    end
  end
end
