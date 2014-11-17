require 'spec_helper'

describe ReactiveExtensions do 
  describe '#try_rescue method' do 
    context 'when self is nil' do 
      it 'returns nil' do 
        expect(nil.try_rescue(:collect) {|i| i + 2 }).to eql nil
      end
    end

    context 'when the method can be executed successfully' do 
      it 'calls the method' do 
        expect('foo'.try_rescue(:upcase)).to eql 'FOO'
      end
    end

    context 'when a NoMethodError is raised' do 
      it 'returns nil' do 
        expect(('foo').try_rescue(:bar)).to eql nil
      end
    end
  end

  describe 'array methods' do 
    let(:sartre) { { 'name' => 'Jean-Paul Sartre', 'nationality' => 'French' } }
    let(:russell) { { 'name' => 'Bertrand Russell', 'nationality' => 'English' } }
    let(:wittgenstein) { { 'name' => 'Ludwig Wittgenstein', 'nationality' => 'Austrian' } }
    let(:camus) { { 'name' => 'Albert Camus', 'nationality' => 'French' } }
    let(:array) { [sartre, russell, wittgenstein, camus] }

    describe 'array #scope method' do 
      context 'symbol keys' do
        context 'single value' do 
          it 'returns scoped hashes' do 
            array.each {|hash| hash.symbolize_keys! }
            expect(array.scope(:nationality, 'French')).to eql([sartre, camus])
          end
        end

        context 'multiple values' do 
          it 'returns scoped hashes' do 
            array.each {|hash| hash.symbolize_keys! }
            expect(array.scope(:nationality, 'French', 'English')).to eql([sartre, russell, camus])
          end
        end
      end

      context 'string keys' do
        context 'single value' do 
          it 'returns scoped hashes' do 
            expect(array.scope('nationality', 'French')).to eql([sartre, camus])
          end
        end

        context 'multiple values' do 
          it 'returns scoped hashes' do 
            expect(array.scope('nationality', 'French', 'English')).to eql([sartre, russell, camus])
          end
        end
      end
    end

    describe 'array #where_not method' do 
      context 'symbol keys' do 
        context 'single value' do 
          it 'returns scoped hashes' do 
            array.each {|hash| hash.symbolize_keys! }
            expect(array.where_not(:nationality, 'French')).to eql([russell, wittgenstein])
          end
        end

        context 'multiple values' do 
          it 'returns scoped hashes' do 
            array.each {|hash| hash.symbolize_keys! }
            expect(array.where_not(:nationality, 'French', 'English')).to eql([wittgenstein])
          end
        end
      end

      context 'string keys' do
        context 'single value' do 
          it 'returns scoped hashes' do 
            expect(array.where_not('nationality', 'French')).to eql([russell, wittgenstein])
          end
        end

        context 'multiple values' do 
          it 'returns scoped hashes' do 
            expect(array.where_not('nationality', 'French', 'English')).to eql([wittgenstein])
          end
        end
      end
    end
  end

  describe 'hash methods' do 
    describe 'symbolize_keys' do 
      it 'turns string keys into symbols' do 
        expect({'foo' => 'bar'}.symbolize_keys).to eql({:foo => 'bar'})
      end

      it 'maintains the original hash' do 
        hash = { 'foo' => 'bar' }
        expect { hash.symbolize_keys }.not_to change(hash, :keys)
      end
    end

    describe 'symbolize_keys!' do 
      it 'turns string keys into symbols' do 
        expect({'foo' => 'bar'}.symbolize_keys!).to eql({:foo => 'bar'})
      end

      it 'overwrites the original hash' do
        hash = { 'foo' => 'bar' }
        expect { hash.symbolize_keys! }.to change(hash, :keys)
      end
    end

    describe 'stringify_keys' do 
      it 'turns symbol keys into strings' do 
        expect({foo: 'bar'}.stringify_keys).to eql({'foo' => 'bar'})
      end

      it 'maintains the original hash' do 
        hash = { foo: 'bar' }
        expect { hash.stringify_keys }.not_to change(hash, :keys)
      end
    end

    describe 'stringify_keys!' do 
      it 'turns symbol keys into strings' do 
        expect({foo: 'bar'}.stringify_keys!).to eql({'foo' => 'bar'})
      end

      it 'overwrites the original hash' do
        hash = { foo: 'bar' }
        expect { hash.stringify_keys! }.to change(hash, :keys)
      end
    end
  end
end