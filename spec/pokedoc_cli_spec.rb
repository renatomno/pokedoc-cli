# frozen_string_literal: true
require 'byebug'
RSpec.describe Pokedoc do

  context 'Pokemon#get' do
    let(:pokemon) { Pokedoc::Pokemon.new}

    it 'returns pokemon info (code 200)' do
      response_body = pokemon.get('Froslass')

      expect(response_body[:name]).to eq("froslass") 
      expect(response_body[:pokedex_number]).to eq(478) 
      expect(response_body[:types][0]).to eq("ice") 
      expect(response_body[:types][1]).to eq("ghost") 
      expect(response_body[:height]).to eq(13) 
      expect(response_body[:weight]).to eq(266) 
    end

    it 'returns Pokemon not found message (code 404)' do
      response_body = pokemon.get('picaku')
      
      expect(response_body[:message]).to eq('Pokemon not found')
    end
  end
end
