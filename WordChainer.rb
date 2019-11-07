require('set')
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

end

x = WordChainer.new('dictionary.txt')
x.printDict