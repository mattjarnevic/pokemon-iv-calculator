# frozen_string_literal: true

require_relative 'ascii_art'

# Class for managing Command Line printing and user input
class Prompt
  # Public        - Asks the user a question in pink and waits for a response
  #
  # @param string - String (question) to print
  #
  # @return       - Response from the user
  def self.ask(string, valid_responses: nil)
    puts colorize(:pink, string)
    response = gets.chomp
    if valid_responses
      while !valid_responses.include?(response)
        response = ask("#{response} is not valid. #{string}")
      end
    end
    response
  end

  # Public        - Clears the command line
  def self.clear
    system "clear"
  end

  # Public        - Prints out the Command Line logo in light blue
  def self.logo
    puts colorize(:light_blue, header)
  end

  # Public        - Accepts a string and prints the string in blue
  #
  # @param string - String to print
  #
  # @return       - Prints out a String in the color blue surrounded by empty lines
  def self.result(string)
    puts "", colorize(:blue, string), ""
  end

  # Public        - Accepts a string and prints the string in red
  #
  # @param string - String to print
  #
  # @return       - Prints out a String in the color red with an extra line after
  def self.say(string)
    puts colorize(:red, string), ""
  end

  private

  # Public        - Converts a string into the specified color
  #
  # @param string - String to print
  # @param color  - Color to change the string to
  #
  # @return       - String in the color specified
  def self.colorize(color, string)
    colors = {
      red: 31,
      green: 32,
      yellow: 33,
      blue: 34,
      pink: 35,
      light_blue: 36
    }

    "\e[#{colors[color]}m#{string}\e[0m"
  end
end