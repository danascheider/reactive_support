require 'spec_helper'

describe Hash do 
  let(:hash) { { :foo => 'bar', :baz => 'qux' } }

  describe 'transform_keys' do  
    it 'changes keys according to a block' do 
      transformed = hash.transform_keys {|key| key.to_s.upcase }
      expect(transformed).to eql({'FOO' => 'bar', 'BAZ' => 'qux'})
    end

    it 'is non-destructive' do 
      expect{ hash.transform_keys {|key| key.to_s.upcase } }.not_to change(hash, :keys)
    end

    context 'no block given' do 
      it 'returns an enum' do 
        transformed = hash.transform_keys
        expect(transformed).to be_an(Enumerable)
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
        transformed = hash.transform_keys!
        expect(transformed).to be_an(Enumerable)
      end
    end
  end
end