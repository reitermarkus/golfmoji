module OS
  def self.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def self.mac?
    (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def self.unix?
    !windows?
  end

  def self.linux?
    unix? && !mac?
  end
end

src = []

funcs = {
  '0' => '0️⃣',
  '1' => '1️⃣',
  '2' => '2️⃣',
  '3' => '3️⃣',
  '4' => '4️⃣',
  '5' => '5️⃣',
  '6' => '6️⃣',
  '7' => '7️⃣',
  '8' => '8️⃣',
  '9' => '9️⃣',
  '+' => '➕',
  'plus' => '➕',
  '-' => '➖',
  'minus' => '➖',
  'sum' => '➕',
  '*' => '✖',
  'mul' => '✖',
  '/' => '➗',
  'div' => '➗'
}

if !ARGV.empty?
  # we have a file given. Read it or exit if the given file doesn't exist
  unless File.exist?(ARGV.first)
    STDERR.puts "Error: '" + ARGV.first + "' doesn't exist!"
    exit 1
  end

  src = File.read(ARGV.first).rstrip.split("\n")
else
  # we don't have a file given, so we ask for input

  print("Please enter the source-code you want to parse:\n(finish with an empty line)\n\n")
  src = STDIN.gets("\n\n").rstrip.split("\n")
end

src = src.map { |i|
  funcs[i]
}

if OS.mac?
  IO.popen('pbcopy', 'w') do |f|
    f << src.join
  end

  puts 'Info:'
  puts 'The source-code has been copied to your clip-board!'
  puts 'You may paste it into a new file or post it on a website.'
else
  print("\n" + src.join + "\n\n")
end
