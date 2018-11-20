def input_students

    # create an empty array
    students = []

    while true do
        puts "Please enter the names of the students"
        puts "To finish, just hit return twice"
        name = gets.chomp
        if name.empty?
            return students
            break
        end
        puts "Please enter cohort"
        cohort = gets.chomp
        puts "star sign"
        star_sign = gets.chomp
        puts "food preference"
        food = gets.chomp
        puts "fears"
        fears = gets.chomp
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


def print(hash_array, letter)
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

students = input_students
letter = specific_letter
print_header
print(students, letter)
print_footer(students)