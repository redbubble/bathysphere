require 'spec_helper'

module Bathysphere
  describe Parser do

    let(:file) { 'spec/fixtures/fruit.yml' }
    let(:parser) { Parser.new(file) }

    it { expect(parser).to respond_to :fetch }

    describe '#fetch' do

      context 'when built from a valid YAML file' do

        context 'when the property is available' do

          it 'returns its value' do
            expect(parser.fetch(:display_name, :large, :purple)).to eq 'Eggplant'
          end
        end

        context 'when the property is not available' do

          it 'raises KeyError and mentions the parsed file in the message' do
            expect{ parser.fetch(:weight, :large, :purple) }.to raise_error KeyError, Regexp.new(file)
          end
        end

        context 'when a property of the path is not available' do

          it 'raises KeyError and mentions the parsed file in the message' do
            expect{ parser.fetch(:weight, :tiny, :purple) }.to raise_error KeyError, Regexp.new(file)
          end
        end
      end

      context 'when the property has no deeply nested values' do

        let(:file) { 'spec/fixtures/simple.yml' }

        context 'when the property is available' do

          it 'behaves as usual' do
            expect(parser.fetch(:display_name)).to eq 'Mountain'
          end
        end
      end
    end
  end
end
