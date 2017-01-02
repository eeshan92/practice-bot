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
    new_attendances = []

    Player.all.each do |player|
      practices.each do |practice|
        unless practice.attendances.map(&:player_id).include? player.id
          new_attendances << Attendance.create({
                                                "player_id" => player.id,
                                                "practice_id" => practice.id,
                                                "status" => "pending"
                                              })
        end
      end
    end

    new_attendances.group_by { |a| a.player.full_name }.
                    each do |player, attendances|
                      puts "Added attendances for \"#{player}\""
                      attendances.sort_by { |att| att.practice.date }.
                                  each { |att| puts att.practice.date }
                      puts ""
                    end
  end
end
