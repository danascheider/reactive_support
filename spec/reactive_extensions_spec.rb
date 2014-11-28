require 'spec_helper'

describe 'ReactiveExtensions' do 
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

    describe 'clean' do 
      context 'when no cleaning is needed' do 
        it 'returns the original hash' do 
          expect({:foo => 'bar'}.clean(:baz)). to eql({:foo => 'bar'})
        end

        it 'doesn\'t raise an error' do 
          expect{ {:foo => 'bar'}.clean(:baz) }.not_to raise_error
        end
      end

      context 'when there are some keys to clean' do 
        it 'removes specified keys' do 
          expect({:foo => 'bar', :baz => 'qux'}.clean(:baz)).to eql({:foo => 'bar'})
        end

        it 'doesn\'t change the original hash' do 
          hash = {:foo => 'bar', :baz => 'qux', 'norf' => 'raboof'}
          expect{ hash.clean(:baz, 'norf') }.not_to change(hash, :keys)
        end
      end

      context 'when all keys must be cleaned' do 
        it 'returns an empty hash' do 
          expect({:foo => 'bar'}.clean(:foo)).to eql({})
        end

        it 'doesn\'t change the original hash' do 
          hash = {:foo => 'bar'}
          expect{ hash.clean(:foo) }.not_to change(hash, :keys)
        end
      end
    end

    describe 'clean!' do 
      context 'when no cleaning is needed' do 
        it 'returns the original hash' do 
          expect({:foo => 'bar'}.clean!(:baz)). to eql({:foo => 'bar'})
        end

        it 'doesn\'t raise an error' do 
          expect{ {:foo => 'bar'}.clean(:baz) }.not_to raise_error
        end
      end

      context 'when there are some keys to clean' do 
        it 'removes specified keys' do 
          expect({:foo => 'bar', :baz => 'qux'}.clean!(:baz)).to eql({:foo => 'bar'})
        end

        it 'changes the original hash' do 
          hash = {:foo => 'bar', :baz => 'qux', 'norf' => 'raboof'}
          expect{ hash.clean!(:baz, 'norf') }.to change(hash, :keys)
        end

        it 'returns the hash' do 
          hash = {:foo => 'bar', :baz => 'qux'}
          expect(hash.clean!(:baz)).to eql hash
        end
      end

      context 'when all keys must be cleaned' do 
        it 'returns an empty hash' do 
          expect({:foo => 'bar'}.clean!(:foo)).to eql({})
        end

        it 'changes the original hash' do 
          hash = {:foo => 'bar'}
          expect{ hash.clean!(:foo) }.to change(hash, :keys)
        end

        it 'returns the hash' do 
          hash = {:foo => 'bar'}
          expect(hash.clean!(:foo)).to eql hash
        end
      end
    end
  end

  describe 'proc methods' do 
    describe 'raises_error?' do
      let(:proc) { Proc.new {|quotient| 1.quo(quotient) } }

      context 'when an error is raised' do 
        it 'returns true' do 
          expect(proc.raises_error?(0)).to be true
        end

        it 'handles the exception' do 
          expect{ proc.raises_error?(0) }.not_to raise_error
        end
      end

      context 'when no error is raised' do 
        it 'returns false' do 
          expect(proc.raises_error?(2)).to be false
        end

        it 'doesn\'t change objects' do 
          h, p = {:foo => :bar}, Proc.new {|hash| hash.reject! {|k,v| k === :foo } }
          expect{ p.raises_error?(h) }.not_to change(h, :length)
        end
      end
    end
  end
end