require 'spec_helper' 

describe Array do 
  describe 'append' do 
    it 'adds the item to the end of the array' do 
      expect([1, 2, 3].append(4)).to eql([1, 2, 3, 4])
    end
  end

  describe 'extract_options!' do 
    context 'when there are options' do 
      let(:array) { ['a', 'b', :foo => :bar] }

      it 'returns the options' do 
        expect(array.extract_options!).to eql({:foo => :bar})
      end

      it 'is destructive' do 
        expect{ array.extract_options! }.to change(array, :length)
      end
    end

    context 'when there are no options' do 
      it 'returns an empty hash' do 
        expect(['a', 'b'].extract_options!).to eql({})
      end
    end
  end

  describe 'from' do 
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

  describe 'prepend' do 
    it 'adds the item to the front of the array' do 
      expect([1, 2, 3].prepend(0)).to eql([0, 1, 2, 3])
    end
  end

  describe 'to' do 
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