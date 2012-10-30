require 'nokogiri'

module PalmisterHelper
  protected

  DIFF_DELIMITER = Nokogiri::HTML.parse("<span class='diff-delimiter'><hr></span>").css('span').first

  # generates a simple line diff
  def line_diff(old, new)
    Palmister.diff(old,new)
  end

  def simple_line_diff(old, new)
    Palmister.diff(old,new, Palmister::SimpleLineDiff)
  end

  def simple_chunk_diff(old, new, line = 3)
    simplifier Palmister.diff(old,new, Palmister::SimpleLineDiff), line
  end

  # generates a simple correction diff with "inline-diffs"
  def correction_diff(old, new)
    Palmister.diff(old, new, Palmister::SimpleCorrectionDiff)
  end

  # generates a simple vc similar diff, where only the changes + some preceding
  # lines are shown
  def vc_diff(old,new)
    Palmister.diff(old,new, Palmister::VcDiff)
  end

  def simplifier html, line = 3
    elements = Nokogiri::HTML.parse(html).css("span").to_a
    elements.each_with_index do |el,index|
      start = line > index ? index : index - line
      finish = index + line
      if elements[start..finish].select{|span| span.nil? || span.attributes["class"].value == 'match'}.size == elements[start..finish].size
        elements[index] = nil
      end
    end

    elements.each_with_index do |el, index|
      next if index == 0 || index >= elements.size - 1
      elements[index-1] =  DIFF_DELIMITER if elements[index-1].nil? && el.present?
    end

    elements.compact!
    elements.shift if elements.any? && elements.first.attributes['class'].value == 'diff-delimiter'
    elements.map(&:to_html).join("<br/>")
  end

end

