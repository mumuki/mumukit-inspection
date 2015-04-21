require_relative '../lib/mumukit/inspection'

include Mumukit

describe Inspection do
  it { expect(Inspection.parse('HasBinding').to_h).to eq(type: 'HasBinding', negated: false, target: nil) }
  it { expect(Inspection.parse('Not:HasBinding').to_h).to eq(type: 'HasBinding', negated: true, target: nil) }
  it { expect(Inspection.parse('HasUsage:m').to_h).to eq(type: 'HasUsage', negated: false, target: 'm') }
  it { expect(Inspection.parse('Not:HasUsage:m').to_h).to eq(type: 'HasUsage', negated: true, target: 'm') }
end
