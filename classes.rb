class Cell
    def initialize(x,y)
        @alive = false
        @x = x
        @y = y
        @neighbors = []
    end

    def setNeighbors(grid,width,height)
        x = @x
        y = @y

        east_most = width - 1
        south_most = height - 1
        west = @x == 0 ? east_most : @x - 1
        east = @x == east_most ? 0 : @x + 1
        north = @y == 0 ? south_most : @y - 1
        south = @y == south_most ? 0 : @y + 1

        @neighbors.push(grid[y][east] || nil)
        @neighbors.push(grid[y][west] || nil)
        @neighbors.push(grid[south][x] || nil)
        @neighbors.push(grid[north][x] || nil)
        @neighbors.push(grid[north][west] || nil)
        @neighbors.push(grid[south][west] || nil)
        @neighbors.push(grid[north][east] || nil)
        @neighbors.push(grid[south][east] || nil)
    end

    def born
        @alive = true
    end

    def die
        @alive = false
    end

    def coords
        {x: @x, y:@y}
    end

    def neighbors
        puts "This cell is at: #{@x},#{@y}"
        puts "Neighbors are:"
        @neighbors.each do |cell|
            puts cell.coords unless cell == nil
        end
    end

    attr_accessor :alive
end

class Board
    def initialize(width,height)
        @grid = Array.new(height) {|y| Array.new(width) {|x| Cell.new(x,y)} }
        @height = height
        @width = width
    end
    
    def printGrid
        @grid.each do |row|
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

    def setAllNeighbors
        @grid.each do |row|
            row.each do |cell|
                # puts cell.coords
                cell.setNeighbors(@grid,@width,@height)
            end
        end
    end

    attr_accessor :grid
end

myBoard = Board.new(5,7)
myBoard.setAllNeighbors
myBoard.grid[5][4].born
myBoard.grid[6][4].born
myBoard.printGrid
# myBoard.grid[6][4].setNeighbors(myBoard.grid)
myBoard.grid[6][4].neighbors