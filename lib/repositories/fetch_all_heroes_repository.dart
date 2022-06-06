import 'package:dota2meta/models/hero.dart';

abstract class FetchAllHeroesRepository {
  Future<List<Hero>> fetchAllHeroes();
}