require_relative './spec_helper'

describe Mumukit::Inspection::Source do
  before { Mulang::Inspection.register_extension! Mumukit::Inspection::Source }
  after { Mulang::Inspection.unregister_extension! Mumukit::Inspection::Source }

  describe 'parsing' do
    let(:inspection_s) { 'SourceEquals:Put(Green)' }

    it { expect(Mulang::Inspection.parse(inspection_s)).to json_like(type: 'SourceEquals',
                                                                      target: { type: :unknown, value: 'Put(Green)' },
                                                                      negated: false,
                                                                      i18n_namespace: "mumukit.inspection") }
    it { expect(Mulang::Inspection.parse(inspection_s).to_s).to eq inspection_s }
  end

  describe 'i18n' do
    before { I18n.locale = :es }

    describe 'source exectations' do
      it { expect(expectation('*', 'SourceRepeats:foo(X)').translate).to eq('la solución debe usar <code>foo(X)</code> más de una vez') }
      it { expect(expectation('*', 'SourceContains:foo(X)').translate).to eq('la solución debe usar <code>foo(X)</code>') }
      it { expect(expectation('*', 'SourceEquals:foo(X)').translate).to eq('la solución debe ser igual a <code>foo(X)</code>') }
      it { expect(expectation('*', 'SourceEqualsIgnoreSpaces:foo(X)').translate).to eq('la solución debe ser igual a <code>foo(X)</code>') }
    end
  end
end
