# frozen_string_literal: true

require 'pry'
require 'net/http'
require 'json'

require_relative 'helpers/natures'

class IVCalculator

  class PokemonDoesNotExistError < StandardError; end

  attr_accessor :base_stats, :pokemon, :nature, :level, :stats, :ivs

  def initialize(pokemon, nature, level, hp, atk, defense, spa, spd, spe, base_stats)
    @pokemon = pokemon.downcase
    @nature = NATURES[nature.downcase.to_sym]
    @base_stats = base_stats || fetch_base_stats(pokemon)
    @level = level
    @stats = { hp: hp, atk: atk, def: defense, spa: spa, spd: spd, spe: spe }
  end

  def self.check(pokemon)
    @stats = { hp: pokemon.hp, atk: pokemon.atk, def: pokemon.def, spa: pokemon.spa, spd: pokemon.spd, spe: pokemon.spe }
    @base_stats = pokemon.base_stats
    @nature = pokemon.nature
    @level = pokemon.level
    calculate_ivs
  end

  def calculate_ivs
    @ivs = stats.keys.map { |key| iv_range(key) }
  end

  def iv_range(stat)
    range = 32.times.filter { |iv| stats[stat] == calculate_stat(stat, iv) }
        
    return range.size > 1 ? "#{range.first}-#{range.last}" : "#{range.first || 'Undetermined'}"
  end

  def print_ivs
    "#{pokemon.capitalize}[#{level}] - (#{nature.to_s.capitalize}) : #{ivs[0]} / #{ivs[1]} / #{ivs[2]} / #{ivs[3]} / #{ivs[4]} / #{ivs[5]}"
  end

  private

  def fetch_base_stats(pokemon)
    uri = URI("https://pokeapi.co/api/v2/pokemon/#{pokemon}")
    response = JSON.parse(Net::HTTP.get(uri), symbolize_names: true)
    base_stats = {
      hp:  response[:stats][0][:base_stat],
      atk: response[:stats][1][:base_stat],
      def: response[:stats][2][:base_stat],
      spa: response[:stats][3][:base_stat],
      spd: response[:stats][4][:base_stat],
      spe: response[:stats][5][:base_stat]
    }
  rescue JSON::ParserError
    raise PokemonDoesNotExistError, "Could not find pokemon: #{pokemon}"
  end

  # floor rounds down
  def calculate_stat(stat, iv)
    if stat == :hp
      ((2.0 * base_stats[stat] + iv) * level / 100.0).floor + level + 10
    else
      ((((2.0 * base_stats[stat] + iv) * level / 100.0).floor + 5) * nature[stat]).floor
    end
  end
end
