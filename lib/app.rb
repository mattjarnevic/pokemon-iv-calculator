# frozen_string_literal: true

require_relative 'helpers/natures'
require_relative 'helpers/prompt'
require_relative 'iv_calculator'
require_relative 'pokemon'
require 'pry'

VALID_LEVELS  = (1..100).map(&:to_s)
VALID_NATURES = NATURES.keys.map(&:to_s)

def run
  Prompt.clear
  Prompt.logo
  name = Prompt.ask('What is the name of the Pokemon you would like to check?')
  pokemon = Pokemon.new(name)
  Prompt.say("Gathering Pokemon Data for #{pokemon.name}")

  begin
    pokemon.gather_pokedex_data
  rescue => e
    run
  else
    Prompt.say("Found Pokemon Data for #{pokemon.name}!")
  end

  pokemon.level   = Prompt.ask("What is #{pokemon.name}'s Level? (1-100)", valid_responses: VALID_LEVELS).to_i
  pokemon.nature  = Prompt.ask("What is #{pokemon.name}'s Nature?", valid_responses: VALID_NATURES)
  pokemon.hp      = Prompt.ask("What is #{pokemon.name}'s HP Stat?").to_i
  pokemon.atk     = Prompt.ask("What is #{pokemon.name}'s Attack Stat?").to_i
  pokemon.def     = Prompt.ask("What is #{pokemon.name}'s Defense Stat?").to_i
  pokemon.spa     = Prompt.ask("What is #{pokemon.name}'s Special Attack Stat?").to_i
  pokemon.spd     = Prompt.ask("What is #{pokemon.name}'s Special Defense Stat?").to_i
  pokemon.spe     = Prompt.ask("What is #{pokemon.name}'s Speed Stat?").to_i

  pokemon.check_ivs

  Prompt.result(pokemon.print_ivs)

  input = Prompt.ask("Would you like to look at another pokemon? (Y/n)")
  input.downcase == 'y' || input.downcase == 'yes' ? run : exit
end

begin
  input = Prompt.ask("Would you like to listen to some pokemon music? (Y/n)")
  music = Thread.new { `afplay sounds/music.mp3 -v 0.05` } if input.downcase == 'y' || input.downcase == 'yes'
  run
rescue => e
  Prompt.say(e.message)
ensure
  `killall −9 afplay` if music
end