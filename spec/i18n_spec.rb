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
    it { expect(translate_expectation('', 'HasBinding:foo')).to eq('la solución debe declarar <strong>foo</strong>') }
    it { expect(translate_expectation('', 'HasClass:foo')).to eq('la solución debe declarar una clase <strong>foo</strong>') }

    it { expect(translate_expectation('Foo', 'HasClass')).to eq('la clase <strong>Foo</strong> debe estar declarada') }
    it { expect(translate_expectation('Mumukit', 'HasClass:Inspection')).to eq('<strong>Mumukit</strong> debe declarar una clase <strong>Inspection</strong>') }

    it { expect(translate_expectation('foo', 'HasObject')).to eq('el objeto <strong>foo</strong> debe estar declarado') }
    it { expect(translate_expectation('foo', 'HasMethod:bar')).to eq('<strong>foo</strong> debe declarar un método <strong>bar</strong>') }
    it { expect(translate_expectation('foo', 'HasBinding')).to eq('<strong>foo</strong> debe estar declarado') }

    it { expect(translate_expectation('foo.bar', 'HasMethod')).to eq('el método <strong>foo.bar</strong> debe estar declarado') }
    it { expect(translate_expectation('foo.bar', 'HasIf')).to eq('<strong>foo.bar</strong> debe usar if') }

    it { expect(translate_expectation('Intransitive:foo', 'Not:HasLambda')).to eq('<strong>foo</strong> no debe emplear expresiones lambda') }

    it { expect(translate_expectation('foo', 'HasUsage:=baz')).to eq('<strong>foo</strong> debe utilizar <strong>baz</strong>') }
    it { expect(translate_expectation('foo', 'HasUsage:~baz')).to eq('<strong>foo</strong> debe delegar en algo parecido a <strong>baz</strong>') }
    it { expect(translate_expectation('foo', 'HasMethod:~baz')).to eq('<strong>foo</strong> debe declarar un método parecido a <strong>baz</strong>') }
    it { expect(translate_expectation('foo', 'HasUsage:*')).to eq('<strong>foo</strong> debe ser utilizado') }
    it { expect(translate_expectation('foo', 'HasMethod:*')).to eq('el método <strong>foo</strong> debe estar declarado') }
    it { expect(translate_expectation('foo', 'HasUsage:baz')).to eq('<strong>foo</strong> debe utilizar <strong>baz</strong>') }
    it { expect(translate_expectation('foo', 'HasUsage')).to eq('<strong>foo</strong> debe ser utilizado') }
    it { expect(translate_expectation('foo', 'HasForall')).to eq('<strong>foo</strong> debe utilizar forall') }

    it { expect(translate_expectation('foo', 'Not:HasUsage:=baz')).to eq('<strong>foo</strong> no debe utilizar <strong>baz</strong>') }
    it { expect(translate_expectation('foo', 'Not:HasUsage:~baz')).to eq('<strong>foo</strong> no debe delegar en algo parecido a <strong>baz</strong>') }
    it { expect(translate_expectation('foo', 'Not:HasUsage:*')).to eq('<strong>foo</strong> no debe ser utilizado') }
    it { expect(translate_expectation('foo', 'Not:HasUsage')).to eq('<strong>foo</strong> no debe ser utilizado') }
    it { expect(translate_expectation('foo', 'Not:HasUsage:baz')).to eq('<strong>foo</strong> no debe utilizar <strong>baz</strong>') }
    it { expect(translate_expectation('foo', 'Not:HasLambda')).to eq('<strong>foo</strong> no debe emplear expresiones lambda') }

    it { expect(translate_expectation('', 'HasClass')).to eq('la solución debe declarar clases') }
    it { expect(translate_expectation('', 'Not:HasMethod')).to eq('la solución no debe declarar métodos') }
    it { expect(translate_expectation('', 'Not:HasClass')).to eq('la solución no debe declarar clases') }

    it { expect(translate_expectation('foo', 'HasObject:^')).to eq('<strong>foo</strong> debe declarar objetos') }
    it { expect(translate_expectation('', 'Not:HasClass')).to eq('la solución no debe declarar clases') }
  end
end
