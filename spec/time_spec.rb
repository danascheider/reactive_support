require 'spec_helper'

describe Time do 
  describe '#acts_like_time?' do 
    it 'returns true' do 
      t = Time.now
      expect(t.acts_like_time?).to be true
    end
  end
end