#!/usr/bin/env ruby

require_relative 'app'

def base_menu
  flag = true
  while flag
    puts 'Welcome to School Library App!!'
    puts ''

    puts 'Please choose an option by entering a number: '
    puts '1-List all books.'
    puts '2-List all people.'
    puts '3-Create a person.'
    puts '4-Create a book.'
    puts '5-Create a rental.'
    puts '6-List all rentals for a given person id.'
    puts '7-Exit'
    menu_option = gets.chomp
    flag = false if menu_option == '7'
    base_selection(menu_option)
  end
end

def base_selection(option) # rubocop:disable Metrics/CyclomaticComplexity
  app = App.new
  case option
  when '1'
    app.list_all_books
  when '2'
    app.list_all_people
  when '3'
    app.create_a_person
  when '4'
    app.create_a_book
  when '5'
    app.create_a_rental
  when '6'
    app.list_all_rentals_by_id
  when '7'
    abort('Thank you for your engagement with us:)')
  else
    puts 'Invalid request'
  end
end

def main
  base_menu
end

main
