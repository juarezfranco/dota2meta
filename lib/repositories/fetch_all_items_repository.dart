import 'package:dota2meta/models/item.dart';

abstract class FetchAllItemsRepository {
  Future<List<Item>> fetchAllItems();
}