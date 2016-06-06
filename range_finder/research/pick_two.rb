def combinations(arr)
  results = []
  (arr.length).times do |x|
    (x).upto(arr.length - 1) do |y|
      results.push("#{ x }..#{ y }")
    end
  end
  
  results
end


def total_combinations(arr)
  num_times = arr.length   
  results = 0

  until num_times == 0
    results += num_times
    num_times -= 1
  end

  results
end


def recursive_tot_comb(arr)
  return arr.length if arr.length < 1

  arr.length + recursive_tot_comb(arr[0..-2])
end


array = *(0..95)

results = combinations(array)
puts "results: #{ results } }"
puts "total files: #{ results.length }"

puts total_combinations(array)
puts recursive_tot_comb(array)  

