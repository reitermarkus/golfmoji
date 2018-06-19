# frozen_string_literal: true

require_relative '../lib/golfmoji'

describe Golfmoji::Executor do
  subject do described_class.new(Golfmoji::Parser.parse(mojis), argv) end
  let(:mojis) { '' }
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

    context 'and there is a hello world moji' do
      let(:mojis) { '⛳️' }

      it 'returns "Hello World!' do
        expect(subject.execute).to eq 'Hello world!'
      end
    end
  end

  context 'when there is a replace moji' do
    let(:mojis) { '🔰' }

    context 'and arguments of type String String String' do
      let(:argv) { ['This is a cool test.', 'cool', 'neat'] }

      it 'replaces the first string with patterns of the second string with the third string' do
        expect(subject.execute).to eq 'This is a neat test.'
      end
    end

    context 'and arguments of type String Array String' do
      let(:argv) { ['This is a cool test to test nice stuff.', ['cool', 'nice'], 'neat'] }

      it 'replaces the first string with patterns of the second array with the third string' do
        expect(subject.execute).to eq 'This is a neat test to test neat stuff.'
      end
    end

    context 'and arguments of type String Array Array' do
      let(:argv) { ['This is a small text.', ['small', 'text'], ['neat', 'test']] }

      it 'replaces the first string with patterns of the second array with the third array' do
        expect(subject.execute).to eq 'This is a neat test.'
      end
    end
  end

  context 'when there is a splitn moji' do
    let(:mojis) { '⚔️' }

    context 'and a string followed by a number as argv' do
      let(:argv) { ['abcdefgh', 3] }

      it 'returns ["abc", "def", "gh"]' do
        expect(subject.execute).to eq ['abc', 'def', 'ghi']
      end
    end
  end
end
