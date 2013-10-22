require 'delegate'

class KVC < SimpleDelegator

  def for_path(path)
    segments = path.split('.')

    segments.inject(self) do |value, s|
      if !value.respond_to?(:has_key?)
        raise ArgumentError.new("Expected #{value} to respond to has_key?")
      end

      if value.has_key?(s)
        value[s]
      else
        raise KeyError.new("Missing key #{s}")
      end
    end
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

    it "raises KeyError when a path segment isn't found" do
      expect { obj.for_path('bar.quux') }.to raise_exception(KeyError)
    end

    it "doesn't traverse objects without has_key?" do
      expect { obj.for_path('foo.quux') }.to raise_exception(ArgumentError)
    end

  end

end

if __FILE__ == $0
  best_beatles = KVC.new({"paul" => {"beatles" => "Hey, Jude", "solo" => "Jet"}})
  solo = best_beatles.for_path("paul.solo")
  puts "Paul's best solo song is: #{solo}"
end

