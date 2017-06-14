module Golfmoji

    # loads a file (given as a startup-argument or by terminal-input)
    # and returns it's content as an emoji-array
    def self.load_source

        argsize = ARGV.size;

        # check wether we have a file given as the first argument or not
        # file-argument given -> read file
        if argsize == 1

            # check wether the file is readable or not
            mojifilepath = ARGV[0]
            if !File.readable?(mojifilepath)
                print("'" + mojifilepath + "' not found or not readable! 😨")
                return nil
            end

            # if readable, read full source-code and return a list of all mojis given by the file
            mojicode = File.read(mojifilepath).rstrip

            return mojicode

        # no file-argument given -> read console-input
        else

            # input file-content
            print "Please enter some mojicode: (empty line for finishing code-input)\n"
            mojiinput = STDIN.gets("\n\n");

            # if some valid input is given, split it
            if mojiinput
                mojicode = mojiinput.rstrip
                return mojicode
            else
                return nil
            end
        end

    end

    def self.parse
        src = load_source
        if src
            chains = src.split("⛓").map(&.chars.map(&.to_s))
        else
            [["⛳"]]
        end
    end

end
