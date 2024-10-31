require 'date'

class Student
  attr_accessor :surname, :name, :date_of_birth

  @@students = []

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    self.date_of_birth = date_of_birth
    add_student
  end

  def date_of_birth=(dob)
    dob = Date.parse(dob) if dob.is_a?(String)
    raise ArgumentError, "Дата народження має бути в минулому" if dob > Date.today
    @date_of_birth = dob
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if Date.new(today.year, @date_of_birth.month, @date_of_birth.day) > today
    age
  end

  def add_student
    unless @@students.any? { |student| student.surname == @surname && student.name == @name && student.date_of_birth == @date_of_birth }
      @@students << self
    end
  end

  def remove_student
    @@students.delete_if { |student| student == self }
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end

  def self.all_students
    @@students
  end
end

student1 = Student.new("Мельник", "Iван", "2000-05-15")
student2 = Student.new("Абраменко", "Петро", "1998-10-22")
student3 = Student.new("Ткаченко", "Марiя", "2001-01-12")

Student.all_students.each do |student|
  puts "Список усіх студентів:#{student.surname} #{student.name}, Дата народження: #{student.date_of_birth}, Вік: #{student.calculate_age}"
end
