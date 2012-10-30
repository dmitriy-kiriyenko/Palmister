require 'diff/lcs'
require 'erubis'
require 'palmister_helper'
require 'palmister/simple_correction_diff'
require 'palmister/simple_html_diff'
require 'palmister/simple_line_diff'
require 'palmister/string_simple_correction_diff'
require 'palmister/vc_diff'

module Palmister
  extend Erubis::XmlHelper
  def self.diff(old, new, output = Palmister::SimpleHtmlDiff)
    # html_escape code for display and split strings into lines array
    a = html_escape(old).split(/\015?\012/)
    b = html_escape(new).split(/\015?\012/)
    out = output.new
    Diff::LCS.traverse_balanced(a, b, out)
    out.content
  end
end
