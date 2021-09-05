require_relative './spec_helper'

describe Mumukit::Inspection::Formatting do
  before { Mulang::Inspection.register_extension! Mumukit::Inspection::Formatting }
  after { Mulang::Inspection.unregister_extension! Mumukit::Inspection::Formatting }

  describe 'parsing' do
    let(:inspection_s) { 'HasInconsistentIndentation' }

    it { expect(Mulang::Inspection.parse(inspection_s)).to json_like(type: 'HasInconsistentIndentation',
                                                                      target: { type: :unknown },
                                                                      negated: false,
                                                                      i18n_namespace: "mumukit.inspection") }
    it { expect(Mulang::Inspection.parse(inspection_s).to_s).to eq inspection_s }
  end

  describe 'i18n' do
    before { I18n.locale = :es }

    describe 'source exectations' do
      it { expect(expectation('*', 'HasInconsistentIndentation').translate).to eq('el código está mal tabulado') }
      it { expect(expectation('*', 'HasEmptyCodeBlock').translate).to eq('el código tiene un bloque de código vacío') }
    end
  end
end
