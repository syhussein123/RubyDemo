# basic print statement: 
puts "ayoooo helllooooooo"

#This code creates a new class, Numeric, with a plus method. Because everything is an object in Ruby, you can call this method with anything, even a number! We do this in the example y = 5.plus 6. The Numeric class is just a small example of what Ruby can do, but I'm sure it gives you an idea of its power.

# that was just copy and paste from the source I got it from but like that is actually so cool 
class Numeric
    def plus(x)
        self.+(x) # attached method that does initial.+ with x
    end
end

# basic function definition
def plus(x, y)
    x + y
end

#omg they do the same thing 
z = plus(3, 4) # does 3 + 4
y = 5.plus(10) #does 5 + 10 
puts y # prints 15
puts z # prints 7