require 'oystercard'

describe OysterCard do
    let(:oystercard) { OysterCard.new }
    let(:station) { double :station }   
    
    it 'get my balance' do
        expect(subject.balance).to eq 0
    end

    it 'adds money to my balance' do
        subject.add_funds(10)
        expect(subject.balance).to eq 10
    end

    it 'raises an error if :balance > 90' do
      oystercard.add_funds(OysterCard::LIMIT)
      expect { oystercard.add_funds(1) }.to raise_error "Card balance cannot exceed #{OysterCard::LIMIT}"
    end

    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'can touch in' do
        subject.add_funds(10)
        subject.touch_in(station)
        expect(subject).to be_in_journey
    end

    it 'checks the balance before #touch_in' do        
        expect { subject.touch_in(station) }.to raise_error "Balance must be greater than 1"
    end

    it 'records the departing station' do
        subject.add_funds(10)
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
    end

    describe 'stations' do
        let(:entry_station) { double :station }
        let(:exit_station) { double :station }            
        let(:journeys){ {entry_station: entry_station, exit_station: exit_station} }
        
        it '#touch_out deducts money from card' do
            subject.add_funds(10)
            expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-OysterCard::MINIMUM_CHARGE)
        end

        it 'can touch out' do
            subject.add_funds(10)
            subject.touch_in(entry_station)
            subject.touch_out(exit_station)
            expect(subject).not_to be_in_journey
        end

        it 'stores a journey' do
            subject.add_funds(10)
            subject.touch_in(entry_station)
            subject.touch_out(exit_station)
            expect(subject.journeys).to include({entry_station: entry_station, exit_station: exit_station})
        end

        it 'stores a journey hash' do
            subject.add_funds(10)
            subject.touch_in(entry_station)
            subject.touch_out(exit_station)
            expect(subject.journeys).to include journeys
        end
    end    
end
