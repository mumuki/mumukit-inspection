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

  def translate
    Mumukit::Inspection::I18n.translate self
  end

  def to_h
    {binding: binding, inspection: inspection.to_s}
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
      expectation[:binding],
      Mumukit::Inspection.parse(expectation[:inspection])).tap &:check!
  end

  class V0 < Mumukit::Inspection::Expectation
    INSPECTIONS = %w(HasBinding HasTypeDeclaration HasTypeSignature HasVariable HasArity HasDirectRecursion
                     HasComposition HasComprehension HasForeach HasIf HasGuards HasConditional HasLambda HasRepeat HasWhile
                     HasUsage)


    def binding?
      binding.present?
    end

    def inspection?
      inspection.present? && INSPECTIONS.include?(inspection.type)
    end

    def as_v2
      if has? 'Binding' then as_v2_declare ''
      elsif has? 'TypeDeclaration' then as_v2_declare 'TypeAlias'
      elsif has? 'TypeSignature' then as_v2_declare 'TypeSignature'
      elsif has? 'Variable' then as_v2_declare 'Variable'
      elsif has? 'Arity' then as_v2_declare "ComputationWithArity#{inspection.target.value}"
      elsif has? 'DirectRecursion' then as_v2_declare "Recursively"
      elsif has? 'Usage'
        V2.new binding, new_inspection('Uses', Mumukit::Inspection::Target.named(inspection.target.value))
      else as_v2_use
      end
    end

    def has?(simple_type)
      inspection.type == "Has#{simple_type}"
    end

    def as_v2_use
      V2.new binding, new_inspection(inspection.type.gsub('Has', 'Uses'), Mumukit::Inspection::Target.anyone)
    end

    def as_v2_declare(simple_type)
      V2.new '', new_inspection("Declares#{simple_type}", Mumukit::Inspection::Target.named(binding))
    end

    def new_inspection(type, target)
      Mumukit::Inspection.new(type, target, inspection.negated?)
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
