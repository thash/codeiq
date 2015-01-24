# input = <<-EOF
# WNWNWWNW
# NWNWNWWW
# NWWNNWWN
# WWWNWNNW
# WNNNWNNW
# WNNNNWNW
# NNNNNWWW
# WWWNWWWN
# EOF

input = ''; STDIN.each {|line| input << line }

def mat(input, lt, rb)
  input.lines[lt[1]..rb[1]].map{|l|
    l.chomp.chars[lt[0]..rb[0]]
  }
end

# print mat(input, [1,4], [3, 6])
# #=> [["N", "N", "N"], ["N", "N", "N"], ["N", "N", "N"]]


def all_possible_matrixes(input, size)
  datasize = input.lines.length
  matrixes = []
  0.upto(datasize - size) do |top|
    testline = input.lines[top].chomp
    w_subst = testline.scan(/W{#{size}}/)
    n_subst = testline.scan(/N{#{size}}/)
    next if w_subst.length.zero? && n_subst.length.zero?
    0.upto(datasize - size) do |left|
      testcol = input.lines[top..(top+size-1)].map{|line| line.chomp.chars[left] }.join
      next if testcol != 'W'*size && testcol != 'N'*size
      matrixes << mat(input, [left, top], [left + size - 1, top + size - 1])
    end
  end
  matrixes
end

def t(time)
  time.instance_eval { '%s.%03d' % [strftime('%H:%M:%S'), (usec / 1000.0).round] }
end

result = {W: nil, N: nil}

(input.lines.length).downto(1) do |size|
  mxs = all_possible_matrixes(input, size)
  puts "[#{t(Time.now)}] for size #{size}, there're #{mxs.size} matrixes -- #{result}"
  mxs.each do |matrix|
    result[:W] = size if result[:W].nil? && matrix.flatten.all?{|x| x == 'W' }
    result[:N] = size if result[:N].nil? && matrix.flatten.all?{|x| x == 'N' }
  end
  break if result[:W] && result[:N]
end

puts "W: #{result[:W]}"
puts "N: #{result[:N]}"
