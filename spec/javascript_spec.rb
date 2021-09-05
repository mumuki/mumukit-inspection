require_relative './spec_helper'

describe Mumukit::Inspection::JavaScript do
  before { Mulang::Inspection.register_extension! Mumukit::Inspection::JavaScript }
  after { Mulang::Inspection.unregister_extension! Mumukit::Inspection::JavaScript }

  describe 'parsing' do
    context 'JavaScript#LacksOfEndingSemicolon' do
      let(:inspection_s) { 'JavaScript#LacksOfEndingSemicolon' }

      it { expect(Mulang::Inspection.parse(inspection_s)).to json_like(type: 'JavaScript#LacksOfEndingSemicolon',
                                                                        negated: false,
                                                                        i18n_namespace: "mumukit.inspection") }
      it { expect(Mulang::Inspection.parse(inspection_s).to_s).to eq inspection_s }
    end

    context 'JavaScript#FormatsBracesInconsistently' do
      let(:inspection_s) { 'JavaScript#FormatsBracesInconsistently' }

      it { expect(Mulang::Inspection.parse(inspection_s)).to json_like(type: 'JavaScript#FormatsBracesInconsistently',
                                                                        negated: false,
                                                                        i18n_namespace: "mumukit.inspection") }
      it { expect(Mulang::Inspection.parse(inspection_s).to_s).to eq inspection_s }
    end
  end

  describe 'i18n' do
    before { I18n.locale = :es }

    describe 'source exectations' do
      it { expect(expectation('let x = 2', 'JavaScript#LacksOfEndingSemicolon').translate).to eq('la siguiente línea debería terminar en <code>;</code>: <pre><code>let x = 2</code></pre>') }
      it { expect(expectation('*', 'JavaScript#FormatsBracesInconsistently').translate).to eq('el código tiene un bloque de código vacío') }
      it { expect(expectation('*', 'JavaScript#IndentsInconsistently').translate).to eq('el código está mal tabulado') }
      it { expect(expectation('{ { }; return; }', 'JavaScript#HasEmptyCodeBlock').translate).to eq("hay un bloque de código vacío y que deberías eliminar en <pre><code>{ { }; return; }</code></pre>") }
    end
  end
end
