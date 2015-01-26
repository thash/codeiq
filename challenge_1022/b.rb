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

input = ''; STDIN.each {|line| input << line }

# Rectangleだけど関連するアルゴリズム
# http://www.informatik.uni-ulm.de/acm/Locals/2003/
# 問題: http://www.informatik.uni-ulm.de/acm/Locals/2003/html/histogram.html
# 解答: http://www.informatik.uni-ulm.de/acm/Locals/2003/html/judge.html

# order-statistic tree とは
# http://en.wikipedia.org/wiki/Order_statistic_tree


