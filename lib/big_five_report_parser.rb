class BigFiveReportParser
  class ParseError < StandardError; end

  def initialize(text:)
    @text = text
  end

  def next_line
    @text = @text.drop(1)
  end

  def current_line
    @text[0].chomp
  rescue NoMethodError => e
    raise ParseError, "Came across unexpected 'nil' value"
  end

  def line_label
    label = current_line.split(/[\.]+/)[0]
  end

  def line_value
    current_line.split(/[\.]+/)[1].to_i
  end
end
