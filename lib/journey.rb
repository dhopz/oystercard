class Journey

    attr_reader :fare
    attr_accessor :entry_station, :exit_station

    PENALTY_FARE = 6

    def initialize(params)        
        @fare = PENALTY_FARE
        @entry_station = params[:entry_station]  
        @exit_station = params[:exit_station]  
    end
    
    def complete?
        !!@exit_station       
    end

    def finish(station)
        @exit_station = station
        @fare = fare
        self
    end

    def fare
        !!@exit_station && !!entry_station ? 1 : 6
    end

    def entry_station
        @entry_station
    end
    
end
