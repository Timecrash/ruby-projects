require "spec_helper"

describe ConnectFour do
  let(:game) { ConnectFour.new("Reimu", "Marisa") }
  describe ".initialize" do
    it "creates a board" do
      expect(game.board).to be_instance_of Board
    end
    it "creates two players" do
      expect(game.red_player).to be_instance_of Player
      expect(game.black_player).to be_instance_of Player
    end
  end
  describe ".has_won?" do
    let(:test_array) {[nil,"B",nil,"B","B","B","B"]}
    it "returns true only if four specified values are together" do
      expect(game.has_won?(test_array, "B")).to eq true
    end
  end
end

describe Board do
  let(:board) { Board.new }

  describe ".update_board" do
    context "when column 3 is empty" do
      it "updates column 3" do
        board.update_board(3, "R")
        expect(board.board[-1][3]).to eq "R"
      end
    end
  end
end

describe Player do
  let(:player) { Player.new("Reimu", "R") }
  describe ".initialize" do
    it "expects the correct color" do
      expect(player.color).to be "red"
    end
  end
end
