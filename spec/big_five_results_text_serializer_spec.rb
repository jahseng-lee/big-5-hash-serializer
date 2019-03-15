require "spec_helper"
require_relative "../lib/big_five_results_text_serializer"

describe BigFiveResultsTextSerializer do
  let(:serializer) { BigFiveResultsTextSerializer.new(text: text) }

  describe "#to_h" do
    context "given valid Big 5 report" do
      # TODO this should probably be a mock file in an actual program
      let(:text) { File.readlines("big_five_traits.txt") }

      it "converts it into a results hash" do
        expect(serializer.to_h).to eq(
          {
            "NAME" => "Jah Seng Lee",
            "EXTRAVERSION" => {
              "Overall Score" => 74,
              "Facets" => {
                "Friendliness" => 74,
                "Gregariousness" => 92,
                "Assertiveness" => 81,
                "Activity Level" => 70,
                "Excitement-Seeking" => 56,
                "Cheerfulness" => 18
              },
            },
            "AGREEABLENESS" => {
              "Overall Score" => 70,
              "Facets" => {
                "Trust" => 92,
                "Morality" => 50,
                "Altruism" => 57,
                "Cooperation" => 63,
                "Modesty" => 82,
                "Sympathy" => 21
              },
            },
            "CONSCIENTIOUSNESS" => {
              "Overall Score" => 56,
              "Facets" => {
                "Self-Efficacy" => 67,
                "Orderliness" => 57,
                "Dutifulness" => 95,
                "Achievement-Striving" => 56,
                "Self-Discipline" => 47,
                "Cautiousness" => 15
              },
            },
            "NEUROTICISM" => {
              "Overall Score" => 17,
              "Facets" => {
                "Anxiety" => 27,
                "Anger" => 14,
                "Depression" => 79,
                "Self-Consciousness" => 1,
                "Immoderation" => 28,
                "Vulnerability" => 19
              },
            },
            "OPENNESS TO EXPERIENCE" => {
              "Overall Score" => 54,
              "Facets" => {
                "Imagination" => 81,
                "Artistic Interests" => 14,
                "Emotionality" => 6,
                "Adventurousness" => 93,
                "Intellect" => 48,
                "Liberalism" => 71
              },
            },
          }
        )
      end
    end

    context "given invalid Big 5 report" do
      let(:text) { ["Some text", "Some more text", "Something else"] }

      it "raises an InvalidReportError" do
        expect{ serializer.to_h }.to raise_error(BigFiveResultsTextSerializer::InvalidReportError)
      end
    end
  end
end
