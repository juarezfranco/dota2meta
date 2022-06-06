import 'package:dota2meta/models/hero.dart';

class CounterHero {
  final List<Hero> strongAgainst;
  final List<Hero> weakAgainst;
  final List<Hero> goodTogether;

  const CounterHero({
    required this.strongAgainst,
    required this.weakAgainst,
    required this.goodTogether,
  });
}