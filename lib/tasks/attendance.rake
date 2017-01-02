namespace :attendance do
  desc "populate attendance"
  task :populate => :environment do
    since = ENV['since'] || Date.today

    begin
      Date.parse since.to_s
    rescue ArgumentError
      puts "invalid since date"
      exit(0)
    end

    practices = Practice.includes(:attendances).where("date >= ?", since)

    Player.all.each do |player|
      practices.each do |practice|
        unless practice.attendances.find_by player: player
          puts Attendance.create({
                              "player_id" => player.id,
                              "practice_id" => practice.id,
                              "status" => "pending"
                            })
        end
      end
    end
  end
end
