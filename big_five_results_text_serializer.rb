require_relative 'big_five_report_parser'

class BigFiveResultsTextSerializer
  class InvalidReportError < StandardError; end
  # Headers
  NAME = "NAME"
  EXTRAVERSION = "EXTRAVERSION"
  AGREEABLENESS = "AGREEABLENESS"
  CONSCIENTIOUSNESS = "CONSCIENTIOUSNESS"
  NEUROTICISM = "NEUROTICISM"
  OPENNESS_TO_EXPERIENCE = "OPENNESS TO EXPERIENCE"

  # Labels
  OVERALL_SCORE_LABEL = "Overall Score"
  FACETS_LABEL = "Facets"

  SECTIONS = [
    EXTRAVERSION,
    AGREEABLENESS,
    CONSCIENTIOUSNESS,
    NEUROTICISM,
    OPENNESS_TO_EXPERIENCE
  ]

  def initialize(text:)
    @parser = BigFiveReportParser.new(text: text)
    @report_hash = {}
  end

  def to_h
    parse_name

    SECTIONS.each do |section_name|
      parse_section(section_name: section_name)
    end

    @report_hash
  end

  private

  def parse_name
    @report_hash[NAME] = @parser.current_line
  end

  def parse_section(section_name:)
    if @parser.current_line.include?(section_name)
      overall_score = parse_overall_score
      @parser.next_line
      @parser.next_line

      @report_hash[section_name] = {
        "Overall Score" => overall_score,
        "Facets" => parse_facets
      }
    else
      @parser.next_line
      parse_section(section_name: section_name)
    end
  end

  def parse_overall_score
    # Just get the number from the report
    # i.e. EXTRAVERSION.........74 => 74
    @parser.line_value
  end

  def parse_facets
    # For 6 facets, extract the label and number
    # i.e. Friendliness.........74 => "Friendliness": 74

    facets = {}
    6.times do
      facets[@parser.line_label] = @parser.line_value

      @parser.next_line
      @parser.next_line
    end
    facets
  end
end
