def print_result(solutions)
  return nil if solutions.nil?
  puts "Amount of solutions: #{solutions.length}\n\n"

  (0...solutions.length).each { |i|
    puts "Solution  #{i + 1} is the following: "
    (0...solutions[i].length).each { |j|
      puts "Piece #{j + 1}"
      print_matrix(solutions[i][j])
    }
    puts "\n"
  }
end

def split_cake(cake)
  matrix = get_matrix(cake)

  rows = matrix.length
  cols = matrix[0].length

  possible_piece_x = []
  (1..rows).each { |i|
    possible_piece_x << i if matrix.length % i == 0
  }

  possible_piece_y = []
  (1..cols).each { |i|
    possible_piece_y << i if matrix[0].length % i == 0
  }

  solutions = []
  (0...possible_piece_x.length).each { |i|
    (0...possible_piece_y.length).each { |j|
      pieces = []
      possible = true
      row_num = rows / possible_piece_x[i]
      col_num = cols / possible_piece_y[j]

      x = 0
      while x < rows
        y = 0
        while y < cols
          sub_m = get_slice(matrix, x, row_num, y, col_num)

          if has_raisins(sub_m) != 1
            possible = false
            break
          end
          pieces << sub_m
          y += col_num
        end
        break unless possible
        x += row_num
      end
      if possible
        solutions << pieces
      end
    }
  }
  solutions
end


def has_raisins(matrix)
  amount = 0
  (0...matrix.length).each { |i|
    (0...matrix[i].length).each { |j|
      if matrix[i][j] == "o"
        amount += 1
      end
    }
  }
  amount
end

def get_matrix(cake)
  array = cake.split("\n")
  matrix = []

  (0...array.length).each { |i|
    matrix[i] = array[i].split("")
  }

  matrix
end

def get_slice(matrix, x, row_num, y, col_num)
  if matrix.nil?
    return nil
  end

  sub_cake = []

  (0...row_num).each { |i|
    sub_cake[i] = []
    (0...col_num).each { |j|
      sub_cake[i][j] = matrix[i + x][j + y]
    }
  }
  sub_cake
end

def print_matrix(matrix)
  (0...matrix.length).each { |i|
    (0...matrix[i].length).each { |j|
      print "#{matrix[i][j]}"
    }
    puts ""
  }
  puts ""
end

def main
  #cake =  "...o....\n" +
  #  "..o.....\n" +
  #  ".....o..\n" +
  #  ".....o..\n"

  cake = "o...\n"+
    ".o..\n"+
    "..o.\n"+
    "...o\n"
  matrix = get_matrix(cake)
  puts "Result: \nInput cake"
  print_matrix(matrix)

  solutions = split_cake(cake)
  print_result(solutions)
end

main
