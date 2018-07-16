require 'spec_helper'

describe Mumukit::Inspection::I18n do

  def translate_expectation(binding, inspection)
    Mumukit::Inspection::Expectation.parse(binding: binding, inspection: inspection).translate
  end

  context 'en locale' do
    before { I18n.locale = :en }

    it { expect(translate_expectation('*', 'Declares:foo')).to eq('solution must declare <strong>foo</strong>') }
    it { expect(translate_expectation('foo', 'Not:Uses:baz')).to eq('<strong>foo</strong> must not use <strong>baz</strong>') }
    it { expect(translate_expectation('foo', 'Not:UsesLambda')).to eq('<strong>foo</strong> must not use lambda expressions') }
  end

  context 'pt locale' do
    before { I18n.locale = :pt }

    it { expect(translate_expectation('*', 'Declares:foo')).to eq('a solução deve declarar <strong>foo</strong>') }
    it { expect(translate_expectation('foo', 'Not:Uses:baz')).to eq('<strong>foo</strong> não deve usar <strong>baz</strong>') }
    it { expect(translate_expectation('foo', 'Not:UsesLambda')).to eq('<strong>foo</strong> não deve usar expressões lambda') }
  end

  context 'es locale' do
    before { I18n.locale = :es }
    describe 'v0 exectations' do
      it { expect(translate_expectation('foo', 'HasBinding')).to eq('la solución debe declarar <strong>foo</strong>') }
      it { expect(translate_expectation('foo', 'HasUsage:bar')).to eq('<strong>foo</strong> debe utilizar <strong>bar</strong>') }
      it { expect(translate_expectation('foo', 'HasWhile')).to eq('<strong>foo</strong> debe utilizar un <i>while</i>') }
      it { expect(translate_expectation('foo', 'HasTypeDeclaration')).to eq('la solución debe declarar un sinónimo de tipo <strong>foo</strong>') }
      it { expect(translate_expectation('foo', 'HasTypeSignature')).to eq('la solución debe declarar una firma <strong>foo</strong>') }
      it { expect(translate_expectation('foo', 'HasRepeat')).to eq('<strong>foo</strong> debe usar <i>repeat</i>') }
      it { expect(translate_expectation('foo', 'HasNot')).to eq('<strong>foo</strong> debe utilizar <i>not</i>') }
      it { expect(translate_expectation('foo', 'HasLambda')).to eq('<strong>foo</strong> debe emplear expresiones lambda') }
      it { expect(translate_expectation('foo', 'HasIf')).to eq('<strong>foo</strong> debe usar <i>if</i>') }
      it { expect(translate_expectation('foo', 'HasForall')).to eq('<strong>foo</strong> debe utilizar <i>forall</i>') }
      it { expect(translate_expectation('foo', 'HasFindall')).to eq('<strong>foo</strong> debe utilizar <i>findall</i>') }
      it { expect(translate_expectation('foo', 'HasComprehension')).to eq('<strong>foo</strong> debe emplear listas por comprensión') }
      it { expect(translate_expectation('foo', 'HasDirectRecursion')).to eq('<strong>foo</strong> debe estar declarado recursivamente') }
      it { expect(translate_expectation('foo', 'HasComposition')).to eq('<strong>foo</strong> debe usar composición') }
    end

    describe 'v2 expectations' do
      it { expect(translate_expectation('*', 'Declares:foo')).to eq('la solución debe declarar <strong>foo</strong>') }
      it { expect(translate_expectation('*', 'DeclaresClass:foo')).to eq('la solución debe declarar una clase <strong>foo</strong>') }

      it { expect(translate_expectation('Mumukit', 'DeclaresClass:Inspection')).to eq('<strong>Mumukit</strong> debe declarar una clase <strong>Inspection</strong>') }

      it { expect(translate_expectation('*', 'DeclaresObject:foo')).to eq('la solución debe declarar un objeto <strong>foo</strong>') }
      it { expect(translate_expectation('foo', 'DeclaresMethod:bar')).to eq('<strong>foo</strong> debe declarar un método <strong>bar</strong>') }
      it { expect(translate_expectation('foo', 'Declares')).to eq('<strong>foo</strong> debe contener declaraciones') }

      it { expect(translate_expectation('foo.bar', 'DeclaresMethod')).to eq('<strong>foo.bar</strong> debe declarar métodos') }
      it { expect(translate_expectation('foo.bar', 'UsesIf')).to eq('<strong>foo.bar</strong> debe usar <i>if</i>') }

      it { expect(translate_expectation('Intransitive:foo', 'Not:UsesLambda')).to eq('<strong>foo</strong> no debe emplear expresiones lambda') }

      it { expect(translate_expectation('foo', 'Uses:=baz')).to eq('<strong>foo</strong> debe utilizar <strong>baz</strong>') }
      it { expect(translate_expectation('foo', 'Uses:~baz')).to eq('<strong>foo</strong> debe delegar en algo parecido a <strong>baz</strong>') }
      it { expect(translate_expectation('foo', 'DeclaresMethod:~baz')).to eq('<strong>foo</strong> debe declarar un método parecido a <strong>baz</strong>') }
      it { expect(translate_expectation('foo', 'Uses:*')).to eq('<strong>foo</strong> debe delegar') }
      it { expect(translate_expectation('foo', 'DeclaresMethod:*')).to eq('<strong>foo</strong> debe declarar métodos') }
      it { expect(translate_expectation('foo', 'Uses:baz')).to eq('<strong>foo</strong> debe utilizar <strong>baz</strong>') }
      it { expect(translate_expectation('foo', 'Uses')).to eq('<strong>foo</strong> debe delegar') }
      it { expect(translate_expectation('foo', 'UsesForall')).to eq('<strong>foo</strong> debe utilizar <i>forall</i>') }

      it { expect(translate_expectation('foo', 'Not:Uses:=baz')).to eq('<strong>foo</strong> no debe utilizar <strong>baz</strong>') }
      it { expect(translate_expectation('foo', 'Not:Uses:~baz')).to eq('<strong>foo</strong> no debe delegar en algo parecido a <strong>baz</strong>') }
      it { expect(translate_expectation('foo', 'Not:Uses:*')).to eq('<strong>foo</strong> no debe delegar') }
      it { expect(translate_expectation('foo', 'Not:Uses')).to eq('<strong>foo</strong> no debe delegar') }
      it { expect(translate_expectation('foo', 'Not:Uses:baz')).to eq('<strong>foo</strong> no debe utilizar <strong>baz</strong>') }
      it { expect(translate_expectation('foo', 'Not:UsesLambda')).to eq('<strong>foo</strong> no debe emplear expresiones lambda') }

      it { expect(translate_expectation('*', 'DeclaresClass')).to eq('la solución debe declarar clases') }
      it { expect(translate_expectation('*', 'Not:DeclaresMethod')).to eq('la solución no debe declarar métodos') }
      it { expect(translate_expectation('*', 'Not:DeclaresClass')).to eq('la solución no debe declarar clases') }

      it { expect(translate_expectation('foo', 'DeclaresObject')).to eq('<strong>foo</strong> debe declarar objetos') }
      it { expect(translate_expectation('*', 'Not:DeclaresClass')).to eq('la solución no debe declarar clases') }
      it { expect(translate_expectation('foo', 'HasAnonymousVariable')).to eq('<strong>foo</strong> debe utilizar una variable anónima') }
      it { expect(translate_expectation('foo', 'UsesAnonymousVariable')).to eq('<strong>foo</strong> debe utilizar una variable anónima') }
    end

    describe 'smells' do
      it { expect(translate_expectation('foo', 'HasRedundantIf')).to eq('<strong>foo</strong> tiene ifs innecesarios') }
      it { expect(translate_expectation('foo', 'HasRedundantBooleanComparison')).to eq('<strong>foo</strong> hace comparaciones booleanas innecesarias') }
      it { expect(translate_expectation('bar', 'UsesFail')).to eq('<strong>bar</strong> usa <i>fail</li>, lo cual es una mala práctica') }
      it { expect(translate_expectation('foo', 'HasEmptyIfBranches')).to eq('<strong>foo</strong> tiene ramas de <i>if</i> vacías') }
      it { expect(translate_expectation('foo', 'HasUnreachableCode')).to eq('<strong>foo</strong> tiene código inalcanzable.') }
    end
  end
end
