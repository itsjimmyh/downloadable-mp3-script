require 'spec_helper' 

describe ReversedExercise do

  describe '#initialize' do
    describe 'should initialize' do
      let(:ex1) { ReversedExercise.new }

      it 'with a reversed full clip' do
        expect(ex1.reversed).to eq true
      end
    end
  end
end
