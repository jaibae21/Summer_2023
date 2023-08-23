#  sagerkasey_61617_7538154_Julia-KaseySager.jl
#=
 GRADING HEADER by Delugach below. Any other comments with HSD in them were inserted by me.
 NOTE: any line numbers in my comments or the output refer to THIS modified file, NOT your original file.

 GRADE TOTAL: 90

 CORRECTNESS (max 30) : 30

 COMPLETENESS (max 30) : 30

 DESIGN (max 20) : 20

 DOCUMENTATION (max 20) : 10
# 	-10 didn't give any feedback on the use of Julia
=#


#=  Test data file is as follows. Your OUTPUT appears at the very end.
A12345 Joseph P. Allen, Jr.
A23456 Brenda Gomez
A19283 Rihanna
A00006 Prince Henry Charles Albert David, Duke of Sussex
A34567 William Arthur Philip Louis, Prince of Wales
A98765 Bozo The Clown
A00000 An unregistered student

987 CS 424-02 Programming Languages
123 CS 490 Operating Systems
789 CS 00 A course no one wants to take
456 CS 317 Introduction to Computer Algorithms
045 CS 445 Introduction to Computer Graphics

A12345 987
A34567 123
A00006 045
A98765 456
A98765 987
A19283 987
A23456 456
A12345 123
A23456 045
A19283 456
A23456 987

=#

#
# ====== End of grading header inserted by HSD ===========================
# Julia Program
# CS 424
# Instructor: Dr. Harry S. Delugach
# Kasey Sager
# 4/17/23
# Notes:
# input file must be named "register.txt" and must be in same folder as current program
# Do not ask user for input
# Program must create at least 2 types -
# 1 for student info and 1 for course info. 
# Must read the input file exactly once
# OUTPUT:
# List of each student with full course name for which they are enrolled
# List of each course (name and #) with full list of student names in that course
# Cannot assume any # of students or any info

struct Student
	# Define a custom type 'Student' with two fields: 'id' 
	# of type String and 'name' of type String
    id::String  
    name::String
end

struct Course
	# Define a custom type 'Course' with two fields: 'crn' 
	# of type String and 'name' of type String
    crn::String
    name::String
end


# Initialize a variable 'section' with value 1, used to 
# keep track of the current section of input being processed
section = 1 

# Create an empty dictionary to store Student objects, 
# with student ID as the key
students = Dict{String, Student}()

# Create an empty dictionary to store Course objects, 
# with course CRN as the key
courses = Dict{String, Course}()

enrollments = String[] # Create an empty array to store enrollment information as strings
pId = Set{String}() # Create an empty set to keep track of previously read student IDs
pCrn = Set{String}()  # Create an empty set to keep track of previously read course CRNs

file = open("register.txt") # Open a file named "register.txt" for reading
while ! eof(file)  # Continue reading lines from the file until end-of-file is reached
    line = readline(file) # Read a line from the file
    array = split(line) # Split the line into an array of strings, using space as the delimiter

    if isempty(line) && section == 1 #If the line is empty and 'section' is 1
        global section = 2 #Set 'section' to 2 (update the global variable 'section')
    elseif isempty(line) && section == 2 #If the line is empty and 'section' is 2
        global section = 3 #Set 'section' to 3 (update the global variable 'section')
    end

    if !isempty(line) #If the line is not empty
        #If 'section' is 1
		if section == 1 
            id = popfirst!(array) #Remove and return the first element of 'array', assign it to 'id'
            name = join(array," ") #Join the remaining elements of 'array' with space as separator, assign it to 'name'
            student = Student(id, name) #Create a 'Student' object with 'id' and 'name' as arguments
            students[id] = student #Add the 'Student' object to the 'students' dictionary with 'id' as key
            push!(pId, id) #Add 'id' to the 'pId' set to keep track of previously read student IDs
        #If 'section' is 2
		elseif section == 2 
            crn = popfirst!(array) #Remove and return the first element of 'array', assign it to 'crn'
            name = join(array, " ") #Join the remaining elements of 'array' with space as separator, assign it to 'name'
            course = Course(crn, name) #Create a 'Course' object with 'crn' and 'name' as arguments
            courses[crn] = course #Add the 'Course' object to the 'courses' dictionary with 'crn' as key
            push!(pCrn, crn) #Add 'crn' to the 'pCrn' set to keep track of previously read course CRNs
        # If 'section' is 3
		elseif section == 3
            push!(enrollments, line)
       
        end
    end
