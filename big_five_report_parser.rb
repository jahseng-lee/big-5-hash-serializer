class BigFiveReportParser
  def initialize(text: text)
    @text = text
  end

  def next_line
    @text = @text.drop(1)
  end

  def current_line
    @text[0].chomp
  end

  def line_label
    current_line.split(/[\.]+/)[0]
  end

  def line_value
    current_line.split(/[\.]+/)[1].to_i
  end
end
