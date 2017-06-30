class Mumukit::Inspection::Expectation
  attr_accessor :binding, :inspection

  def initialize(binding, inspection)
    @binding = binding
    @inspection = inspection
  end

  def check!
    raise "Wrong binding #{binding}" unless binding?
    raise "Wrong inspection #{inspection}" unless inspection?
  end

  def self.guess_type(expectation)
    if expectation[:inspection] =~ /(Not\:)?Has.*/
      V0
    else
      V2
    end
  end

  def self.parse(expectation)
    guess_type(expectation).new(
      Mumukit::Inspection.parse_binding(expectation[:binding]),
      Mumukit::Inspection.parse(expectation[:inspection])).tap &:check!
  end

  class V0 < Mumukit::Inspection::Expectation
    INSPECTIONS = %w(HasBinding HasUsage)


    def binding?
      binding.present?
    end

    def inspection?
      inspection.present? && INSPECTIONS.include?(inspection.type)
    end

    def as_v2
      if inspection.type == 'HasBinding'
        V2.new nil, Mumukit::Inspection.new('Declares', Mumukit::Inspection::Target.new(:named, binding), inspection.negated?)
      else
        nil
      end
    end
  end

  class V2 < Mumukit::Inspection::Expectation
    def binding?
      true
    end

    def inspection?
      true
    end

    def as_v2
      self
    end
  end
end
