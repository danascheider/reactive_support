require 'spec_helper'

describe Hash do 
  let(:hash) { { :foo => 'bar', :baz => 'qux' } }

  describe 'assert_valid_keys' do 
    context 'all keys are valid' do 
      it 'returns the hash' do 
        expect(hash.assert_valid_keys(:foo, :baz)).to eql hash
      end

      it 'doesn\'t raise an error' do 
        expect{ hash.assert_valid_keys(:foo, :baz) }.not_to raise_error
      end
    end

    context 'keys are a subset of valid keys' do 
      it 'returns the hash' do 
        expect(hash.assert_valid_keys(:foo, :bar, :baz)).to eql hash
      end

      it 'doesn\'t raise an error' do 
        expect{ hash.assert_valid_keys(:foo, :bar, :baz) }.not_to raise_error
      end
    end

    context 'keys are wrong type' do 
      it 'raises an ArgumentError' do 
        expect{ hash.assert_valid_keys(:foo, 'baz') }.to raise_error(ArgumentError)
      end
    end

    context 'invalid keys are present' do 
      it 'raises an ArgumentError' do 
        expect{ hash.assert_valid_keys(:foo, 'baz') }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'stringify_keys' do 
    it 'turns symbol keys into strings' do 
      expect(hash.stringify_keys).to eql({'foo' => 'bar', 'baz' => 'qux'})
    end

    it 'maintains the original hash' do 
      expect { hash.stringify_keys }.not_to change(hash, :keys)
    end
  end

  describe 'stringify_keys!' do 
    it 'turns symbol keys into strings' do 
      expect(hash.stringify_keys!).to eql({'foo' => 'bar', 'baz' => 'qux'})
    end

    it 'overwrites the original hash' do
      expect { hash.stringify_keys! }.to change(hash, :keys)
    end
  end

  describe 'symbolize_keys' do 
    let(:hash) { {'foo' => 'bar' } }

    it 'turns string keys into symbols' do 
      expect(hash.symbolize_keys).to eql({:foo => 'bar'})
    end

    it 'maintains the original hash' do 
      expect { hash.symbolize_keys }.not_to change(hash, :keys)
    end
  end

  describe 'symbolize_keys!' do 
    let(:hash) { {'foo' => 'bar' } }

    it 'turns string keys into symbols' do 
      expect(hash.symbolize_keys!).to eql({:foo => 'bar'})
    end

    it 'overwrites the original hash' do
      expect{ hash.symbolize_keys! }.to change(hash, :keys)
    end
  end

  describe 'transform_keys' do  
    it 'changes keys according to a block' do 
      transformed = hash.transform_keys {|key| key.to_s.upcase }
      expect(transformed).to eql({'FOO' => 'bar', 'BAZ' => 'qux'})
    end

    it 'is non-destructive' do 
      expect{ hash.transform_keys {|key| key.to_s.upcase } }.not_to change(hash, :keys)
    end

    context 'no block given' do 
      it 'returns an enumerator' do 
        expect(hash.transform_keys).to be_an(Enumerator)
      end
    end
  end

  describe 'transform_keys!' do  
    it 'changes keys according to a block' do 
      transformed = hash.transform_keys! {|key| key.to_s.upcase }
      expect(transformed).to eql({'FOO' => 'bar', 'BAZ' => 'qux'})
    end

    it 'is destructive' do 
      expect{ hash.transform_keys! {|key| key.to_s.upcase } }.to change(hash, :keys)
    end

    context 'no block given' do 
      it 'returns an enum' do 
        expect(hash.transform_keys!).to be_an(Enumerator)
      end
    end
  end
end