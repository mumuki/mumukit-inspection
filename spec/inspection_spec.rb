require '../lib/mumukit/inspection'

include Mumukit

describe Inspection do
  it { expect(Inspection.parse('HasBinding').to_h).to eq(type: 'HasBinding', must: 'must', target: nil) }
  it { expect(Inspection.parse('Not:HasBinding').to_h).to eq(type: 'HasBinding', must: 'must_not', target: nil) }
  it { expect(Inspection.parse('HasUsage:m').to_h).to eq(type: 'HasUsage', must: 'must', target: 'm') }
  it { expect(Inspection.parse('Not:HasUsage:m').to_h).to eq(type: 'HasUsage', must: 'must_not', target: 'm') }
end
