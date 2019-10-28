require_relative './spec_helper'

describe Mumukit::Inspection::Html do
  before { Mulang::Inspection.register_extension! Mumukit::Inspection::Html }
  after { Mulang::Inspection.unregister_extension! Mumukit::Inspection::Html }

  describe 'parsing' do
    context 'with href' do
      let(:inspection_s) { 'DeclaresAttribute:href="https://mumuki.org"' }

      it { expect(Mulang::Inspection.parse(inspection_s)).to json_like(type: 'DeclaresAttribute',
                                                                       target: { type: :unknown, value: 'href="https://mumuki.org"' },
                                                                       negated: false,
                                                                       i18n_namespace: "mumukit.inspection") }
      it { expect(Mulang::Inspection.parse(inspection_s).to_s).to eq inspection_s }
    end

    context 'with src' do
      let(:inspection_s) { 'DeclaresAttribute:src="https://mumuki.org"' }

      it { expect(Mulang::Inspection.parse(inspection_s)).to json_like(type: 'DeclaresAttribute',
                                                                       target: { type: :unknown, value: 'src="https://mumuki.org"' },
                                                                       negated: false,
                                                                       i18n_namespace: "mumukit.inspection") }
      it { expect(Mulang::Inspection.parse(inspection_s).to_s).to eq inspection_s }
    end
  end

  describe 'i18n' do
    before { I18n.locale = :es }

    it { expect(expectation('a', 'DeclaresAttribute:href="https://mumuki.org"').translate!).to eq '<strong>a</strong> debe declarar un atributo HTML <strong>href="https://mumuki.org"</strong>' }
  end
end

