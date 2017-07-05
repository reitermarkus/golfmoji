# frozen_string_literal: true

require 'golfmoji/executor'

describe Golfmoji::Executor do
  subject do described_class.new(mojis, argv) end
  let(:mojis) { [] }
  let(:argv) { [] }

  context 'when there are no mojis' do
    context 'and no arguments are given' do
      it 'returns nil' do
        expect(subject.execute).to be nil
      end
    end

    context 'and arguments are given' do
      let(:argv) { ['arg1', 'arg2'] }

      it 'returns the last argument' do
        expect(subject.execute).to eq 'arg2'
      end
    end
  end
end
