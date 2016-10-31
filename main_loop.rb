players = []
map = Map.new

STDOUT.sync = true

loop do
  # n: total number of players (2 to 4).
  # p: your player number (0 to 3).
  n, p = gets.split(' ').collect {|x| x.to_i}

  n.times do |i|
    x0, y0, x, y = gets.split(' ').collect { |x| x.to_i }
    if players.count <= n
      players << Player.new(i, x0, y0, map)
      map.add_player(players[i])
    end
    players[i].change_pos(x, y)
  end

  d = MiniMax.new(map, players, p).simulate_for(0, p)
  players[p].move(d)
end