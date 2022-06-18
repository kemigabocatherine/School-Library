#!/usr/bin/env ruby

require './storage'
require './book'
require './person'
require './teacher'
require './student'
require './rental'

class App
  attr_reader :storage

  def initialize
    @storage = Store.new
  end

  def base_menu
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
    base_selection
  end

  def base_selection # rubocop:disable Metrics/CyclomaticComplexity
    menu_option = gets.chomp
    case menu_option
    when '1'
      list_all_books
    when '2'
      list_all_people
    when '3'
      create_a_person
    when '4'
      create_a_book
    when '5'
      create_a_rental
    when '6'
      list_all_rentals_by_id
    when '7'
      abort('Thank you for your engagement with us:)')
    else
      puts 'Invalid request'
      base_selection
    end
  end

  def list_all_books
    @storage.books.each do |book|
      puts %(Title: \"#{book.title}\", Author: #{book.author})
    end
    base_menu
  end

  def list_all_people
    @storage.people.each do |person|
      puts "[#{person.class}]Name: #{person.name}, ID: #{person.id} Age: #{person.age}"
    end
    base_menu
  end

  def create_a_person
    puts 'Do you want to create a student (1) or a teacher (2) [Input the number]: '
    menu_option = gets.chomp

    case menu_option
    when '1'
      create_a_student
    when '2'
      create_a_teacher
    else
      puts 'Invalid request'
      create_a_person
    end
    base_menu
  end

  def create_a_student
    puts 'Age: '
    age = gets.chomp
    puts 'Name: '
    name = gets.chomp
    puts 'Has parent permission? (Y/N): '
    parent_permission = gets.chomp.downcase == 'y'
    student = Student.new(age: age, classroom: 'n/a', name: name, parent_permission: parent_permission)
    @storage.people << student
    puts 'Person created successfully'
  end

  def create_a_teacher
    puts 'Age: '
    age = gets.chomp
    puts 'Name: '
    name = gets.chomp
    puts 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age: age, specialization: specialization, name: name)
    @storage.people << teacher
    puts 'Person created successfully'
  end

  def create_a_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @storage.books << book
    puts 'Book created successfully'
    base_menu
  end

  def create_a_rental
    puts 'Select a book from the following list by number'
    storage.books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
    book_selection = gets.chomp.to_i
    puts ''
    puts 'Select a person from the following list by number (not id)'
    storage.people.each_with_index do |person, index|
      puts "#{index}) Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_selection = gets.chomp.to_i
    puts ''
    print('Enter the date of the rental (YYYY-MM-DD): ')
    rental_date = gets.chomp
    Rental.new(rental_date, storage.books[book_selection], storage.people[person_selection])
    puts 'Rental created successfully'
    base_menu
  end

  def list_all_rentals_by_id
    puts 'Select a person from the following list by number (not id)'
    storage.people.each_with_index do |person, index|
      puts "#{index}) Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    print 'Enter the id of the person: '
    person_selection = gets.chomp.to_i
    puts 'Rentals:'
    person = storage.people[person_selection]
    person.rentals.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
    end
    base_menu
  end

  def run
    base_menu
  end
end

def main
  app = App.new
  app.run
end

main
