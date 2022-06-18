require './storage'

class App
  attr_reader :storage

  def initialize
    @storage = Store.new
  end

  def base_menu
    puts 'Welcome to School Library App!!'
    puts ''

    puts 'Please choose an option by entering a number:'
    puts '1-List all books.'
    puts '2-List all people.'
    puts '3-Create a person.' 
    puts '4-Create a book.'
    puts '5-Create a rental.'
    puts '6-List all rentals for a given person id.'
    puts '7-Exit'
    base_selection
  end

  def base_selection
    menu_option = gets.chomp
    case menu_option
    when '1' then list_all_books.
    when '2' then list_all_people.
    when '3' then create_a_person. 
    when '4' then create_a_book.
    when '5' then create_a_rental.
    when '6' then list_all_rentals_by_id.
    when '7' then abort('Thank you for your engagement with us:)')
    else
      puts 'Invalid request'
      base_selection
    end
  end

  def list_all_books
    @storage.books.each do |book|
      puts 'Title: \"#{book.title}\", Author: #{book.author}'
    end
    base_menu
  end
end