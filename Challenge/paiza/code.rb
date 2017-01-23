
def makeeven(num)
  while num >= 10
    q = num / 10
    p = num % 10
    num = p+q
  end
  num
end

def core(str)
  xis = 0
  even = 0
  odd = 0
  str.split('').each_with_index do |e, i|
    if e == 'X'
      xis = i.even? ? 0 : 1
    else
      if i.even?
        even += makeeven((e.to_i)*2)
      else
        odd += e.to_i
      end
    end
  end

  sub =( (((even+odd)/10)+1)*10 - (even+odd))

  if sub == 10
    sub = 0
  end

  xis == 1 ? sub : (sub/2)
end

counter = gets.to_i
stack = Array.new(counter)
counter.times do |i|
  stack[i] = gets.chomp
end
stack.each do |e|
  puts core(e)
end