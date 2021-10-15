WORDS = [
  ["eich", "Creator of Javascript"],
  ["autocode", "First compiled coding language"],
  ["lovelace", "First Programmer"],
  ["babbage", "The Father of Computing"],
  ["matsumoto", "Created Ruby Programming Language"],
]

class Hangman

  def initialize
    @word = WORDS.sample
    @lives = 7
    @word_teaser = ""

    @word.first.size.times do
      @word_teaser += "_ "
    end
  end

  def print_teaser last_guess = nil
    update_teaser(last_guess) unless last_guess.nil?
    puts @word_teaser
  end

  def update_teaser last_guess
    new_teaser = @word_teaser.split

    new_teaser.each_with_index do |letter, index|
      # replace blank values with guessed letter if matches letter in word
      if letter == '_' && @word.first[index] == last_guess
        new_teaser[index] = last_guess
      end
    end

    @word_teaser = new_teaser.join(' ')
  end

  def make_guess
    if @lives > 0
      puts "Enter a letter"
      guess = gets.chomp.downcase
      good_guess = @word.first.include? guess
      if guess == "exit"
        puts "Thank you for playing!!! See you next time😀"
      elsif guess.length > 1
        puts "Accepts only 1 letter at a time!!!"
          make_guess    
      elsif good_guess
        puts "You are correct!"
        print_teaser guess
        if @word.first == @word_teaser.split.join
          puts "Congratulations🎉🥂... you WON!!!"
          puts "Would you like to play again?[Y]"
          Hangman.new.start if gets.chomp.downcase == 'y'
        else
          make_guess
        end
      else
        @lives -= 1
        puts "Sorry... you have only #{ @lives } lives left. Try again!"
        make_guess
      end
    else
      puts "Game over😭... better luck next time!"
    end
  end

  def start
    # ask user for a letter
    puts "New game started... your word has #{ @word.first.size } characters!!!"
    puts "To exit game at any point type 'exit'"
    print_teaser
    puts "Hint: #{ @word.last }"
    make_guess
  end

end

game = Hangman.new
game.start