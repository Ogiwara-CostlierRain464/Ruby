input = gets.chomp.split(' ')
members = input[0].to_i
livecount = input[1].to_i
lives = Array.new
livecount.times do |e|
  lives.push(gets.chomp.split(' ').map{|e1| e1.to_i})
end
lives.each_with_index do |e,i|
  lives[i] = e.reduce {|i1,e1| i1+e1}
end

result = 0
lives.each do |e|
  if e >= 0
    result += e
  end
end
puts result