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

    it { expect(subject.parse(binding: 'foo', inspection: 'HasTypeDeclaration').as_v2)
          .to json_like binding: nil, inspection: {type: 'DeclaresTypeAlias', target: {type: :named, value: 'foo'}, negated: false}   }
    it { expect(subject.parse(binding: 'foo', inspection: 'Not:HasTypeDeclaration').as_v2)
          .to json_like binding: nil, inspection: {type: 'DeclaresTypeAlias', target: {type: :named, value: 'foo'}, negated: true}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasTypeSignature').as_v2)
          .to json_like binding: nil, inspection: {type: 'DeclaresTypeSignature', target: {type: :named, value: 'foo'}, negated: false}   }
    it { expect(subject.parse(binding: 'foo', inspection: 'Not:HasTypeSignature').as_v2)
          .to json_like binding: nil, inspection: {type: 'DeclaresTypeSignature', target: {type: :named, value: 'foo'}, negated: true}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasVariable').as_v2)
          .to json_like binding: nil, inspection: {type: 'DeclaresVariable', target: {type: :named, value: 'foo'}, negated: false}   }
    it { expect(subject.parse(binding: 'foo', inspection: 'Not:HasVariable').as_v2)
          .to json_like binding: nil, inspection: {type: 'DeclaresVariable', target: {type: :named, value: 'foo'}, negated: true}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasArity:1').as_v2)
          .to json_like binding: nil, inspection: {type: 'DeclaresComputationWithArity1', target: {type: :named, value: 'foo'}, negated: false}   }
    it { expect(subject.parse(binding: 'foo', inspection: 'Not:HasArity:3').as_v2)
          .to json_like binding: nil, inspection: {type: 'DeclaresComputationWithArity3', target: {type: :named, value: 'foo'}, negated: true}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasDirectRecursion').as_v2)
          .to json_like binding: nil, inspection: {type: 'DeclaresRecursively', target: {type: :named, value: 'foo'}, negated: false}   }
    it { expect(subject.parse(binding: 'foo', inspection: 'Not:HasDirectRecursion').as_v2)
          .to json_like binding: nil, inspection: {type: 'DeclaresRecursively', target: {type: :named, value: 'foo'}, negated: true}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasComposition').as_v2)
          .to json_like binding: 'foo', inspection: {type: 'UsesComposition', target: {type: :anyone, value: nil}, negated: false}   }
    it { expect(subject.parse(binding: 'foo', inspection: 'Not:HasComposition').as_v2)
          .to json_like binding: 'foo', inspection: {type: 'UsesComposition', target: {type: :anyone, value: nil}, negated: true}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasComprehension').as_v2)
          .to json_like binding: 'foo', inspection: {type: 'UsesComprehension', target: {type: :anyone, value: nil}, negated: false}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasForeach').as_v2)
          .to json_like binding: 'foo', inspection: {type: 'UsesForeach', target: {type: :anyone, value: nil}, negated: false}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasIf').as_v2)
          .to json_like binding: 'foo', inspection: {type: 'UsesIf', target: {type: :anyone, value: nil}, negated: false}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasGuards').as_v2)
          .to json_like binding: 'foo', inspection: {type: 'UsesGuards', target: {type: :anyone, value: nil}, negated: false}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasConditional').as_v2)
          .to json_like binding: 'foo', inspection: {type: 'UsesConditional', target: {type: :anyone, value: nil}, negated: false}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasLambda').as_v2)
          .to json_like binding: 'foo', inspection: {type: 'UsesLambda', target: {type: :anyone, value: nil}, negated: false}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasRepeat').as_v2)
          .to json_like binding: 'foo', inspection: {type: 'UsesRepeat', target: {type: :anyone, value: nil}, negated: false}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasWhile').as_v2)
          .to json_like binding: 'foo', inspection: {type: 'UsesWhile', target: {type: :anyone, value: nil}, negated: false}   }

    it { expect(subject.parse(binding: 'foo', inspection: 'HasUsage:bar').as_v2)
          .to json_like binding: 'foo', inspection: {type: 'Uses', target: {type: :named, value: 'bar'}, negated: false}   }

  end
end
