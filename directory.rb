def valid_entry(msg)
  puts msg
  answer = STDIN.gets.chomp.downcase
  answer =  (answer != '') ? answer : 'not supplied' 
  answer
end

def input_students
    while true do
        name = valid_entry('Please enter the names of the students, To finish, just hit return')
        if name == 'not supplied'
            return @students
            break
        end
        cohort = valid_entry("Please enter cohort")
        starSign = valid_entry('star sign')
        food = valid_entry('food preference')
        fears =  valid_entry('fears')
      # add the student hash to the array
      @students << {name: name, cohort:cohort.to_sym, starSign: starSign, food: food, fears: fears}
      puts "Now we have #{@students.count} students"
    end
end

def specific_letter
    letter = valid_entry("search by which letter?")
    return letter
end

def print_header
    puts "The students of Villains Academy".center(60, '-')
end


def print_students(letter = false)
    counter = 0
    while counter < @students.length do
    hash =  @students[counter]
        if letter
            if hash[:name][0] === letter && hash[:name].count < 12
                puts "#{counter + 1}. #{hash[:name]} (#{hash[:cohort]} cohort) star sign is #{hash[:starSign]} they like #{hash[:food]} and are scared of #{hash[:fears]}"
            end
        elsif hash[:name].length < 12
            puts "#{counter + 1}. #{hash[:name]} (#{hash[:cohort]} cohort) star sign is #{hash[:starSign]} they like #{hash[:food]} and are scared of #{hash[:fears]}"
        else
        end   
        counter += 1 
    end
end 

def print_footer
    plural = if @students.length == 1 then 'student' else 'students' end
    puts "Overall, we have #{@students.count} #{plural} enrolled. ".center(80, '-')
end

def print_students_list(search = false)
  print_header
  print_students
  print_footer
end


def menu_items
     # 1. print the menu and ask the user what to do
     puts "1. Input the students"
     puts "2. Show the students"
     puts "3. Save students"
     puts "4. load existing students"
     puts "5. search for student"
     puts "9. Exit" # 9 because we'll be adding more items
     selection = STDIN.gets.chomp
     selection
end



#------------ saving and reading from a file -------#

def load_students(filename ="students.csv" )
    file = File.open(filename, "r")
    file.readlines.each do |line|
    name, cohort, starSign, food, fears = line.chomp.split(',')
      # this is not working when added things are added on
      @students << {name: name, cohort: cohort.to_sym, starSign: starSign, food: food, fears: fears}
    end
    file.close
  end

def save_students
    # open the file for writing
    file = File.open("students.csv", "w")
    # iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:starSign], student[:food], student[:fears]]
      csv_line = student_data.join(",")
      file.puts csv_line
      puts'added to file'
    end
    file.close
  end

   # we are making this in order to run from the terminal, it will work with the load students 
  def try_load_students
    filename = ARGV.first # first argument from the command line
    if filename.nil? 
      filename = 'students.csv'
    end
    if File.exists?(filename) # if it exists
      load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
    else # if it doesn't exist
      puts "Sorry, #{filename} doesn't exist."
      exit 
    end
  end

#-------- global students variable --------#
@students = []
#------ interactive menu ------- #
def interactive_menu
    loop do
      case menu_items
      when "1"
        puts "Inputting Students".center(80, '-')
        input_students
      when "2"
        print_students_list
      when "3"
        save_students
      when '4'
        load_students
      when "5"
        print_students_list(specific_letter)
      when "9"
        puts "Goodbye!".center(80, '-')
        exit # this will cause the program to terminate
      else
        puts "I don't know what you meant, try again"
      end
    end
  end
 #---------- start of program -----------#
try_load_students    
interactive_menu