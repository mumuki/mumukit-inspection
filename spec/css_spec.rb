require_relative './spec_helper'

describe Mumukit::Inspection::Css do
  before { Mulang::Inspection.register_extension! Mumukit::Inspection::Css }
  after { Mulang::Inspection.unregister_extension! Mumukit::Inspection::Css }

  describe 'parsing' do
    let(:inspection_s) { 'DeclaresStyle:background-color:yellow' }

    it { expect(Mulang::Inspection.parse(inspection_s)).to json_like(type: 'DeclaresStyle',
                                                                      target: { type: :unknown, value: 'background-color:yellow' },
                                                                      negated: false,
                                                                      i18n_namespace: "mumukit.inspection") }
    it { expect(Mulang::Inspection.parse(inspection_s).to_s).to eq inspection_s }
  end

  describe 'i18n' do
    before { I18n.locale = :es }

    it { expect(expectation('css:span', 'DeclaresStyle:background-color:yellow').translate!).to eq '<strong>css:span</strong> debe declarar un estilo <strong>background-color:yellow</strong>' }
    it { expect(expectation('html/body/section/article/h4', 'DeclaresAttribute:class="titulo-pelicula"').translate!).to eq '<strong>html/body/section/article/h4</strong> debe declarar un atributo <strong>class="titulo-pelicula"</strong>' }
    it { expect(expectation('html/body/section/nav', 'DeclaresTag:ul').translate!).to eq '<strong>html/body/section/nav</strong> debe declarar un elemento <strong>ul</strong>' }
  end
end
