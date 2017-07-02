require_relative './spec_helper'


describe Mumukit::Inspection do
  it { expect(Mumukit::Inspection.parse('Declares')).to json_like(type: 'Declares',
                                                                negated: false,
                                                                target: nil) }

  it { expect(Mumukit::Inspection.parse('Not:Declares')).to json_like(type: 'Declares',
                                                                    negated: true,
                                                                    target: nil) }

  it { expect(Mumukit::Inspection.parse('Uses:m')).to json_like(type: 'Uses',
                                                              negated: false,
                                                              target: { type: :unknown, value: 'm' }) }

  it { expect(Mumukit::Inspection.parse('Not:Uses:m')).to json_like(type: 'Uses',
                                                                  negated: true,
                                                                  target: { type: :unknown, value: 'm' }) }

  it { expect(Mumukit::Inspection.parse('Uses:^foo')).to json_like(type: 'Uses',
                                                                  negated: false,
                                                                  target: { type: :except, value: 'foo' }) }

  it { expect(Mumukit::Inspection.parse('Uses:=m')).to json_like(type: 'Uses',
                                                               negated: false,
                                                               target: { type: :named, value: 'm' }) }
  it { expect(Mumukit::Inspection.parse('Uses:~m')).to json_like(type: 'Uses',
                                                               negated: false,
                                                               target: { type: :like, value: 'm' }) }
  it { expect(Mumukit::Inspection.parse('Not:Uses:~m')).to json_like(type: 'Uses',
                                                                   negated: true,
                                                                   target: { type: :like, value: 'm' }) }
  it { expect(Mumukit::Inspection.parse('Uses:*')).to json_like(type: 'Uses',
                                                              negated: false,
                                                              target: {type: 'anyone', value: nil}) }

  it { expect(Mumukit::Inspection.parse_binding_name('foo')).to eq 'foo' }
  it { expect(Mumukit::Inspection.parse_binding_name('Intransitive:foo')).to eq 'foo' }
end
