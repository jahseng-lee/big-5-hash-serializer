module Constants
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
end
