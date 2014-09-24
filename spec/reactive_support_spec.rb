require 'spec_helper'

describe ReactiveSupport do 
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