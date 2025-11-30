# these are just some basic ruby examples to show syntax and stuff
# not part of the demo just some extra stuff I was playing with

# basic print statement: 
puts "ayoooo helllooooooo"

#This code creates a new class, Numeric, with a plus method. Because everything is an object in Ruby, you can call this method with anything, even a number! We do this in the example y = 5.plus 6. The Numeric class is just a small example of what Ruby can do, but I'm sure it gives you an idea of its power.

# that was just copy and paste from the source I got it from but like that is actually so cool 
# class Numeric
#     def plus(x)
#         self.+(x) # attached method that does initial.+ with x
#     end
# end

# basic function definition
# def plus(x, y)
#     x + y
# end

#omg they do the same thing 
# z = plus(3, 4) # does 3 + 4
# y = 5.plus(10) #does 5 + 10 
# puts y # prints 15
# puts z # prints 7
########################### ignore above this line #####################################

class Integer
    def to_negative
      # Corrected: simply return the negative value using the unary minus operator
      -self
    end
  
    # Use double quotes for string interpolation in method names
    (1..5).each do |n|
      {:multiply => '*', :add => '+', :division => '/', :subtraction => '-'}.each do |method_name, operator|
        # The outer string must use double quotes for interpolation to work
        define_method "#{method_name}_by_#{n}" do
          self.send(operator, n)
        end
      end
    end
  end
  
  num = 10
#   puts num.multiply_by_3    # prints 30
#   puts num.add_by_2         # prints 12
#   puts num.division_by_5    # prints 2
#   puts num.subtraction_by_4 # prints 6

#create a series of methods to exponentiate a number by numbers 1-10
class Integer
    (1..10).each do |n|
        define_method "exponentiate_by_#{n}" do
            self ** n
        end
        end
    end
    
    # num = 2
    # puts num.exponentiate_by_3  # prints 8
    # puts num.exponentiate_by_4  # prints 16
    # puts num.exponentiate_by_5  # prints 32



# metaprogramming example: Dynamic attributes using method_missing and define_method. basically kind of like a struct that hold infomraiton key and value style 
# we can create any attribute on the fly just by calling it! its a simple getter setter example but with any type of class. your object can basically be whatever you want it to be at runtime

class DynamicObject
    def initialize # constructor
        @data = {}
    end
    # when a method is called that doesn't exist, this method is triggered
    def method_missing(method_name, *args, &block) #catch all for missing methods
        method_str = method_name.to_s # convert method name to string
        if method_str.end_with?("=") # setter method
           key = method_str.chomp("=") # remove '=' to get the key
           self.class.define_method(method_name) do |value| # define the setter method dynamically
            @data[key] = value # set the value in the @data hash
           end
           self.class.define_method(key) do # define the getter method dynamically
            @data[key]
           end
            send(method_name, args.first) # call the newly defined setter method

        elsif @data.key?(method_str) # getter method
            @data[method_str]
        else
            super # call the default method_missing if key not found
        end
    end
    # respond_to_missing? is used to indicate whether the object responds to a given method
    def respond_to_missing?(method_name, include_private = false)
        true
    end
end

p = DynamicObject.new
p.username = "dj"
p.age = 21
p.favorite_language = "Ruby"

puts p.username            # Output: dj
puts p.age                 # Output: 21
puts p.favorite_language   # Output: Ruby

l = DynamicObject.new
l.city = "New York"
l.country = "USA"
puts l.city        # Output: New York
puts l.country     # Output: USA



# def printMenu
#     puts "Menu:"
#     puts "1. Show Party Members"
#     puts "2. Add Party Member"
#     puts "3. Exit"
#     puts "Enter your choice:"
# end

# party = Party.new
# while true
#     printMenu
#     choice = gets.chomp.to_i
#     case choice
#     when 1
#         printAllMethods(party)
#     when 2
#         puts "Enter the name of the new party member:"
#         new_member = gets.chomp
#         party.send(new_member)
#         puts "-----"
#     when 3
#         puts "Exiting..."
#         break
#     else
#         puts "Invalid choice. Please try again."
#     end
# end
