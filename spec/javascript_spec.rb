require_relative './spec_helper'

describe Mumukit::Inspection::JavaScript do
  before { Mulang::Inspection.register_extension! Mumukit::Inspection::JavaScript }
  after { Mulang::Inspection.unregister_extension! Mumukit::Inspection::JavaScript }

  describe 'parsing' do
    let(:inspection_s) { 'JavaScript#LacksOfEndingSemicolon' }

    it { expect(Mulang::Inspection.parse(inspection_s)).to json_like(type: 'JavaScript#LacksOfEndingSemicolon',
                                                                      negated: false,
                                                                      i18n_namespace: "mumukit.inspection") }
    it { expect(Mulang::Inspection.parse(inspection_s).to_s).to eq inspection_s }
  end

  describe 'i18n' do
    before { I18n.locale = :es }

    describe 'source exectations' do
      it { expect(expectation('*', 'JavaScript#LacksOfEndingSemicolon').translate).to eq('el código está mal tabulado') }
      it { expect(expectation('*', 'JavaScript#HasInconsistentBraces').translate).to eq('el código tiene un bloque de código vacío') }
    end
  end
end
