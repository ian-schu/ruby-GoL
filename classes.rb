class Cell
    def initialize(x,y)
        @alive = false
        @x = x
        @y = y
        @neighbors = []
    end

    def born
        self.alive = true
    end

    def die
        self.alive = false
    end

    def coords
        {x: @x, y:@y}
    end

    attr_accessor :alive
end

class Board
    def initialize(width,height)
        @grid = Array.new(height) {|y| Array.new(width) {|x| Cell.new(x,y)} }
    end
    
    def printGrid
        self.grid.each do |row|
            row.each do |cell|
                if cell.alive 
                    print "◼︎"
                else 
                    print "◻"
                end
                print " "
            end
            print "\n"
        end
    end

    attr_accessor :grid
end

myBoard = Board.new(5,7)
# puts myBoard.grid[2][3].alive
# puts myBoard.grid[2][3].born
# puts myBoard.grid[2][3].alive
# puts myBoard.grid[2][1].alive
myBoard.printGrid