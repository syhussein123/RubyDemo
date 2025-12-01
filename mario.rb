#this ruby file demonstrates metaprogramming with method_missing and define_method
# creating dynamic methods for party members joining a party
# it uses the example of the mario party character picking process!


class Party
    def initialize
      @characters = ["mario", "luigi", "peach", "yoshi", "wario", "dk"]  # "these are the heroes we know about."
    end

    def yoshi
        puts "yoshi is already taken :(, pick a different character!"
      end
  
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

#heres a party instance, right now the only methods that exists are method_missing and yoshi
  # "make a new party instance"
  party = Party.new
  printAllMethods(party)
    

# method_missing
  # "these methods don't exist yet... I will catch them with method_missing and create them."
  #----------------------------------
  party.mario # first time: handled by method_missing -> define_method using mario -> prints
  party.luigi   # same idea here
  party.peach 
  puts ""
  printAllMethods(party)


  #Party.yoshi
  #----------------------------------
  party.yoshi
  puts ""
  printAllMethods(party)


  #“NPC 
  #----------------------------------
  party.daisy # "this one is not in @characters, I can't help anymore."
  puts ""
  printAllMethods(party)


  #“Inheritance
  #----------------------------------
  party2 = Party.new
  puts "Party 2 inherits all of Party's methods!"
  printAllMethods(party2)