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

  SECTIONS = [
    EXTRAVERSION,
    AGREEABLENESS,
    CONSCIENTIOUSNESS,
    NEUROTICISM,
    OPENNESS_TO_EXPERIENCE
  ]

  FACETS = {
    "EXTRAVERSION" => [
      "Friendliness",
      "Gregariousness",
      "Assertiveness",
      "Activity Level",
      "Excitement-Seeking",
      "Cheerfulness"
    ],
    "AGREEABLENESS" => [
      "Trust",
      "Morality",
      "Altruism",
      "Cooperation",
      "Modesty",
      "Sympathy"
    ],
    "CONSCIENTIOUSNESS" => [
      "Self-Efficacy",
      "Orderliness",
      "Dutifulness",
      "Achievement-Striving",
      "Self-Discipline",
      "Cautiousness"
    ],
    "NEUROTICISM" => [
      "Anxiety",
      "Anger",
      "Depression",
      "Self-Consciousness",
      "Immoderation",
      "Vulnerability"
    ],
    "OPENNESS TO EXPERIENCE" => [
      "Imagination",
      "Artistic Interests",
      "Emotionality",
      "Adventurousness",
      "Intellect",
      "Liberalism"
    ]
  }

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
  rescue BigFiveReportParser::ParseError => e
    raise InvalidReportError, e.message
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
        "Facets" => parse_facets(section_name: section_name)
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

  def parse_facets(section_name:)
    # For 6 facets, extract the label and number
    # i.e. Friendliness.........74 => "Friendliness": 74

    facets = {}
    6.times do
      label = @parser.line_label

      raise InvalidReportError, "Invalid facet of #{section_name}: #{label}" unless FACETS[section_name].include?(label)
      facets[label] = @parser.line_value

      @parser.next_line
      @parser.next_line
    end
    facets
  end
end
