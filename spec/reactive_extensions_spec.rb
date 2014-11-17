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

  describe 'array #scope method' do 
    context 'symbol keys' do 
      let(:sartre) { { name: 'Jean-Paul Sartre', nationality: 'French' } }
      let(:russell) { { name: 'Bertrand Russell', nationality: 'English' } }
      let(:wittgenstein) { { name: 'Ludwig Wittgenstein', nationality: 'Austrian' } }
      let(:camus) { { name: 'Albert Camus', nationality: 'French' } }
      let(:array) { [sartre, russell, wittgenstein, camus] }

      it 'returns scoped hashes' do 
        expect(array.scope(:nationality, 'French')).to eql([sartre, camus])
      end
    end

    context 'string keys' do
      let(:sartre) { {'name' => 'Jean-Paul Sartre', 'nationality' => 'French' } }
      let(:russell) { { 'name' => 'Bertrand Russell', 'nationality' => 'English' } }
      let(:wittgenstein) { { 'name' => 'Ludwig Wittgenstein', 'nationality' => 'Austrian' } }
      let(:camus) { { 'name' => 'Albert Camus', 'nationality' => 'French' } }
      let(:array) { [sartre, russell, wittgenstein, camus] }

      it 'returns scoped hashes' do 
        expect(array.scope('nationality', 'French')).to eql([sartre, camus])
      end
    end
  end
end