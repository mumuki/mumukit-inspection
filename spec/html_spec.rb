require_relative './spec_helper'

describe Mumukit::Inspection::Html do
  before { Mulang::Inspection.register_extension! Mumukit::Inspection::Html }
  after { Mulang::Inspection.unregister_extension! Mumukit::Inspection::Html }

  describe 'parsing' do
    let(:inspection_s) { 'DeclaresAttribute:href="https://mumuki.org"' }

    it { expect(Mulang::Inspection.parse(inspection_s)).to json_like(type: 'DeclaresAttribute',
                                                                     target: { type: :unknown, value: 'href="https://mumuki.org"' },
                                                                     negated: false,
                                                                     i18n_namespace: "mulang.inspection") }
    it { expect(Mulang::Inspection.parse(inspection_s).to_s).to eq inspection_s }
  end

  describe 'i18n' do
    before { I18n.locale = :es }

    it { expect(expectation('a', 'DeclaresAttribute:href="https://mumuki.org"').translate!).to eq '<strong>css:span</strong> debe declarar un estilo <strong>background-color:yellow</strong>' }
  end
end

