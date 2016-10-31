class Player
  attr_accessor :id, :x, :y, :x0, :y0, :light_path, :map

  def initialize(id, x, y, map)
    @id = id
    @x0 = x
    @y0 = y
    @x = x
    @y = y
    @map = map
    @light_path = []
  end

  def change_pos(x, y)
    @light_path << [x, y]
    @x = x
    @y = y
    map.player_did_move(self)
  end

  def move(dir = nil)
    directions = [:top, :bot, :left, :right]
    (move_toward(dir) && return) if dir && can_move_toward(dir)
    directions.each do |d|
      if can_move_toward(d)
        move_toward(d)
        return true
      end
    end
    false
  end

  private

  def can_move_toward(direction)
    case direction
      when :top
        STDERR.puts("TOP: #{@x} #{@y} -> #{@map.square_is_free?(@x, @y - 1)}")
        return @map.square_is_free?(@x, @y - 1)
      when :bot
        STDERR.puts("BOT: #{@x} #{@y} ->  #{@map.square_is_free?(@x, @y + 1)}")
        return @map.square_is_free?(@x, @y + 1)
      when :left
        STDERR.puts("LEFT #{@x} #{@y} -> : #{@map.square_is_free?(@x - 1, @y)}")
        return @map.square_is_free?(@x - 1, @y)
      else
        STDERR.puts("RIGHT: #{@x} #{@y} ->  #{@map.square_is_free?(@x + 1, @y)}")
        return @map.square_is_free?(@x + 1, @y)
    end
  end

  def move_toward(direction)
    case direction
      when :top
        @y = @y - 1
        puts 'UP'
      when :bot
        @y = @y + 1
        puts 'DOWN'
      when :left
        @x = @x - 1
        puts 'LEFT'
      else
        @x = @x + 1
        puts 'RIGHT'
    end
  end
end