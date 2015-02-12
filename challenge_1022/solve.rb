input = ''
while line = STDIN.gets
  input << line
end

if input.size.zero?
  input = <<-EOF
WNWNWWNW
NWNWNWWW
NWWNNWWN
WWWNWNNW
WNNNWNNW
WNNNNWNW
NNNNNWWW
WWWNWWWN
EOF
end

# 関連するアルゴリズム(Rectangleだけど)
# http://www.informatik.uni-ulm.de/acm/Locals/2003/
# 問題: http://www.informatik.uni-ulm.de/acm/Locals/2003/html/histogram.html
# 解答: http://www.informatik.uni-ulm.de/acm/Locals/2003/html/judge.html

# order-statistic treeについて
# http://en.wikipedia.org/wiki/Order_statistic_tree

mat = input.lines.map(&:chomp).map(&:chars)

def dump(mat)
  puts mat.map{|row| row.join(' ') }.join("\n")
end

def make_bin_matrix(matrix, char)
  matrix.map do |row|
    row.map do |c|
      c == char ? 1 : 0
    end
  end
end

def init_dp_matrix(bin_matrix)
  size = bin_matrix.size

  dp_matrix = Array.new(size) { Array.new(size, '_') }

  # copy 0th row
  dp_matrix[0] = bin_matrix[0]
  # copy 0th col
  size.times {|i| dp_matrix[i][0] = bin_matrix[i][0] }

  dp_matrix
end

def make_square_size_matrix(source, char)
  bin_matrix = make_bin_matrix(source, char)
  fill(init_dp_matrix(bin_matrix), bin_matrix)
end

def fill(dp_matrix, bin_matrix)
  if !dp_matrix[0].all?{|i| [0, 1].include?(i) }
    raise 'bin matrix is not correctly initialized'
  end
  size = dp_matrix.size

  (1...size).each do |j|
    (1...size).each do |i|
      dp_matrix[i][j] =
        case bin_matrix[i][j]
        when 0 then 0
        when 1
          [
            dp_matrix[i - 1][j - 1],
            dp_matrix[i - 1][j],
            dp_matrix[i][j - 1]
          ].min + 1
        end
    end
  end

  dp_matrix
end


w_result_matrix = make_square_size_matrix(mat, 'W')
n_result_matrix = make_square_size_matrix(mat, 'N')

# dump(w_result_matrix)
# puts '-------'
# dump(n_result_matrix)
# puts '-------'

puts "W: #{w_result_matrix.map(&:max).max}"
puts "N: #{n_result_matrix.map(&:max).max}"
