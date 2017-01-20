# coding: utf-8

require "date"


=begin
=end

def cels_to_fahr(c); c*9.to_f/5+32 end

puts cels_to_fahr 3.9

def char_counter(str)
  stack = Hash.new
  str.split("").each {|e| stack[e].nil? ? stack[e] = 1:stack[e] += 1 }
  stack.each {|k,v| puts "'#{k}': #{"*" * v}" }
end

char_counter("RRR IUYIU")


def wday(symbol)
  case symbol
    when :sunday then "日曜日"
    when :monday then "月曜日"
    when :saturday then "土曜日"
    else "?"
  end
end

puts wday(:sunday)

class Date
  def - other
    "Override"
  end
end

puts (Date.today - Date.new(1993,2,24))
