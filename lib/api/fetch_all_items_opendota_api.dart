import 'package:dota2meta/config.dart';
import 'package:dota2meta/models/item.dart';
import 'package:dota2meta/repositories/fetch_all_items_repository.dart';
import 'package:dota2meta/support/app_http_client.dart';

class FetchAllItemsOpendotaApi extends FetchAllItemsRepository {
  final AppHttpClient httpClient;

  FetchAllItemsOpendotaApi(this.httpClient);

  @override
  Future<List<Item>> fetchAllItems() {
    return httpClient.get<List<Item>>(
      '${Config.hostOpendotaApi}/api/constants/items',
      cache: const Duration(hours: 24),
      parse: (data) {
        final List<Item> items = [];

        (data as Map<String, dynamic>).forEach((key, value) {
          items.add(Item(
            id: value["id"],
            urlImg: "https://cdn.dota2.com/${value["img"]}",
            name: value["dname"] ?? "",
            cost: value["cost"] ?? 0,
          ));
        });
        return items;
      },
    );
  }
}
