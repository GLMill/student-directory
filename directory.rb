def input_students

    def valid_entry(msg)
        puts msg
        answer = gets.chomp
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
        star_sign = valid_entry('star sign')
        food = valid_entry('food preference')
        fears =  valid_entry('fears')
      # add the student hash to the array
      @students << {name: name, cohort:cohort.to_sym, star_sign: star_sign, food: food, fears: fears}
      puts "Now we have #{@students.count} students"

    end
    # return the array of students

end

def specific_letter
    puts "search by specific letter? yes no"
    letter = gets.chomp.downcase
    if(letter === 'yes')
        puts "search by which letter?"
        letter = gets.chomp.downcase
        return letter
    end
end

def print_header
    puts "The students of Villains Academy".center(60, '-')
end


def print_students(letter = false)
    counter = 0
    puts @students
    while counter < @students.length do
    hash =  @students[counter]
        if letter
            if hash[:name][0] === letter && hash[:name].count < 12
                puts "#{counter + 1}. #{hash[:name]} (#{hash[:cohort]} cohort) star sign is #{hash[:star_sign]} they like #{hash[:food]} and are scared of #{hash[:fears]}"
            end
        elsif hash[:name].length < 12
            puts "#{counter + 1}. #{hash[:name]} (#{hash[:cohort]} cohort) star sign is #{hash[:star_sign]} they like #{hash[:food]} and are scared of #{hash[:fears]}"
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
     selection = gets.chomp
     selection
end



      


def print_students_list(search = false)
    print_header
    print_students
    print_footer
end

#------------ saving and reading from a file -------#

def load_students
    file = File.open("students.csv", "r")
    file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
      # this is not working when added things are added on
      @students << {name: name, cohort: cohort.to_sym}
    end
    file.close
  end

def save_students
    # open the file for writing
    file = File.open("students.csv", "w")
    # iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:star_sign], student[:food], student[:like]]
      csv_line = student_data.join(",")
      file.puts csv_line
      puts'added to file'
    end
    file.close

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
        save_students
      when '4'
        load_students
    when "5"
        print_students_list(specific_letter)
      when "9"
        exit # this will cause the program to terminate
      else
        puts "I don't know what you meant, try again"
      end
    end
  end
      

interactive_menu

