h = Hash.new

h["a"] = [1,2,3,4]
h["b"] = [2,3]
h["c"] = [1,4]

puts "Primeiro, ultimo e 3th\n"
puts h["a"].first
puts h["a"].last
puts "#{h["a"][2]}\n"


puts "A e B\n"

result = Array.new

if h["a"].first > h["b"].last
    puts "Nao existem documentos em comum"
else
   puts result = h["a"] & h["b"]           
end   

#puts "#{result.each do |r| puts r.to_s end}\n"


puts "B ou C\n"

result = Array.new

if h["b"].first > h["c"].last
    puts "Nao existem documentos em comum"
else
    puts result = h["b"] | h["c"]        
end   

#puts "#{result.each do |r| puts r.to_s end}\n"
