def input_students

    # create an empty array
    students = []

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
            return students
            break
        end
        cohort = valid_entry("Please enter cohort")
        star_sign = valid_entry('star sign')
        food = valid_entry('food preference')
        fears =  valid_entry('fears')
      # add the student hash to the array
      students << {name: name, cohort:cohort.to_sym, star_sign: star_sign, food: food, fears: fears}
      puts "Now we have #{students.count} students"

    end
    # return the array of students
    students
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


def print(hash_array, letter = false)
    counter = 0
    while counter < hash_array.length do
    #multi_arr.each_with_index do |hash, index|
    hash = hash_array[counter]
    # puts hash[:name]
        if letter
            if hash[:name][0] === letter && hash[:name].length < 12
                puts "#{counter + 1}. #{hash[:name]} (#{hash[:cohort]} cohort) star sign is #{hash[:star_sign]} they like #{hash[:food]} and are scared of #{hash[:fears]}"
            end
        elsif hash[:name].length < 12
            puts "#{counter + 1}. #{hash[:name]} (#{hash[:cohort]} cohort) star sign is #{hash[:star_sign]} they like #{hash[:food]} and are scared of #{hash[:fears]}"
        else
        end   
        counter += 1 
    end
end 

def print_footer(array)
    plural = if array.length == 1 then 'student' else 'students' end
    puts "Overall, we have #{array.count} #{plural} enrolled. ".center(80, '-')
end

def menu_items
     # 1. print the menu and ask the user what to do
     puts "1. Input the students"
     puts "2. Show the students"
     puts "3. search for student"
     puts "9. Exit" # 9 because we'll be adding more items
     selection = gets.chomp
     selection
end


def print_student(students, search = false)
    print_header
    print(students)
    print_footer(students)
end

#------ interactive menu ------- #
def interactive_menu
    students = []
    loop do
      case menu_items
      when "1"
        students = input_students
      when "2"
        print_student(students)
    when "3"
        print_student(students, specific_letter)
      when "9"
        exit # this will cause the program to terminate
      else
        puts "I don't know what you meant, try again"
      end
    end
  end
      

interactive_menu