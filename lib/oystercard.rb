#module JOURNEY
require_relative('journey')

class OysterCard
    attr_reader :balance, :journeys, :entry_station, :journey
    
    LIMIT = 90
    MINIMUM_CHARGE = 1

    def initialize()
        @balance = 0
        @journey = []
        @trips = []
        @current_journey = Hash.new
    
    end

    def add_funds(money)
        raise "Card balance cannot exceed #{LIMIT}" if balance + money > LIMIT
        @balance += money
    end

    def touch_in(station)
        raise "Balance must be greater than 1" if balance < MINIMUM_CHARGE
        #@in_journey = true
        @journey = Journey.new(entry_station: station)
        #@entry_station = station        
    end

    def touch_out(station) 
        #deducts(MINIMUM_CHARGE)
        #@in_journey = false 
        #@exit_station = station
        @journey.finish(station)
        #@journey.fare = 1
        
        @current_journey[:entry_station] = @entry_station
        @current_journey[:exit_station] = @exit_station
        @trips.push(@current_journey)
        
  end

    def in_journey?
        @in_journey       
    end

    private 
    
    def deducts(money)
        @balance -= money
    end

end