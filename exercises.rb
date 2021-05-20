@students = []

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "9. Exit"
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def show_students
  print_header
  print_students_list(@students)
  print_footer(@students)
end

def input_students
  students = []
  
  while true do
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    
    name = gets.strip
    
    if name == ''
      break
    end
    
    puts "Please enter the country of birth for this student"
    country = gets.strip
    
    puts "Please enter this students hobbies"
    hobbies = gets.strip
    
    puts "Please enter which cohort this student is in"
    cohort = gets.strip
    
    if cohort == ''
      cohort = :may
    else
      cohort = cohort.to_sym
    end
    
    puts "Is this correct"
    input = gets.chomp
      
    if input.downcase == "no"
      next
    end
      
    @students << {name: name, cohort: cohort, country: country, hobbies: hobbies}
      
    if students.count == 1
      puts "Now we have 1 student"
    else
    puts "Now we have #{@students.count} students"
    end
    
  end
  return students
end

def print_header
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100)
end

def print_students_list(students)
  # index = 0
  
  # while index < students.length do 
  #   # if students[index][:name][0].downcase == 'a' && students[index][:name].length < 12
  #     puts "#{index + 1}: #{students[index][:name]} (#{students[index][:cohort]} cohort), country: #{students[index][:country]}, hobbies: #{students[index][:hobbies]}"
  #     puts students[index][:name]
  #   # end
    
  #   index += 1
  # end
  
  list_by_cohort = {}
  
  @students.each do |student|
    cohort = student[:cohort]
    name = student[:name]
    
    if list_by_cohort[cohort] == nil
      list_by_cohort[cohort] = [name]
    else
      list_by_cohort[cohort].push(name)
    end
  end
  
  list_by_cohort.each do |cohort, name|
    puts "#{cohort} cohort".center(100)
    puts name
    puts "\n"
  end
end

def print_footer(students)
  if students.count == 1 
    puts "Overall, we have 1 great student".center(100)
  else
    print "Overall, we have #{@students.count} great students".center(100)
  end
end

def save_students
  file = File.open("students.csv", "w")
  
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

interactive_menu