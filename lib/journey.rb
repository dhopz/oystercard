class Journey

    attr_reader :fare
    attr_accessor :entry_station, :exit_station

    PENALTY_FARE = 1

    def initialize(params)        
        @fare = PENALTY_FARE
        @entry_station = params[:entry_station]  
    end
    
    def complete?
        !!@exit_station       
    end

    def finish(station)
        @exit_station = station
        self
    end

    def entry_station
        @entry_station
    end
    
end
