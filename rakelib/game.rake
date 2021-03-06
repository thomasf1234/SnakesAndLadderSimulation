namespace :game do
  desc "start a game"
  # bundle exec rake game:start['Jimmy John Frankie',classic]
  task :start, [:player_names, :board_name] do |t, args|
    board_path = File.join("resources/boards", args[:board_name])
    board = BoardBuilder.new.build(board_path)
    dice = Dice.new(true)
    player_names = args[:player_names].strip.split(/ +/).map(&:strip)
    players = player_names.map { |player_name| Player.new(player_name, board) }
    game = Game.new(players, board, dice)
    won_player = catch(:player_won) do
      game.start
    end

    puts "Congratulations! #{won_player.name} won! and the crowd goes wild! :)"
  end

  # bundle exec rake game:replay['resources/replays/test_replay.csv']
  task :replay, [:file_path,] do |t, args|
    board = BoardBuilder.new.build
    dice = Dice.new(true)
    dice_map = {'Liverpool v Everton' => 6,
                'Man Utd v Man City' => 5,
                'Arsenal v Chelsea' => 4,
                'Aston Villa v WBA' => 3,
                'Leeds v Sheffield Wednesday' => 2,
                'Swansea v Cardiff' => 1}
    player = Player.new("John", board, dice_map)
    game = Game.new([player], board, dice)
    game.replay(args[:file_path])
  end

  desc "create dummy replay"
  task :create_replay do
    require 'csv'

    matches = [
        Match.new("Liverpool", "Everton"),
        Match.new("Man Utd", "Man City"),
        Match.new("Arsenal", "Chelsea"),
        Match.new("Aston Villa", "WBA"),
        Match.new("Leeds", "Sheffield Wednesday"),
        Match.new("Swansea", "Cardiff"),
    ]

    CSV.open("resources/replays/test_replay.csv", "wb") do |csv|
      csv << ["match", "team", "scored_at"]

      matches.each do |match|
        rand(0..5).times do
          team = rand(0..1) == 0 ? match.home : match.away
          sleep 1
          csv << [match.to_s, team, DateTime.now]
        end
      end
    end
  end
end





