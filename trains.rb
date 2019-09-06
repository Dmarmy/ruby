
class Station
  attr_reader :trains, :station_name
  def initialize (station_name)
    @station_name = station_name
    @trains =[]
  end

  def arrival(train)
    trains.push train
  end

  def list
    pas_train=0
    fr_train=0
      trains.each do |train|
        if train.train_type =='Passenger'
          pas_train+=1
        else
          fr_train +=1
        end
      end
      puts "There are #{pas_train} Passenger trains and #{fr_train} Freight trains at #{station_name} Station at the moment"
  end

  def show_trains
      print "There are "
      trains.each { |train| print " #{train.train_number}; "}
      print "at the #{station_name} station"
  end

  def depart(train)
    trains.delete(train)
    train.station = nil
  end
end


class Route
  attr_accessor :stations

  def initialize (start_station, terminal_station)
    @stations=[start_station, terminal_station]
  end

 def add_station(station)
   self.stations.insert(-2, station)
 end

 def delete_station(station)
   if[stations.first, stations.last].include?(station)
     puts "Not a good idea"
   else
     self.stations.delete(station)
   end
  end
end


class Train
  attr_accessor :speed, :number_of_wagons, :station, :route
  attr_reader :train_number, :train_type

  def initialize (train_number, train_type, number_of_wagons, speed = 0)
    @train_number = train_number
    @train_type = train_type
    @number_of_wagons = number_of_wagons
    @speed = speed
  end

  def speed_pickup(pickup)
    self.speed += pickup
  end

  def stop
    self.speed = 0
    puts "The train is stopped"
  end

  def hitching
    if speed.zero?
      self.number_of_wagons += 1
    else puts "Stop the train first"
    end
  end

  def unhitching
    if speed.zero? && number_of_wagons > 0
      self.number_of_wagons -= 1
    else puts "The train is moving or no wagons left"
    end
  end

  def get_route(route)
    @route = route
  end


  def  go(station)
    if @station == station
      puts "Already here"
    elsif route.nil?
      puts "No route"
    elsif route.stations.include?(station)
      @station.depart(self) if @station
      @station = station
      station.arrival(self)
    else
      puts "This station isn't on the route:("
    end
  end

  def whats_near
    puts "current station is #{station.station_name}"
  puts "next station is #{route.stations[route.stations.index(station)+1].station_name}"
   if route.stations.index(station) != route.stations.size-1
      puts "previous station is #{route.stations[route.stations.index(station)-1].station_name}"
    end
  end
end
