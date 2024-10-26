module Towable
  def can_tow?(pounds) #return boolean based on if the object can be towed
    return pounds <2000
  end
end


class Vehicle #superclass for vehicle types
  @@number_of_vehicles = 0 #keep track of number of vehicles made
  def initialize(y=nil,m=nil,c=nil) #used for subclasses
    @year = y
    @model = m 
    @color = c
    @current_speed = 0
  end

  #global methods
  
  #calculate mileage of a trip, assume number 1 is gallons of gas, number 2 is miles total
  def self.gas_mileage(number1,number2)
    return "#{(number2.to_f/number1.to_f).round} miles per gallon of gas"
  end

  def self.count #display the vehicle count
    return "There are #{@@number_of_vehicles} vehicles in total."
  end

  #speed up the vehicle
  def speed_up(number)
    if(number < 0) #shouldn't use speedup when negative
      return "Provided speed increase is an invalid negative value."
    else
      @current_speed +=number
      return "You push the gas and accelerate #{number}mph."
    end
  end

  #slow down the vehicle
  def brake(number)
    if(number < 0) #shouldn't use brake when negative
      return "Provided speed decrease is an invalid negative value."
    elsif (@current_speed - number < 0) #it should stop when number is greater than speed
      @current_speed = 0
      return "You pushed the brakes to 0mph."
    else
      @current_speed -= number
      return "You push the brake and decelerate #{number}mph."
    end
  end

  #customized reader to current_speed
  def current_speed
    return "You are now going #{@current_speed}mph."
  end

  #shutdown the vehicle
  def shut_down(v)
    @current_speed = 0 #stop the vehicle
    return "Let's park the #{v}!" #output relevant message based on vehicle type
  end
  
  #change the color of the car
  def spray_paint(given_color)
    @color = given_color
    return "Your new #{@color} paint job looks great!"
  end

  #define a to string method to output relevant message about object contents
  def to_s(v) #use variable to allow subclasses to have own message
    return  "My #{v} is a #{@color}, #{@year}, #{@model}!"
  end

  def doorCount(d)
    return "The number of doors on this vehicle is #{d}."
  end

end

class MyCar < Vehicle
  @@NUMBER_OF_DOORS = 4 #labeled as NUMER_OF_DOORS in problem, presumably incorrect as seen on Piazza

  include Towable

  #initialize variables
  def initialize(y=nil,m=nil,c=nil)
    super(y,m,c) #super class contains variables
    @@number_of_vehicles +=1 #increment object counter in super class
      
    @name = "myCar" #name of all cars
  end

  def shut_down #shut down car using super class 
    return super(@name) #pass the relevant argument
  end

  def to_s #print car info using super class
    return super(@name)
  end

  #return door count in relevant message
  def doorCount #needs a specific vehicle type to have a number of doors, implement in subclasses
    return super(@@NUMBER_OF_DOORS)
  end

end

class MyTruck < Vehicle #similar to MyCar, see more thorough commenting there
  @@NUMBER_OF_DOORS = 2 

  include Towable

  #initialize variables
  def initialize(y=nil,m=nil,c=nil)
    super(y,m,c) 
    @@number_of_vehicles +=1 
      
    @name = "myTruck" #name of all trucks
  end

  def shut_down 
    return super(@name) 
  end

  def to_s 
    return super(@name)
  end

  def doorCount
    return super(@@NUMBER_OF_DOORS)
  end

end


#Test cases
puts subaru = MyCar.new(2000, "subaru outback", "blue") #My myCar is a blue, 2000, subaru outback!
puts subaru.speed_up(50) #You push the gas and accelerate 50mph.
puts subaru.current_speed #You are now going 50mph.
puts subaru.brake(30) #You push the brake and decelerate 30mph.
puts subaru.current_speed #You are now going 20mph.
puts subaru.brake(21) #You pushed the brakes to 0mph.
puts subaru.current_speed #You are now going 0mph.
puts subaru.to_s #My myCar is a blue, 2000, subaru outback!
puts subaru #My myCar is a blue, 2000, subaru outback!
puts subaru.spray_paint("black") #Your new black paint job looks great!
puts subaru.can_tow?(1000) #true
puts MyCar.gas_mileage(9,254) #28 miles per gallon of gas
puts subaru.doorCount #The number of doors on this vehicle is 4.

puts dodge = MyTruck.new(2018, "dodge journey", "black") #My myTruck is a black, 2018, dodge journey!
puts dodge.speed_up(30) #You push the gas and accelerate 30mph.
puts dodge.speed_up(40) #You push the gas and accelerate 40mph.
puts dodge.current_speed #You are now going 70mph.
puts dodge.brake(90) #You pushed the brakes to 0mph.
puts dodge.speed_up(-20) #Provided speed increase is an invalid negative value.
puts dodge.speed_up(20) #You push the gas and accelerate 20mph.
puts dodge.current_speed #You are now going 20mph.
puts dodge.spray_paint("red") #Your new red paint job looks great!
puts dodge #My myTruck is a red, 2018, dodge journey!
puts dodge.can_tow?(3000) #false
puts dodge.can_tow?(2000) #false
puts dodge.brake(50); #You pushed the brakes to 0mph.
puts MyTruck.gas_mileage(12,165) #14 miles per gallon of gas
puts MyTruck.gas_mileage(12,158) #13 miles per gallon of gas
puts dodge.doorCount #The number of doors on this vehicle is 2.

puts Vehicle.count #There are 2 vehicles in total.

