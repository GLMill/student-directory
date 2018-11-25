def input_students

    def valid_entry(msg)
        puts msg
        answer = STDIN.gets.chomp
        answer =  (answer != '') ? answer : 'not supplied' 
        answer
    end
    while true do
        puts "Please enter the names of the students"
        puts "To finish, just hit return twice"
        name = gets.chomp
        if name.empty?
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
    # return the array of students

end

def specific_letter
    puts "search by specific letter? yes no"
    letter = gets.chomp.downcase
    if(letter === 'yes')
        puts "search by which letter?"
        letter = STDIN.gets.chomp.downcase
        return letter
    end
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



      


def print_students_list(search = false)
    print_header
    print_students
    print_footer
end

#------------ saving and reading from a file -------#

def get_file_name
  puts 'which file would you like to use, leave blank to use default'
  file = gets.chomp.downcase
  if file === '' 
    return false 
  else 
    return file
  end 
end

def load_students(filename ="students.csv" )
    file = File.open(filename, "r")
    file.readlines.each do |line|
    name, cohort, starSign, food, fears = line.chomp.split(',')
      @students << {name: name, cohort: cohort.to_sym, starSign: starSign, food: food, fears: fears}
    end
    file.close
  end


def save_students
    # open the file for writing
    file = File.open("students.csv", "w") do |f|
      # iterate over the array of students
      @students.each do |student|
        student_data << [student[:name], student[:cohort], student[:starSign], student[:food], student[:fears]]
        csv_line = student_data.join(",")
        file.puts csv_line
        puts'added to file'
      end
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
        input_students
      when "2"
        print_students_list
      when "3"
        file = get_file_name
        (file) ? save_students(file) : save_students
      when '4'
        file = get_file_name
        (file) ? load_students(file): load_students
    when "5"
        print_students_list(specific_letter)
      when "9"
        exit # this will cause the program to terminate
      else
        puts "I don't know what you meant, try again"
      end
    end
  end
      
try_load_students
interactive_menu

