#this ruby file demonstrates metaprogramming with method_missing and define_method
# creating dynamic methods for party members joining a party
# it uses the example of the mario party character picking process!

class Party
    def initialize
      @characters = ["mario", "luigi", "peach", "yoshi", "wario", "dk"]  # "these are the heroes we know about."
    end

    # note: we can demo this 
    # def yoshi
    #     puts "yoshi is already taken :(, pick a different character!"
    #   end
  
    # "If you call a method that doesn't exist, Ruby sends it here."
    def method_missing(name, *args, &block) # "name of method to make, args to pass to the method, block to send to method"
      name_str = name.to_s
  
      if @characters.include?(name_str)
        # "this character method doesn't exist yet... let's create it!"
        self.class.define_method(name) do
          puts "#{name_str} has joined the party!"   # "what the new method will do."
        end
  
        # "now that I've created the method, just call it like normal."
        send(name)
      else
        # "I still don't know this character, even with metaprogramming..."
        puts "#{name_str} is an npc and cannot join the party."
      end
    end
  end


  
#function to print all methods of Party class
def printAllMethods(party)
    all_methods = party.methods
    instance_methods = all_methods - Object.instance_methods
    puts "Instance methods:"
    puts instance_methods
    puts ""
end

#1: showing no methods at the start except for method_missing
  # "make a new party instance"
  party = Party.new
  printAllMethods(party)
  
 
  
#2: showing the differece between a defined method and method_missing
  party.yoshi
  puts ""
  printAllMethods(party)




#3: showing multiple method additions and how they now exist on the class but that they need to be called with method_missing the first time
  # "these methods don't exist yet... I will catch them with method_missing and create them."
  party.mario # first time: handled by method_missing -> define_method using mario -> prints
  party.luigi   # same idea here
  party.peach 
  puts ""
  printAllMethods(party)





#4: showing that the methods now exist on the class and can be called directly in the same way, it doesn't duplicate the method signature because it already exists now!
  # "call them again, now they’re real methods on the class! no method_missing needed."
  party.mario
  party.luigi
  puts ""

  printAllMethods(party)




  #5: showing how daisy isn't a playable character in our list and thus method_missing doesn't create a method for it 
  party.daisy # "this one is not in @characters, I can't help anymore."
  puts ""




  #6: showcasing inheritance of methods to new instances after metaprogramming has modified the class
  party2 = Party.new
  puts "Party 2 inherits all of Party's methods!"
  printAllMethods(party2)