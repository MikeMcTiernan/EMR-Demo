#!/usr/bin/env ruby
# == Synopsis
#   Format STDIN for word counting via Hadoop/EMR
#
# == Examples
#   wordsplitter.rb ./inputfile
#
#   Reads lines from inputfile and outputs data formatted for aggregation by
#   Hadoop or Elastic MapReduce.
#
# == Usage
#   wordsplitter.rb source_file
#
# == Author
#   Mike McTiernan <mike@mikemct.com>
#
# == Copyright
#   Copyright (c) 2013, Mike McTiernan <mike@mikemct.com>
#
#   Permission to use, copy, modify, and/or distribute this software for any
#   purpose with or without fee is hereby granted, provided that the above
#   copyright notice and this permission notice appear in all copies.
#
#   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
#   WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
#   MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
#   SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
#   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
#   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
#   IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


ARGF.each do |line|
  line.strip!

  # Since we output on space, this keeps our loop DRY.
  line = line << " "
  word = ""

  # We iterative through the line rather than splitting to array to save 
  # memory. We also concatenate with << for the same reason
  line.each_char do |character|
    if character == " "
      if word.length > 1 # ignore junk words
        puts word.downcase << "\t1"
      end
      word = ""
    else
      word = word << character
    end
  end
end

