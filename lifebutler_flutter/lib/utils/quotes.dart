import 'dart:math';

enum QuoteType { session, bonus, goal }

class Quotes {
  static const List<String> sessionQuotes = [
    "One step closer.",
    "Consistency is key.",
    "Small wins matter.",
    "Keep showing up.",
    "Building momentum.",
    "Good work.",
    "On the right path.",
    "Another one down.",
    "Steady progress.",
    "Focus on the process."
  ];

  static const List<String> bonusQuotes = [
    "Unstoppable.",
    "Going the extra mile.",
    "Above and beyond.",
    "Crushing it!",
    "Leveling up.",
    "Excellence is a habit.",
    "You're on fire!",
    "Pushing limits.",
    "Pure dedication.",
    "Be proud."
  ];

  static const List<String> goalQuotes = [
    "Challenge Completed!",
    "You did it!",
    "Mission Accomplished.",
    "Discipline pays off.",
    "Stronger than yesterday.",
    "A promise kept to yourself.",
    "Victory!",
    "Goal crushed.",
    "Outstanding effort.",
    "This is who you are now."
  ];

  static String getRandomQuote(QuoteType type) {
    List<String> pool;
    switch (type) {
      case QuoteType.session:
        pool = sessionQuotes;
        break;
      case QuoteType.bonus:
        pool = bonusQuotes;
        break;
      case QuoteType.goal:
        pool = goalQuotes;
        break;
    }
    return pool[Random().nextInt(pool.length)];
  }
}
