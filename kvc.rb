require 'delegate'

class KVC < SimpleDelegator

  def for_path(path)
    segments = path.split('.')

    value = self
    while segments.size > 0
      current = segments.shift
      value = value[current]
    end

    value
  end

end

if defined?(RSpec)

  describe "key-value coding" do
    let(:obj) { KVC.new({'foo' => 1, 'bar' => {'baz' => 3}}) }

    it "traverses direct key paths" do
      expect(obj.for_path('foo')).to eq(1)
      expect(obj.for_path('bar')).to eq({'baz' => 3})
    end

    it "traverses two-level key paths" do
      expect(obj.for_path('bar.baz')).to eq(3)
    end

    it "behaves like an Enumerable" do
      expect(obj.respond_to?(:size)).to be_true
      expect(obj.size).to eq(2)
      expect(obj.keys).to eq(['foo', 'bar'])
      expect(obj.map { |k, v| k }).to eq(['foo', 'bar'])
    end

  end

end

if __FILE__ == $0
  best_beatles = KVC.new({"paul" => {"beatles" => "Hey, Jude", "solo" => "Jet"}})
  solo = best_beatles.for_path("paul.solo")
  puts "Paul's best solo song is: #{solo}"
end

