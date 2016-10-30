class Map
  attr_accessor :width, :height, :squares, :players

  def initialize
    @width = 30
    @height = 20
    @squares = Hash.new
    @players = []
    @height.times do |y|
      @width.times do |x|
        @squares[[y, x]] = -1
      end
    end
  end

  def add_player(p)
    @squares[[p.y, p.x]] = p.id
    players << p.id
  end

  def player_did_move(p)
    @squares[[p.y, p.x]] = p.id
  end

  def square_is_free?(x, y)
    if (x < 0 || x >= @width) || (y < 0 || y >= @height)
      return false
    elsif @squares[[y, x]] != -1
      return false
    end
    true
  end

  def print
    y = 0
    while y < @height
      x = 0
      while x < @width
        x += 1
      end
      y += 1
    end
  end

  ## Algorithm
  def distance_between(x1, y1, x2, y2)
    dist_x = x2 - x1
    dist_y = y2 - y1
    sqrt(dist_x * dist_x + dist_y * dist_y)
  end

  def closest_player_from_square(x, y)
    closest = { distance: nil, player: nil }

    @height.times do |y2|
      @width.times do |x2|
        if @squares[[y2, x2]] != -1
          dist = distance_between(x, y, x2, y2)
          unless closest[:distance] && closest[:distance] <= dist
            closest[:distance] = dist
            closest[:player] = @squares[[y2, x2]]
          end
        end
      end
    end
    closest[:player]
  end

  def influence_of_players
    influence = {}

    @players.each do |p|
      influence[p] = 0
    end
    @height.times do |y|
      @width.times do |x|
        closest = closest_player_from_square(x, y)
        influence[closest] += 1 if closest
      end
    end
  end
end