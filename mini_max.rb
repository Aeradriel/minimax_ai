class MiniMax
  attr_accessor :map, :main_player, :players, :max_turn

  def initialize(map, players, main_player, max_turn = 40)
    @map = map
    @players = players
    @max_turn = max_turn
    @main_player = main_player
  end

  def simulate_for(actual, player, map = nil, direction = nil)
    directions = [:top, :bot, :left, :right]
    map = @map unless map
    res = []
    if actual <= max_turn # || won || lost
      directions.each do |d|
        res << simulate_for(actual + 1, (player + 1) % @players.count, map, d)
      end
      if player == @player
        res.min { |a, b| a[:score] <=> b[:score] }
      else
        res.max { |a, b| a[:score] <=> b[:score] }
      end
    else
      influences = map.influence_of_players
      bad_influences = 0
      influences.each do |k, v|
        bad_influences += v unless k == main_player
      end
      res = { score: influences[@player], move: direction }
    end
    res
  end
end
