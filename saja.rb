#i know youre gonna eat down fr AYYYEEE

puts "typeeee"

#sorry gang this is a bit long but this is actually really cool lmao i think we should demo method_missing + respond_to_missing + define_method together kinda like this example.
# it shows 

# whats interesting here? Ruby can modify its own classes at runtime!!
# many static languages like Java, C#, C don't support "open classes" like this.
# sure, they have reflection and runtime features, but Ruby lets you reopen and change classes as you go. 


class Speaker
    # if a method is not found, ruby will call this method 
    # when you override "method_missing", you should override its corresponding "respond_to_missing" method
    # why? because respond_to_missing is where you define how other objects can query
    # whether THEY can handle that specific missing method or not
    def method_missing(method_name, *args, &block)
      if method_name.to_s.start_with?("shout_")
        word_to_shout = method_name.to_s.sub("shout_", "")
        # puts "#{word_to_shout.upcase}!! "
        self.class.define_method(method_name) do
            puts "#{word_to_shout.upcase}!!!"
          end
    
          send(method_name) #call this method dynamically
      else
        super #a key word (similar to java when you use super to inherit from a parent class) means: “I’m not handling this missing method... go look at the parent classes method_missing. If they don't handle it, Ruby will raise the usual NoMethodError.”
      end
    end
  
    def respond_to_missing?(method_name, include_private = false)
      method_name.to_s.start_with?("shout_") || super
    end
  end
  
  speaker = Speaker.new
  speaker.shout_hello #first shouthello: this will go through -> call -> method_missing -> define method -> call the method      (missing -> method_missing -> define_method(:shout_hello) -> send(:shout_hello))
  speaker.shout_hello #second shouthello: no missing → call the real method directly it exists now!
  speaker.shout_ruby # the rest of these also go through the long way bc its out first encounter of these methods!
  speaker.shout_metaprogramming
  speaker.shout_this
  speaker.shout_is
  speaker.shout_cool
  speaker.shout_sike

  # important note: you actually modified the class at this point, not just that instance! so if you make a new one it'll now have shout_hello, shout_ruby, etc all as methods!
  speaker2 = Speaker.new
  speaker2.shout_hello


  class Party
    def initialize
      @characters = ["mario", "luigi", "peach"]  # "these are the heroes we know about."
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
  
  # "make a new party instance"
  party = Party.new
  
  # "these methods don't exist yet... I will catch them with method_missing and create them."
  party.mario # first time: handled by method_missing -> define_method using mario -> prints
  party.luigi   # same idea here
  party.peach 
  
  # "call them again, now they’re real methods on the class! no method_missing needed."
  party.mario
  party.luigi
  
  # "this one is not in @characters, I can't help anymore."
  party.yoshi
  


  

