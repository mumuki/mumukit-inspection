require_relative './spec_helper'


describe Mumukit::Inspection do
  it { expect(Mumukit::Inspection.parse('Declares').to_h).to eq(type: 'Declares',
                                                                  negated: false,
                                                                  target: struct(type: :anyone)  ) }

  it { expect(Mumukit::Inspection.parse('Not:Declares').to_h).to eq(type: 'Declares',
                                                                      negated: true,
                                                                      target: struct(type: :anyone)) }

  it { expect(Mumukit::Inspection.parse('Uses:m').to_h).to eq(type: 'Uses',
                                                                  negated: false,
                                                                  target: struct(type: :named, value: 'm')) }

  it { expect(Mumukit::Inspection.parse('Not:Uses:m').to_h).to eq(type: 'Uses',
                                                                      negated: true,
                                                                      target: struct(type: :named, value: 'm') ) }

  it { expect(Mumukit::Inspection.parse('Uses:^foo').to_h).to eq(type: 'Uses',
                                                                      negated: false,
                                                                      target: struct(type: :except, value: 'foo') ) }

  it { expect(Mumukit::Inspection.parse('Uses:=m').to_h).to eq(type: 'Uses',
                                                                   negated: false,
                                                                   target: struct(type: :named, value: 'm')) }
  it { expect(Mumukit::Inspection.parse('Uses:~m').to_h).to eq(type: 'Uses',
                                                                   negated: false,
                                                                   target: struct(type: :like, value: 'm')) }
  it { expect(Mumukit::Inspection.parse('Not:Uses:~m').to_h).to eq(type: 'Uses',
                                                                       negated: true,
                                                                       target: struct(type: :like, value: 'm')) }
  it { expect(Mumukit::Inspection.parse('Uses:*').to_h).to eq(type: 'Uses',
                                                                  negated: false,
                                                                  target: struct(type: :anyone)) }

  it { expect(Mumukit::Inspection.parse_binding_name('foo')).to eq 'foo' }
  it { expect(Mumukit::Inspection.parse_binding_name('Intransitive:foo')).to eq 'foo' }
end
