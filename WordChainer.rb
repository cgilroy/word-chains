require('set')
require('byebug')
class WordChainer
    def initialize(dictionary_file_name)
        @dictionary = Set.new
        File.open(dictionary_file_name, "r") do |f|
            f.each_line do |line|
                @dictionary << line.chomp
            end
        end
    end

    def printDict
        p @dictionary
    end

    def adjacent_words(word)
        # debugger
        words = []
        alphabet = ('a'..'z').to_a
        word_arr = word.chars
        word_arr.each_with_index do |letter,idx|
            alphabet.each do |test_letter|
                test_word = word_arr.dup
                test_word[idx] = test_letter
                test_word = test_word.join('')
                words << test_word if @dictionary.include?(test_word) && test_word != word
            end
        end
        words
    end

end

x = WordChainer.new('dictionary.txt')
x.adjacent_words('card')