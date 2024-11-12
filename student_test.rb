require 'minitest/autorun'
require 'date'
require_relative 'student'

class StudentTest < Minitest::Test
  def setup
    Student.class_variable_set(:@@students, [])
    @student1 = Student.new("Мельник", "Іван", "2000-05-15")
    @student2 = Student.new("Абраменко", "Петро", "1998-10-22")
    @student3 = Student.new("Ткаченко", "Марія", "2001-01-12")
  end

  def test_initialization
    assert_equal "Мельник", @student1.surname
    assert_equal "Іван", @student1.name
    assert_equal Date.new(2000, 5, 15), @student1.date_of_birth
  end

  def test_calculate_age
    assert_equal 24, @student1.calculate_age
    assert_equal 26, @student2.calculate_age
    assert_equal 23, @student3.calculate_age
  end

  def test_get_students_by_age
    assert_equal [@student1], Student.get_students_by_age(24)
    assert_equal [@student2], Student.get_students_by_age(26)
  end

  def test_get_students_by_name
    assert_equal [@student1], Student.get_students_by_name("Іван")
    assert_equal [@student3], Student.get_students_by_name("Марія")
  end

  def test_add_student
    student = Student.new("Новий", "Студент", "2002-02-02")
    assert_includes Student.all_students, student
  end

  def test_remove_student
    @student1.remove_student
    refute_includes Student.all_students, @student1
  end

  def test_invalid_date_of_birth
    assert_raises(ArgumentError) { Student.new("Новий", "Студент", "3000-01-01") }
  end
end

def create_html_report
  report = "<html><head><title>Test Report</title></head><body>"
  report += "<h1>Student Class Test Report</h1>"

  Minitest::Runnable.runnables.each do |runnable|
    runnable.run_one_method(nil, nil)

    report += "<h2>#{runnable}</h2>"
    runnable.runnable_methods.each do |method|
      begin
        runnable.new(method).run
        report += "<p style='color:green;'>#{method} - Passed</p>"
      rescue => e
        report += "<p style='color:red;'>#{method} - Failed</p><pre>#{e}</pre>"
      end
    end
  end

  report += "</body></html>"
  File.write("test_report.html", report)
end

create_html_reportruby