end

println("Total number of students: ", length(students)) # Print total number of students
println("Total number of courses: ", length(courses)) # Print total number of courses
println("Total number of enrollments: ", length(enrollments)) # Print total number of enrollments
println("") #empty line for spacing between sections

println("Enrolled Students:") #Print a message indicating the list of students with the courses they are enrolled in
close(file) #close input file 

#Loop through each student in the "students" dictionary
for student in values(students) 
    enrolled_courses = [] #Initialize an empty array to store enrolled courses for the current student
    for enroll in enrollments #Loop through each enrollment record
        tempArr = split(enroll) #Split the enrollment record into an array using whitespace as the delimiter
        if student.id == tempArr[1] #Check if the student ID matches the ID in the enrollment record
            course = get(courses, tempArr[2], Course("", "")) # Retrieve the corresponding course from the 
															#"courses" dictionary using the CRN in the enrollment record as the key
            push!(enrolled_courses, course.name) #Push the name of the enrolled course into the "enrolled_courses" array
        end
    end
    println("\tStudent: " * student.name * "  --Courses Enrolled: " * join(enrolled_courses, ", ")) #Print the student's name and the names of the enrolled courses
end

println("Course List:") #Print a message indicating the list of courses with enrolled students

# Loop through each course in the "courses" dictionary
for course in values(courses)
    enrolled_students = [] #Initialize an empty array to store enrolled students for the current course
    for enroll in enrollments #Loop through each enrollment record
        tempArr = split(enroll) #Split the enrollment record into an array using whitespace as the delimiter
        if course.crn == tempArr[2] #Check if the CRN of the current course matches the CRN in the enrollment record
            student = get(students, tempArr[1], Student("", "")) # Retrieve the corresponding student from the "students" dictionary using the student ID in the enrollment record as the key
            push!(enrolled_students, student.name) # Push the name of the enrolled student into the "enrolled_students" array
        end
    end
    println("\tCourse: " * course.name * "  --Students enrolled: " * join(enrolled_students, ", ")) #Print the course's name and the names of the enrolled students
end

# Summary of what you learned from the assignment and impressions 
# of Julia as a programming language.
# I had a harder time getting my code to work the way I wanted it to.
# For the ruby code I had a hard time finding references and this time
# I had the same problem, but also just had a hard time with my output.
# Learning and using these new languages is good for experience.
#= OUTPUT follows:
Total number of students: 7
Total number of courses: 5
Total number of enrollments: 11

Enrolled Students:
	Student: Brenda Gomez  --Courses Enrolled: CS 317 Introduction to Computer Algorithms, CS 445 Introduction to Computer Graphics, CS 424-02 Programming Languages
	Student: An unregistered student  --Courses Enrolled: 
	Student: Joseph P. Allen, Jr.  --Courses Enrolled: CS 424-02 Programming Languages, CS 490 Operating Systems
	Student: Prince Henry Charles Albert David, Duke of Sussex  --Courses Enrolled: CS 445 Introduction to Computer Graphics
	Student: Rihanna  --Courses Enrolled: CS 424-02 Programming Languages, CS 317 Introduction to Computer Algorithms
	Student: William Arthur Philip Louis, Prince of Wales  --Courses Enrolled: CS 490 Operating Systems
	Student: Bozo The Clown  --Courses Enrolled: CS 317 Introduction to Computer Algorithms, CS 424-02 Programming Languages
Course List:
	Course: CS 445 Introduction to Computer Graphics  --Students enrolled: Prince Henry Charles Albert David, Duke of Sussex, Brenda Gomez
	Course: CS 490 Operating Systems  --Students enrolled: William Arthur Philip Louis, Prince of Wales, Joseph P. Allen, Jr.
	Course: CS 424-02 Programming Languages  --Students enrolled: Joseph P. Allen, Jr., Bozo The Clown, Rihanna, Brenda Gomez
	Course: CS 317 Introduction to Computer Algorithms  --Students enrolled: Bozo The Clown, Brenda Gomez, Rihanna
	Course: CS 00 A course no one wants to take  --Students enrolled: 
=#
