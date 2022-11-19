# frozen_string_literal: true

require_relative "pokedoc/version"
require 'httparty'

module Pokedoc
  BASE_URL = "https://pokeapi.co/api/v2/"

  class Pokemon
    RESOURCE = "pokemon"

    def get(pokemon)
      pokemon = pokemon.downcase
      response = HTTParty.get("#{BASE_URL}#{RESOURCE}/#{pokemon}")
      response_handler(response)
    end

    private

    def response_handler(response)
      case response.code
      when 200
        response_body = JSON.parse(response.body)
        response_formatter(response_body)
      when 404
        { message: "Pokemon not found"}
      else
        { message: "Unexpected API response (Code #{response.code})"}
      end
    end

    def response_formatter(response)
      {
        name: response.dig('name'),
        pokedex_number: response.dig('id'),
        types: types_formatter(response.dig('types')),
        height: response.dig('height'),
        weight: response.dig('weight'),
      }
    end

    def types_formatter(types)
      response = []
      types.each do |type|
        response << type.dig('type', 'name')
      end
      response
    end
  end

  class Error < StandardError; end
end
