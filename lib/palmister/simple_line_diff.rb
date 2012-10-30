module Palmister
  class SimpleLineDiff #:nodoc:
    attr_accessor :content

    def initialize
      @content = ""
    end

    def change(event)
      @content << %Q|<span class="only_a">#{event.old_element}</span><br/>\n<span class="only_b">#{event.new_element}</span><br/>\n|
    end

    # This will be called with both lines are the same
    def match(event)
      @content << %Q|<span class="match">#{event.old_element}</span><br/>\n|
    end

    # This will be called when there is a line in A that isn't in B
    def discard_a(event)
      @content << %Q|<span class="only_a">#{event.old_element}</span><br/>\n|
    end

    # This will be called when there is a line in B that isn't in A
    def discard_b(event)
      @content << %Q|<span class="only_b">#{event.new_element}</span><br/>\n|
    end
  end
end
