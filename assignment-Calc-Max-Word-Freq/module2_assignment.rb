class LineAnalyzer
  attr_reader :highest_wf_count # a number with maximum number of occurrences for a single word (calculated)
  attr_reader :highest_wf_words #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  attr_reader :content #* content          - the string analyzed (provided)
  attr_reader :line_number #* line_number      - the line number analyzed (provided)

  def initialize(content,line_number)
    @content=content
    @line_number=line_number
    @highest_wf_words=[]
    calculate_word_frequency()
  end

  def calculate_word_frequency()
    word_hash=Hash.new(0)
    word_split=content.split
    word_split.each do |x|
      x.downcase!
      word_hash[x]+=1
    end
    @highest_wf_count=word_hash.values.max
    word_hash.each do |k,v|
      @highest_wf_words << k if @highest_wf_count==v
    end
  end
end

class Solution
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers=[]
  end
  def analyze_file()
    line=0
    File.foreach('test.txt') do |x|
      @analyzers << LineAnalyzer.new(x.chomp,line+=1)
    end
  end

  def calculate_line_with_highest_frequency()
    word_max=0
    @highest_count_words_across_lines=[]
    @analyzers.each do |x|
      word_max=x.highest_wf_count if x.highest_wf_count>word_max 
    end
    @highest_count_across_lines=word_max
    
    
    @analyzers.each do |x|
      @highest_count_words_across_lines << x if x.highest_wf_count==@highest_count_across_lines
    end
  end
  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |x|
      puts "#{x.highest_wf_words.inspect} (appears in line #{x.line_number})"
    end
  end
end


