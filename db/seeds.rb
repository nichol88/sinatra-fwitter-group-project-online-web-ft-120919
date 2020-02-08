10.times.with_index do |i|
  Tweet.create(content: "here is tweet #{i}")
end
