class Mumukit::Inspection::Target
  attr_accessor :type, :value

  def initialize(type, value=nil)
    @type = type
    @value = value
  end

  def self.parse(target_s)
    if target_s.blank? || target_s == '*'
      anyone
    elsif target_s.start_with? '^'
      new :except, target_tail(target_s)
    elsif target_s.start_with? '~'
      new :like, target_tail(target_s)
    elsif target_s.start_with? '='
      named target_tail(target_s)
    else
      named target_s
    end
  end

  def self.target_tail(target_s)
    target_s[1..-1]
  end

  def self.named(value)
    new(:named, value)
  end

  def self.anyone
    new(:anyone)
  end
end
