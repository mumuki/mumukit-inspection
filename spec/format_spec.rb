require 'spec_helper'

describe Mumukit::Inspection::Expectation do
  subject { Mumukit::Inspection::Expectation }

  describe 'it can check old format' do
    it { expect { subject.parse binding: 'foo', inspection: 'HasBinding' }.to_not raise_error }
    it { expect { subject.parse binding: 'foo', inspection: 'HasBindin' }.to raise_error }
    it { expect { subject.parse binding: '', inspection: 'HasBinding' }.to raise_error }
  end

  describe 'it can guess format' do
    it { expect(subject.guess_type binding: 'foo', inspection: 'HasBinding').to be Mumukit::Inspection::Expectation::V0 }
    it { expect(subject.guess_type binding: 'foo', inspection: 'Uses:*').to be Mumukit::Inspection::Expectation::V2 }
  end

  describe 'it can adapt to latest format' do
    it { expect(subject.parse(binding: '', inspection: 'Declares:foo').as_v2)
          .to json_like binding: nil, inspection: {type: 'Declares', target: {type: :named, value: 'foo'}, negated: false   }  }
    it { expect(subject.parse(binding: 'foo', inspection: 'HasBinding').as_v2)
          .to json_like binding: nil, inspection: {type: 'Declares', target: {type: :named, value: 'foo'}, negated: false}   }
    it { expect(subject.parse(binding: 'foo', inspection: 'Not:HasBinding').as_v2)
          .to json_like binding: nil, inspection: {type: 'Declares', target: {type: :named, value: 'foo'}, negated: true}   }
  end
end


# x HasArity:n                        -> DeclaresArityN:x
# x HasDirectRecursion                -> DeclaresRecursively:x
# x HasTypeDeclaration                -> DeclaresTypeAlias:x
# x HasTypeSignature                  -> DeclaresTypeSignature:x
# x HasVariable                       -> DeclaresVariable:x
# x HasComposition                    -> x UsesComposition
# x HasComprehension                  -> x UsesComprehension
# x HasConditional                    -> x UsesConditional
# x HasForeach                        -> x UsesForeach
# x HasGuards                         -> x UsesGuards
# x HasIf                             -> x UsesGuards
# x HasLambda                         -> x UsesLambda
# x HasRepeat                         -> x UsesRepeat
# x HasRepeatOf                       -> x UsesRepeat
# x HasUsage:g                        -> x Uses:g
# x HasWhile                          -> x HasWhile
