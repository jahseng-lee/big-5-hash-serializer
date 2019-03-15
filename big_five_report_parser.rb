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
end
