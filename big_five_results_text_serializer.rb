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
    @text = text
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
    @report_hash[NAME] = current_line
    @text = @text.drop(2) # Name and newline
  end

  def parse_section(section_name:)
    if current_line[/#{section_name}/].nil?
      @text = @text.drop(1)
      parse_section(section_name: section_name)
    else
      overall_score = parse_overall_score(section_name: section_name)
      @text = @text.drop(2)

      @report_hash[section_name] = {
        "Overall Score" => overall_score,
        "Facets" => parse_facets
      }
    end
  end

  def parse_overall_score(section_name: section_name)
    # Just get the number from the report
    # i.e. EXTRAVERSION.........74 => 74
    current_line.split(/[\.]+/)[1].to_i
  end

  def parse_facets
    # For 6 facets, extract the label and number
    # i.e. Friendliness.........74 => "Friendliness": 74

    facets = {}
    6.times do
      parsed_line = current_line.split(/[\.]+/)
      facets[parsed_line[0]] = parsed_line[1].to_i
      @text = @text.drop(2)
    end
    facets
  end

  def current_line
    @text[0].chomp
  end
end
