require 'spec_helper'

describe Mumukit::Inspection::I18n do

  def translate_expectation(binding, inspection)
    Mumukit::Inspection::I18n.t binding: binding, inspection: inspection
  end

  context 'en locale' do
    before { I18n.locale = :en }

    it { expect(translate_expectation('foo', 'HasBinding')).to eq('<strong>foo</strong> must be defined') }
    it { expect(translate_expectation('foo', 'Not:HasUsage:baz')).to eq('<strong>foo</strong> must not use <strong>baz</strong>') }
    it { expect(translate_expectation('foo', 'Not:HasLambda')).to eq('<strong>foo</strong> must not use lambda expressions') }
  end

  context 'es locale' do
    before { I18n.locale = :es }
    it { expect(translate_expectation('', 'HasBinding:foo')).to eq('<strong>foo</strong> debe estar definido') }
    it { expect(translate_expectation('', 'HasClass:foo')).to eq('la clase <strong>foo</strong> debe estar declarada') }
    it { expect(translate_expectation('Foo', 'HasClass')).to eq('la clase <strong>Foo</strong> debe estar declarada') }
    it { expect(translate_expectation('foo', 'HasObject')).to eq('el objecto <strong>foo</strong> debe estar definido') }

    it { expect(translate_expectation('foo', 'HasMethod:bar')).to eq('el método <strong>foo.bar</strong> debe estar declarado') }
    it { expect(translate_expectation('foo.bar', 'HasMethod')).to eq('el método <strong>foo.bar</strong> debe estar declarado') }
    it { expect(translate_expectation('foo.bar', 'HasIf')).to eq('<strong>foo.bar</strong> debe usar if') }

    it { expect(translate_expectation('foo', 'HasBinding')).to eq('<strong>foo</strong> debe estar declarado') }
    it { expect(translate_expectation('foo', 'Not:HasUsage:baz')).to eq('<strong>foo</strong> no debe utilizar <strong>baz</strong>') }
    it { expect(translate_expectation('foo', 'Not:HasLambda')).to eq('<strong>foo</strong> no debe emplear expresiones lambda') }

    it { expect(translate_expectation('Intransitive:foo', 'Not:HasLambda')).to eq('<strong>foo</strong> no debe emplear expresiones lambda') }

    it { expect(translate_expectation('foo', 'Not:HasUsage:=baz')).to eq('<strong>foo</strong> no debe utilizar <strong>baz</strong>') }
    it { expect(translate_expectation('foo', 'Not:HasUsage:~baz')).to eq('<strong>foo</strong> no debe utilizar nada parecido a <strong>baz</strong>') }
    it { expect(translate_expectation('foo', 'Not:HasUsage:*')).to eq('<strong>foo</strong> no debe utilizar nada') }
    it { expect(translate_expectation('foo', 'Not:HasUsage')).to eq('<strong>foo</strong> no debe utilizar nada') }
  end
end
