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
        @current_words = nil
        @all_seen_words = nil
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

    def run(source, target)
        # debugger
        @current_words = [source]
        @all_seen_words = Hash.new()
        @all_seen_words[source] = nil

        while !@current_words.empty? && !@all_seen_words.has_key?(target) do
            new_current_words = explore_current_words
            @current_words = new_current_words
        end

        build_path(target)

    end

    def explore_current_words
        # debugger
        new_current_words = []
        @current_words.each do |current_word|
            adjacent_words(current_word).each do |adjacent_word|
                if !@all_seen_words.include?(adjacent_word)
                    new_current_words << adjacent_word
                    @all_seen_words[adjacent_word] = current_word if !@all_seen_words.has_key?(adjacent_word)
                end
            end
        end
        new_current_words
    end

    def build_path(target)
        # debugger
        path = [target]
        until @all_seen_words[target] == nil do
            prev_word = @all_seen_words[target]
            path << prev_word
            target = prev_word
        end
        p path.reverse
    end

end

x = WordChainer.new('dictionary.txt')
x.run('crow','meat')