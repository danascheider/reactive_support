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
  end
end