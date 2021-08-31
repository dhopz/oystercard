require 'oystercard'

describe OysterCard do
    let(:oystercard) { OysterCard.new }
    it 'get my balance' do
        expect(oystercard.balance).to eq 0
    end

    it 'adds money to my balance' do
        oystercard.add_funds(10)
        expect(oystercard.balance).to eq 10
    end

    it 'raises an error if :balance > 90' do
      oystercard.add_funds(90)
      expect { oystercard.add_funds(1) }.to raise_error "Card balance cannot exceed #{OysterCard::LIMIT}"
    end

    it 'deducts funds from card' do
        oystercard.add_funds(10)
        oystercard.deducts(10)
        expect(oystercard.balance).to eq 0
    end

    it 'is initially not in a journey' do
      expect(subject.in_journey).to eq false
    end

    it 'can touch in' do
        subject.add_funds(10)
        subject.touch_in
        expect(subject.in_journey).to eq true
    end

    it 'can touch out' do
        subject.add_funds(10)
        subject.touch_in
        subject.touch_out
        expect(subject.in_journey).to eq false
    end

    it 'checks the balance before #touch_in' do        
        expect { subject.touch_in }.to raise_error "Balance must be greater than 1"
    end
end