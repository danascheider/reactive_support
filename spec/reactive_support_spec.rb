require 'spec_helper'

describe ReactiveSupport do 
  describe '#blank? method' do 
    context 'empty string' do 
      it 'returns true' do 
        expect(''.blank?).to be true
      end
    end

    context 'whitespace string' do 
      it 'returns true' do 
        expect('  '.blank?).to be true
      end
    end

    context 'FalseClass' do 
      it 'returns true' do 
        expect(false.blank?).to be true
      end
    end

    context 'nil' do 
      it 'returns true' do 
        expect(nil.blank?).to be true
      end
    end

    context 'empty array' do 
      it 'returns true' do 
        expect([].blank?).to be true
      end
    end

    context 'empty hash' do 
      it 'returns true' do 
        expect({}.blank?).to be true 
      end
    end

    context 'non-blank object' do 
      it 'returns false' do 
        expect('foo'.blank?).to be false
      end
    end

    context 'TrueClass' do 
      it 'returns false' do 
        expect(true.blank?).to be false 
      end
    end

    context 'enumerable with blank members' do 
      it 'returns false' do 
        expect([nil, false].blank?).to be false
      end
    end

    context 'numeric' do 
      it 'returns false' do 
        expect(10.blank?).to be false 
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
    context 'NilClass' do 
      it 'returns false' do 
        expect(nil.duplicable?).to be false
      end
    end

    context 'FalseClass' do 
      it 'returns false' do 
        expect(false.duplicable?).to be false 
      end
    end

    context 'TrueClass' do 
      it 'returns false' do 
        expect(true.duplicable?).to be false 
      end
    end

    context 'Symbol' do 
      it 'returns false' do 
        expect(:foo.duplicable?).to be false
      end
    end

    context 'Numeric' do 
      it 'returns false' do 
        expect(10.duplicable?).to be false
      end
    end

    context 'Method' do 
      it 'returns false' do 
        expect(method(:puts).duplicable?).to be false
      end
    end

    context 'BigDecimal' do 
      it 'returns true' do 
        result = (RUBY_VERSION =~ /^1\.9/) ? false : true
        expect(BigDecimal.new('4.56').duplicable?).to be result
      end
    end

    context 'when true' do 
      it 'returns true' do 
        expect(['foo', 'bar', 'baz'].duplicable?).to be true
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
    context 'array' do 
      context 'when the array contains the given object' do 
        it 'returns true' do 
          expect('foo'.in? ['foo', 'bar', 'baz']).to be true
        end
      end

      context 'when the array does not contain the given object' do 
        it 'returns false' do 
          expect('foo'.in? ['bar', 'baz']).to be false 
        end
      end
    end

    context 'hash' do 
      context 'when the hash contains the given key' do 
        it 'returns true' do 
          expect(:foo.in?({foo: 'bar'})).to be true 
        end
      end

      context 'when the hash does not contain the given key' do 
        it 'returns false' do 
          expect('bar'.in?({foo: 'bar'})).to be false 
        end
      end
    end

    context 'string' do 
      context 'when the string contains the given characters' do 
        it 'returns true' do 
          expect('bar'.in? 'foobar').to be true
        end
      end

      context 'when the string does not contain the given characters' do 
        it 'returns false' do 
          expect('bar'.in? 'raboof').to be false 
        end
      end
    end

    context 'different data types' do 
      it 'raises TypeError' do 
        expect{{ foo: 'bar' }.in? 'foobar'}.to raise_error(TypeError)
      end
    end

    context 'invalid parameter' do 
      it 'raises an error' do 
        expect{ '10'.in? 1000 }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#present? method' do 
    context 'when absent' do 
      context 'empty string' do 
        it 'returns false' do 
          expect(''.present?).to be false
        end
      end

      context 'whitespace string' do 
        it 'returns false' do 
          expect('  '.present?).to be false
        end
      end

      context 'FalseClass' do 
        it 'returns false' do 
          expect(false.present?).to be false
        end
      end

      context 'NilClass' do 
        it 'returns false' do 
          expect(nil.present?).to be false
        end
      end

      context 'empty array' do 
        it 'returns false' do 
          expect([].present?).to be false 
        end
      end

      context 'empty hash' do 
        it 'returns false' do 
          expect({}.present?).to be false 
        end
      end
    end

    context 'when present' do 
      context 'non-empty object' do 
        it 'returns true' do 
          expect(['foo'].present?).to be true 
        end
      end

      context 'TrueClass' do 
        it 'returns true' do 
          expect(true.present?).to be true 
        end
      end

      context 'enumerable with blank members' do 
        it 'returns true' do 
          expect([false, nil, ''].present?).to be true 
        end
      end

      context 'Numeric' do 
        it 'returns true' do 
          expect(10.present?).to be true
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