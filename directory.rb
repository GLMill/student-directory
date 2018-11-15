
students = [
['Mojo Jojo', :november],
['White Diamond', :november],
['Voldemort', :november],
['The plague', :november],
['Smith', :november],
['James Bond', :november]
]
def print_header
    puts "The students of Villains Academy"
    puts "-------------"
end

def print(multi_arr)
    multi_arr.each do |arr|
     puts "#{arr[0]} (#{arr[1]} cohort)"
    end
end 
def print_footer(array)
    puts "Overall, we have #{array.count} students enrolled. "
end

print_header
print(students)
print_footer(students)