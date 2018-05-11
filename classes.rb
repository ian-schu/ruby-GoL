require 'colorize'
require 'pry'

class Cell
    def initialize(x,y)
        @alive = false
        @aliveNext = false
        @x = x
        @y = y
        @neighbors = []
    end

    def set_neighbors(grid,width,height)
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

    def compute_neighborhood
        sum = 0
        @neighbors.each do |cell|
            cell.alive? and sum += 1
        end

        if self.alive? then sum+=1 end

        sum
    end

    def compute_next
        neighborhood = self.compute_neighborhood
        if neighborhood == 3
            @aliveNext = true
        elsif neighborhood == 4
            @aliveNext = @alive.dup
        else
            @aliveNext = false
        end
    end

    def advance_cell
        @alive = @aliveNext.dup
        @aliveNext = false
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

    def print_neighbors
        puts "This cell is at: #{@x},#{@y}"
        puts "Neighbors are:"
        @neighbors.each do |cell|
            puts cell.coords unless cell == nil
        end
    end

    def alive?
        @alive
    end
end

class Board
    def initialize(width,height)
        @grid = Array.new(height) {|y| Array.new(width) {|x| Cell.new(x,y)} }
        @height = height
        @width = width

        self.set_all_neighbors
    end
    
    def print_grid
        @grid.each do |row|
            row.each do |cell|
                if cell.alive?
                    print "◼︎".colorize(:blue)
                else 
                    print "◼︎".colorize(:white)
                end
                print " "
            end
            print "\n"
        end
    end

    def set_all_neighbors
        @grid.each do |row|
            row.each do |cell|
                # puts cell.coords
                cell.set_neighbors(@grid,@width,@height)
            end
        end
    end

    def compute_next_round
        @grid.each do |row|
            row.each do |cell|
                cell.compute_next
            end
        end
    end

    def advance_board
        @grid.each do |row|
            row.each do |cell|
                cell.advance_cell
            end
        end
    end

    def step_forward
        self.compute_next_round
        self.advance_board
    end

    attr_accessor :grid
end

# myBoard = Board.new(5,7)
# myBoard.set_all_neighbors
# myBoard.grid[2][3].born
# myBoard.grid[2][2].born
# myBoard.grid[2][1].born
# myBoard.print_grid



