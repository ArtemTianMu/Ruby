def download_sudoky
  file_data = ""
  begin
    file = File.open('sudoky/data.txt')
    file_data = file.read
    file.close
  rescue Errno::ENOENT
    puts "File or directory not found."
  rescue Errno::EPERM
    puts "Operation not permitted."
  rescue IOError
    puts "Error! Can't read the file."
  end

  width = 9
  height = 9
  arr = Array.new(height){Array.new(width)}
  file_data = file_data.split("\n")
  (0..file_data.length-1).each do |i|
    arr[i] = file_data[i].split(/ /).map(&:to_i)
  end
  arr
end


def print_sudoky(arr)
  string = ""
  m = arr.length
  n = arr[0].length

  for i in (0..m-1)
    if i == 3 or i == 6
      string += "_____________________________\n"
    end
    for j in (0..n-1)
      if arr[i][j] == 0
        string += " * "
      else
        string += " " +arr[i][j].to_s+ " "
      end
      if j == 2 or j == 5
        string += "|"
      end
    end
    string += "\n"
  end
  puts string
end

def is_suitable(arr,row,column,number)
  (0..8).each do|i|
    if arr[row][i] == number
      return false
    end
  end

  (0..8).each do|i|
    if arr[i][column] == number
      return false
    end
  end

  start_row = row - row%3
  start_column = column - column%3
  (0..2).each do |i|
    (0..2).each do |j|
      if arr[i+start_row][j+start_column] == number
        return false
      end
    end
  end
  return true

end

def solve_sudoky(arr,row,col)
  if row == 8 and col == 9
    return true
  end

  if col == 9
    row += 1
    col = 0
  end

  if arr[row][col] > 0
    return solve_sudoky(arr,row,col+1)
  end

  (1..9).each do|i|
    if is_suitable(arr,row,col,i)
      arr[row][col] = i
      if solve_sudoky(arr,row,col+1)
        return true
      end
    end
    arr[row][col]=0
  end

  return false

end

def main
  arr = download_sudoky
  if solve_sudoky(arr,0,0)
    print_sudoky(arr)
  end
end

main
