require './base_player.rb'

class YourPlayer < BasePlayer
  attr_accessor :last_visited_point
  def next_point(time:)
    # Implement your strategy here.
    # 1.nearest neighbour
    unless @last_visited_point
      @last_visited_point = {
        row: 0,
        col: 0
      }
    else
      points = [
        {row: @last_visited_point[:row], col: @last_visited_point[:col]}, 
        {row: @last_visited_point[:row]+1, col: @last_visited_point[:col]},
        {row: @last_visited_point[:row], col: @last_visited_point[:col]+1},
        {row: @last_visited_point[:row]-1, col: @last_visited_point[:col]},
        {row: @last_visited_point[:row], col: @last_visited_point[:col]-1},
      ]
      visitable_points = points.select{|p| grid.is_valid_move?(from: @last_visited_point, to: p)}
      visitable_points.reject!{|p| grid.visited[p]}
      next_point = visitable_points[rand(visitable_points.length)]
      if next_point
        @last_visited_point = next_point
      else
        if !grid.all_visited?
          raise "dead"
        end
      end
    end
    @last_visited_point
  end

  def grid
    game.grid
  end
end
