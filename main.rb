require_relative 'app/models/legislator'

class Main
  def self.q1(state)
    # senator = Legislator.find(senator: )
    senator = Legislator.select(:firstname, :party,:lastname).where("state = ? AND title= ?", [state],["Sen"]).order(lastname: :asc)
    puts "Senators:"
    senator.each do |value|
      puts value.firstname + " " + value.lastname + "(" + value.party + ")"
    end

    puts " "
    representatives = Legislator.select(:firstname, :party,:lastname).where("state = ? AND title= ?", [state],["Rep"]).order(lastname: :asc)
    puts "Representatives:"
    representatives.each do |value|
      puts value.firstname + " " + value.lastname + "(" + value.party + ")"
    end
  end

  def self.q2(gender, in_office)
    # senator
    a = Legislator.where("gender = ? AND in_office = ? AND title= ?", [gender],[in_office],["Sen"]).count()
    b = Legislator.where("title= ?", ["Sen"]).count()
    percentage = ((a.to_f/b.to_f)*100).round
    puts "Male Senator: #{a}"
    puts "Male Representatives: #{percentage}%"

    a = Legislator.where("gender = ? AND in_office = ? AND title= ?", [gender],[in_office],["Rep"]).count()
    b = Legislator.where("title= ?", ["Rep"]).count()
    percentage = ((a.to_f/b.to_f)*100).round
    puts "Male Senator: #{a}"
    puts "Male Representatives: #{percentage}%"
  end

  def self.q3
    # states = Legislator.select(:state, ).group(:state).order('count_id desc').count('id').map do |row|
    #   row = {state: row[0], count: row[1]}
    # end
    senator = Legislator.select("state").where("title = 'Sen'").where("in_office = '1'").group("state").count
    rep = Legislator.select("state").where("title = 'Rep'").where("in_office = '1'").group("state").count
    rep = rep.sort_by {|key,value| value}.reverse!
    rep.each do |key, value|
      puts "#{key}: " "#{senator[key]} Senators, #{value} Representative(s)"
    end

      # states.each do |value|
      #   puts value[:state]
      # end
    # p states
  end

  def self.q4
    senator = Legislator.select("title").group("title").where("title = 'Sen' or title = 'Rep'").count

    p senator
  end

  def self.q5
    people = Legislator.where("in_office = 0").destroy_all
  end
end

# m = Main.q1("NH")
# m  = Main.q2("M","1")
m = Main.q5
