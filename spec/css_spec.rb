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

    it { expect(expectation('css:span', 'DeclaresStyle:background-color:yellow').translate!).to eq '<code>css:span</code> debe declarar un estilo <code>background-color:yellow</code>' }
    it { expect(expectation('html/body/section/article/h4', 'DeclaresAttribute:class="titulo-pelicula"').translate!).to eq '<code>html/body/section/article/h4</code> debe declarar un atributo <code>class="titulo-pelicula"</code>' }
    it { expect(expectation('html/body/section/nav', 'DeclaresTag:ul').translate!).to eq '<code>html/body/section/nav</code> debe declarar un elemento <code>ul</code>' }
  end
end
