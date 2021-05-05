# frozen_string_literal: true

require_relative 'iv_calculator'

class Pokemon
  attr_accessor :base_stats, :name, :level, :nature, :hp, :atk, :def, :spa, :spd, :spe, :ivs

  class PokemonDoesNotExistError < StandardError; end

  def initialize(name)
    @name = name.capitalize
  end

  def check_ivs
    calculator = IVCalculator.new(name, nature, level, hp, atk, self.def, spa, spd, spe, base_stats)
    @ivs = calculator.calculate_ivs
  end

  def gather_pokedex_data
    uri = URI("https://pokeapi.co/api/v2/pokemon/#{name.downcase}")
    response = JSON.parse(Net::HTTP.get(uri), symbolize_names: true)
    
    @base_stats = {
      hp:  response[:stats][0][:base_stat],
      atk: response[:stats][1][:base_stat],
      def: response[:stats][2][:base_stat],
      spa: response[:stats][3][:base_stat],
      spd: response[:stats][4][:base_stat],
      spe: response[:stats][5][:base_stat]
    }
  rescue JSON::ParserError
    raise PokemonDoesNotExistError, "#{name} does not exist, are you sure you entered it correctly?"
  end

  def print_ivs
    "#{name.capitalize}[#{level}] - (#{nature.capitalize}) : #{ivs[0]} / #{ivs[1]} / #{ivs[2]} / #{ivs[3]} / #{ivs[4]} / #{ivs[5]}"
  end
end