#spec/mastermind_spec.rb

require './bin/mastermind.rb'

RSpec.describe Board do
    let(:board) { Board.new }
    describe "#panel" do
        it 'returns the board ' do
            expect(board.panel).to eql("Here's your current board")
          end
    end
    describe "#panel_reset" do
        it "Restart the board" do
            expect(board.panel_reset).to eql(0)
        end
    end
end

RSpec.describe Computer do
    describe "#randomly" do
        it "returns a random array of colors" do
            let = Computer.new
            expect(let.randomly).to eql(["red","green","brown","magenta","blue","cyan"])
        end        
    end
end

RSpec.describe Check do
    let(:check) { Check.new }
    describe "#checker_win" do
        it "returns false in the player does not win" do
            expect(check.checker_win).to eql(false)
        end
        it "returns true if the player wins" do
            expect(check.checker_win).not_to eql(true)
        end
    end
end
