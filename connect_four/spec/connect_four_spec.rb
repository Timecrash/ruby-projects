describe ConnectFour do
  let(:game) { ConnectFour.new("Reimu", "Marisa") }
  describe ".initialize" do
    it "creates a board" do
      expect(game.board).to be_instance_of Board
    end
    it "creates two players" do
      expect(game.red_player).to be_instance_of Player
      expect(game.red_player.color).to eq "R"
      expect(game.black_player).to be_instance_of Player
      expect(game.black_player.color).to eq "B"
    end
  end
  describe ".has_won?" do
    let(:black_array) {[nil,"B",nil,"B","B","B","B"]}
    let(:nil_array) {[nil,"B",nil,"B",nil,"B",nil]}
    let(:partial_array) {[nil, "B", "B", nil]}
    let(:partial_win_array) {[nil, "B", "B", "B", "B"]}
    it "returns true only if four specified values are together" do
      expect(game.has_won?(black_array, "B")).to eq true
    end
    it "returns false if there isn't four in a row" do
      expect(game.has_won?(nil_array, "B")).to eq false
    end
    it "works if array.length < 7" do
      expect(game.has_won?(partial_array, "B")).to eq false
      expect(game.has_won?(partial_win_array, "B")).to eq true
    end
  end
end

describe Board do
  let(:board) { Board.new }
  describe ".update_board" do
    context "when column 3 is empty," do
      it "updates column 3" do
        board.update_board(-1, 3, "R")
        expect(board.board[-1][3]).to eq "R"
      end
    end
    context "when column 3 has values, but isn't full," do
      it "updates column 3 at the next available space" do
        board.board = [
          [" "," "," "," "," "," "," "],
          [" "," "," "," "," "," "," "],
          [" "," "," "," "," "," "," "],
          [" "," "," "," "," "," "," "],
          [" "," "," ","B"," "," "," "],
          [" "," "," ","R"," "," "," "],
          [" "," "," ","B"," "," "," "] ]
        expect(board.get_empty_row(3)).to eq 3
        board.update_board(-4, 3, "R")
        expect(board.board[3][3]).to eq "R"
      end
    end
    context "when column 3 is full," do
      it "does not update and returns nil" do
        board.board = [
          [" "," "," ","R"," "," "," "],
          [" "," "," ","B"," "," "," "],
          [" "," "," ","R"," "," "," "],
          [" "," "," ","B"," "," "," "],
          [" "," "," ","B"," "," "," "],
          [" "," "," ","R"," "," "," "],
          [" "," "," ","B"," "," "," "] ]
        expect{board.update_board(nil, 3, "R")}.not_to change { board.board }
      end
    end
  end
  describe ".check_for_win" do
    let(:default_check) { board.check_for_win(3, 3, "B") }
    let(:edge_check) { board.check_for_win(0, 0, "B") }
    let(:off_center_check) { board.check_for_win(2, 0, "B") }

    context "when the board is empty," do
      it "returns a 2D array of horizontal, vertical, and diagonal values" do
        expect(default_check).to be_instance_of Array
        expect(edge_check).to be_instance_of Array
        expect(off_center_check).to be_instance_of Array
      end
    end
    context "when the board has values," do
      before do
        board.board = [
          ["B"," "," "," "," "," "," "],
          ["B"," "," "," "," "," "," "],
          ["B"," "," "," "," "," "," "],
          ["R"," ","R","B","B","B","B"],
          ["B"," ","R","B","B","R","R"],
          ["R"," ","B","R","R","B","B"],
          ["R"," ","R","B","R","R","R"] ]
      end
      it "will give only partial arrays if it fully can't check an edge" do
        expect(edge_check[3]).to match_array ["B"]
        expect(off_center_check[2]).to match_array ["B"," ","R","R","R"]
        expect(off_center_check[3]).to match_array [" "," ","B"]
      end
      it "gives seven values if in a corner" do
        expect(edge_check[2]).to match_array ["B"," "," ","B","B","B","R"]
      end
      it "will only fill the array with valid values" do
        expect(default_check[0]).to match_array ["R"," ","R","B","B","B","B"]
        expect(default_check[1]).to match_array [" "," "," ","B","B","R","B"]
        expect(default_check[2]).to match_array ["B"," "," ","B","B","B","R"]
        expect(default_check[3]).to match_array [" "," "," ","B","R"," ","R"]
      end
    end
  end
end

describe Player do
  let(:player) { Player.new("Reimu", "R") }
  describe ".initialize" do
    it "initializes with the correct color" do
      expect(player.color).to eq "R"
    end
  end
end
