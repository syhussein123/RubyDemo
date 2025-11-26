# basic print statement: 
puts "ayoooo helllooooooo"

# basic class structure and definition with methods 
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