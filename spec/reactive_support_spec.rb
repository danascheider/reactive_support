require 'spec_helper'

describe ReactiveSupport do 
  describe '#blank? method' do 
    context 'when true' do 
      hash = {
        'empty string'      => '',
        'whitespace string' => '   ',
        'FalseClass'        => false,
        'NilClass'          => nil,
        'empty array'       => [],
        'empty hash'        => {} 
      }

      hash.each do |k,v|
        specify "#{k} returns true" do 
          expect(v.blank?).to be true 
        end
      end
    end

    context 'when false' do 
      hash = {
        'non-blank object'              => 'foo',
        'TrueClass'                     => true,
        'enumerable with blank members' => [nil, false],
        'numeric'                       => 10
      }

      hash.each do |k,v|
        specify "#{k} returns false" do 
          expect(v.blank?).to be false
        end
      end
    end
  end

  describe '#deep_dup method' do 
    context 'duplicable object' do 
      before(:each) do 
        @str = 'foo'
      end

      it 'returns a duplicate' do 
        expect(@str.deep_dup).not_to be @str
      end

      it 'does not affect the original' do 
        @str.deep_dup.instance_variable_set(:@a, 1)
        expect(@string.instance_variable_get(:@a)).to eql nil
      end
    end

    context 'non-duplicable object' do 
      it 'returns itself' do 
        num = 10
        expect(num.deep_dup).to be num
      end
    end

    context 'array' do 
      it 'does not affect the original' do 
        arr = [ [1, 2], 3 ]
        arr.deep_dup[0][1] = 4
        expect(arr[0][1]).to eql 2
      end
    end

    context 'hash' do 
      it 'does not affect the original' do 
        h = { foo: { bar: 1 } }
        h.deep_dup[:foo][:bar] = 10
        expect(h[:foo][:bar]).to eql 1
      end
    end
  end

  describe '#duplicable? method' do 
    context 'when true' do 
      it 'returns true' do 
        expect(['foo', 'bar', 'baz'].duplicable?).to be true
      end
    end

    context 'when false' do 
      hash = {
        'NilClass'   => nil,
        'FalseClass' => false,
        'TrueClass'  => true,
        'symbol'     => :symbol,
        'numeric'    => 10,
        'method'     => method(:puts)
      }

      hash.each do |k,v|
        specify "#{k} returns false" do 
          expect(v.duplicable?).to be false
        end
      end
    end

    context 'BigDecimal' do 
      let(:dec) { BigDecimal.new('4.56') }

      before(:each) do 
        @condition = !!(RUBY_VERSION =~ /^1\.9/ || RUBY_VERSION =~ /jruby/)
      end
      context 'Ruby version >= 2.0.0' do 
        it 'returns true' do 
          expect(dec.duplicable?).to be true unless @condition 
        end
      end

      context 'Ruby version 1.9.x' do 
        it 'returns false' do 
          expect(dec.duplicable?).to be false if @condition
        end

        it 'doesn\'t raise an error' do 
          expect{ dec.duplicable? }.not_to raise_error if @condition
        end
      end
    end
  end

  describe '#exist? method' do 
    context 'existent object' do 
      it 'returns true' do 
        expect({foo: :bar}.exist?).to be true 
      end
    end

    context 'nil' do 
      it 'returns false' do 
        expect(nil.exist?).to be false
      end
    end
  end

  describe '#exists? method' do 
    context 'existent object' do 
      it 'returns true' do 
        expect({foo: :bar}.exists?).to be true
      end
    end

    context 'nil' do 
      it 'returns false' do 
        expect(nil.exists?).to be false
      end
    end
  end

  describe '#in? method' do 
    context 'when true' do 
      hash = { 
        'array contains calling object'        => ['foo', 'bar', 'baz'],
        'hash contains the given key'          => { 'foo' => 'bar' },
        'string contains the given characters' => 'foolish'
      }

      hash.each do |k,v|
        specify k do 
          expect('foo'.in? v).to be true 
        end
      end
    end

    context 'when false' do 
      hash = {
        'array doesn\'t contain calling object'    => ['bar', 'baz'],
        'hash doesn\'t contain given key'          => { bar: :baz },
        'string doesn\'t contain given characters' => 'something else'
      }

      hash.each do |k,v|
        specify k do 
          expect('foo'.in? v).to be false 
        end
      end
    end

    context 'error' do 
      hash = {
        'incompatible data types' => [{foo: 'bar'}, 'foobar', TypeError],
        'invalid parameter'       => [10, 1000, ArgumentError]
      }

      hash.each do |k,v|
        specify k do 
          expect{ v[0].in? v[1] }.to raise_error(v[2])
        end
      end
    end
  end

  describe '#instance_values' do 
    before(:each) do 
      class C
        def initialize(x,y)
          @x, @y = x, y
        end
      end

      @c = C.new('foo', 'bar')
    end

    it 'returns a hash' do 
      expect(@c.instance_values).to be_a(Hash)
    end

    it 'uses instance variable names without @ as keys' do 
      ['x', 'y'].each {|var| expect(@c.instance_values).to have_key(var) }
    end

    it 'returns variable values' do 
      [['x', 'foo'], ['y','bar']].each {|(var, val)| expect(@c.instance_values[var]). to eql val }
    end
  end

  describe '#present? method' do 
    context 'when true' do 
      hash = {
        'non-empty object'              => ['foo'],
        'TrueClass'                     => true, 
        'enumerable with blank members' => [nil, false],
        'numeric'                       => 8.2
      }

      hash.each do |k,v|
        specify k do 
          expect(v.present?).to be true 
        end
      end
    end

    context 'when false' do 
      hash = {
        'empty string'      => '',
        'whitespace string' => '   ',
        'FalseClass'        => false,
        'NilClass'          => nil,
        'empty array'       => [],
        'empty hash'        => {}
      }

      hash.each do |k,v|
        specify k do 
          expect(v.present?).to be false 
        end
      end
    end
  end

  describe '#try method' do 
    context 'no args' do 
      context 'when the method can be called' do 
        it 'calls the method on the object' do 
          expect(10.try(:to_s)).to eql '10'
        end
      end

      context 'when the method can\'t be called' do 
        it 'returns nil' do 
          expect(10.try(:to_h)).to eql nil
        end
      end
    end

    context 'plain vanilla args' do 
      context 'when the method can be called' do 
        it 'calls the method on the object' do 
          expect({foo: 'bar'}.try(:has_key?, :foo)).to be true
        end
      end

      context 'when the method can\'t be called' do 
        it 'returns nil' do 
          expect(127.try(:join, '!')).to eql nil
        end
      end
    end

    context 'block args' do 
      context 'when the method can be called' do 
        it 'calls the method' do 
          hash = { foo: 3, bar: 8, baz: 112 }
          expect(hash.try(:reject!) {|k,v| v < 100 }).to eql({ baz: 112 })
        end
      end

      context 'when the method can\'t be called' do 
        it 'returns nil' do 
          expect(82.68.try(:reject!) {|k,v| v < 100 }).to eql nil
        end
      end
    end

    context 'nonsensical args' do 
      it 'returns nil' do 
        expect(%w(foo, bar, baz).try(:join, [:foo, :bar, :baz])). to eql nil
      end
    end
  end
end