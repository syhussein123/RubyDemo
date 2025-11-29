class Party
    def initialize
      @characters = ["mario", "luigi", "peach", "daisy"]  # "these are the heroes we know about."
    end
    
    # note: we can demo this 
    # def yoshi
    #     puts "yoshi joined to the party :p!"
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
        puts "Unknown character (not invited): #{name_str}."
      end
    end

  end

def printAllMethods(party)
    all_methods = party.methods
    instance_methods = all_methods - Object.instance_methods
    puts "Instance methods in Party Class:"
    puts instance_methods
    puts "-----"
end

  # "make a new party instance"
  party = Party.new
  printAllMethods(party)

  # "these methods don't exist yet... I will catch them with method_missing and create them."
  party.mario # first time: handled by method_missing -> define_method using mario -> prints
  party.luigi   # same idea here
  party.peach 
  puts "-----"

  printAllMethods(party)

  # "call them again, now they’re real methods on the class! no method_missing needed."
  party.mario
  party.luigi
  
  # "this one is not in @characters, I can't help anymore."
  #party.yoshi
  puts "-----"
  printAllMethods(party)

  #showcasing inheritance of methods to new instances after metaprogramming has modified the class
  party2 = Party.new
  printAllMethods(party2)

  party2.daisy
  puts "-----"
  printAllMethods(party2)




  

