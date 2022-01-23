require_relative '../../string'
require_relative '../../json_loader'

module Wordle
  class Game
    attr_accessor :input_word, :end_game, :turn_count

    def initialize
      @end_game = false
      @turn_count = 0
      @word = fetch_wordle
    end

    def start_game
      onboard
      while @turn_count < 6
        fetch_input
        @turn_count += 1
        check_input
      end
    end

    private

    def onboard
      show_example
      puts "Guess a 5 letter word:"
      puts "------"
    end

    def show_example
      puts "w".green + "eary - The letter w is in the word and in the correct spot."
      puts "p" + "i".yellow + "lls - The letter i is in the word but in the wrong spot."
      puts "vag" + "u".gray + "e - The letter u is not in the word."
    end

    def fetch_wordle
      word = JsonLoader.new.parse_json.sample
      log_word(word)

      word
    end

    def log_word(word)
      File.write("log.txt", "Word of the day: #{word} \n", mode: "a")
    end

    def fetch_input
      @input_word = STDIN.gets.chomp.upcase
    end

    def check_input
      if input_word == @word
        @turn_count = 6

        puts input_word.green
        puts "Winner!"
      end

      if input_word != @word
        check_matching_letters
      end
    end

    def check_matching_letters
      guess_word = []
      input_word.chars.each_with_index do |letter, i|
        if letter == @word[i]
          guess_word << letter.green
        elsif @word.include?(letter)
          guess_word << letter.yellow
        else
          guess_word << letter.gray
        end
      end

      puts guess_word.join("")
    end
  end
end
