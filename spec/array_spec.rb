require 'spec_helper' 

describe Array do 
  describe '#from method' do 
    context 'normal use' do 
      context 'positive position' do 
        it 'returns the end of the array' do 
          expect([1, 2, 3, 4, 5].from(2)).to eql [3, 4, 5]
        end
      end

      context 'negative position' do 
        it 'returns the end of the array' do 
          expect([1, 2, 3, 4, 5].from(-2)).to eql [4, 5]
        end
      end
    end

    context 'when array is empty' do 
      it 'returns an empty array' do 
        expect([].from(0)).to eql []
      end
    end

    context 'position higher than max index' do 
      it 'returns an empty array' do 
        expect([1, 2, 3, 4, 5].from(100)).to eql []
      end
    end

    context 'position lower than min index' do 
      it 'returns an empty array' do 
        expect([1, 2, 3].from(-4)).to eql []
      end
    end
  end

  describe '#to method' do 
    context 'normal use' do 
      context 'positive position' do 
        it 'returns the beginning of the array' do 
          expect([1, 2, 3, 4, 5].to(2)). to eql [1, 2, 3]
        end
      end

      context 'negative position' do 
        it 'returns the beginning of the array' do 
          expect([1, 2, 3, 4, 5].to(-2)).to eql [1, 2, 3, 4]
        end
      end
    end

    context 'when array is empty' do 
      it 'returns an empty array' do 
        expect([].to(0)).to eql []
      end
    end

    context 'position higher than max index' do 
      it 'returns the whole array' do 
        expect([1, 2, 3].to(10)).to eql [1, 2, 3]
      end
    end

    context 'position lower than min index' do 
      it 'returns an empty array' do 
        expect([1, 2, 3].to(-5)).to eql []
      end
    end
  end
end