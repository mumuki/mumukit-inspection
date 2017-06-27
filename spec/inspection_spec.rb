require_relative './spec_helper'


describe Mumukit::Inspection do
  it { expect(Mumukit::Inspection.parse('HasBinding').to_h).to eq(type: 'HasBinding', negated: false  ) }
  it { expect(Mumukit::Inspection.parse('Not:HasBinding').to_h).to eq(type: 'HasBinding', negated: true) }
  it { expect(Mumukit::Inspection.parse('HasUsage:m').to_h).to eq(type: 'HasUsage', negated: false, target: 'm') }
  it { expect(Mumukit::Inspection.parse('Not:HasUsage:m').to_h).to eq(type: 'HasUsage', negated: true, target: 'm') }

  it { expect(Mumukit::Inspection.parse('HasUsage:=m').to_h).to eq(type: 'HasUsage', negated: false, target: 'm') }
  it { expect(Mumukit::Inspection.parse('HasUsage:~m').to_h).to eq(type: 'HasUsage',
                                                                   negated: false,
                                                                   target: struct(type: 'like', value: 'm')) }
  it { expect(Mumukit::Inspection.parse('Not:HasUsage:~m').to_h).to eq(type: 'HasUsage',
                                                                       negated: true,
                                                                       target: struct(type: 'like', value: 'm')) }
  it { expect(Mumukit::Inspection.parse('HasUsage:*').to_h).to eq(type: 'HasUsage',
                                                                  negated: false,
                                                                  target: struct(type: 'anyone')) }

  it { expect(Mumukit::Inspection.parse_binding_name('foo')).to eq 'foo' }
  it { expect(Mumukit::Inspection.parse_binding_name('Intransitive:foo')).to eq 'foo' }
end
