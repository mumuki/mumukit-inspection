require('./inspection.js');

var Expectation = {
  $impl: Opal.const_get_qualified(Opal.const_get_qualified(Opal.const_get_relative([], 'Mumukit'), 'Inspection'), 'Expectation'),
  parse: function(binding, inspection) {
    return this.$impl.$parse(Opal.hash2(["binding", "inspection"], {"binding": binding, "inspection": inspection}));
  }
}




puts "I am a Mumukit::Inspection
The result of Mumukit::Inspection.parse('Not:Uses:foo').negated? is #{Mumukit::Inspection.parse('Not:Uses:foo').negated?}

#{Mumukit::Inspection::Expectation.parse(binding:'foo', inspection: 'Not:Uses:bar')}"

puts "
#{Mumukit::Inspection::Expectation.parse(binding:'foo', inspection: 'Not:Uses:bar').translate}

"


console.log(MumukitExpectation.parse("foo", "Not:Uses:bar"));


