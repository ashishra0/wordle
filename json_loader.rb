require 'json'

class JsonLoader
  def parse_json
    file = File.read('./words.json')
    data = JSON.parse(file)
    words = []
    data.keys.each { |w| words << w.upcase if w.length == 5}
    # create_json(words)

    words
  end

  # def create_json(words)
  #   word_hash = {}
  #   words.each do |w|
  #     word_hash[w] = 1
  #   end
  #
  #   File.write("words.json", word_hash.to_json, mode: "a")
  # end
end
