class Board
    attr_accessor :board
  
    def initialize
      @board = Array.new(6) { Array.new(7, '.') }
    end
  
    def show
      puts <<-HEREDOC
        #{board[0]}
        #{board[1]}
        #{board[2]}
        #{board[3]}
        #{board[4]}
        #{board[5]}
      HEREDOC
    end
  
    def position(num, choice, layer = 1)
      if layer > 6
        puts 'This column is full'
        return
      end
  
      if @board[row(layer)][column(num)] != '.'
        position(num, choice, layer + 1)
      else
        @board[row(layer)][column(num)] = choice
      end
    end
  
    def full?
      board.all? { |row| row.none? { |cell| cell == '.' } }
    end
  
    def game_over?
      return true if four_in_a_row?
      return true if four_in_a_column?
      return true if four_diagonal?
    end
  
    private
  
    def four_in_a_row?
      0.upto(3) do |y|
        0.upto(5) do |x|
          if @board[x][y] == @board[x][y + 1] && @board[x][y] == @board[x][y + 2] && @board[x][y] == @board[x][y + 3]
            return true unless @board[x][y] == '.'
          end
        end
      end
      false
    end
  
    def four_in_a_column?
      0.upto(6) do |y|
        0.upto(2) do |x|
          if @board[x][y] == @board[x + 1][y] && @board[x][y] == @board[x + 2][y] && @board[x][y] == @board[x + 3][y]
            return true unless @board[x][y] == '.'
          end
        end
      end
      false
    end
  
    def four_diagonal?
      0.upto(3) do |y|
        0.upto(2) do |x|
          if @board[x][y] == @board[x + 1][y + 1] && @board[x][y] == @board[x + 2][y + 2] && @board[x][y] == @board[x + 3][y + 3]
            return true unless @board[x][y] == '.'
          end
        end
      end
      6.downto(3) do |y|
        0.upto(2) do |x|
          if @board[x][y] == @board[x + 1][ y - 1] && @board[x][y] == @board[x + 2][y - 2]
            return true unless @board[x][y] == '.'
          end
        end
      end
      false
    end
  
    def row(layer)
      row = board.length
      row - layer
    end
  
    def column(num)
      (num - 1)
    end
  end