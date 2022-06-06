import 'package:dota2meta/api/fetch_all_heroes_opendota_api.dart';
import 'package:dota2meta/api/fetch_all_items_opendota_api.dart';
import 'package:dota2meta/api/fetch_meta_items_for_hero_opendota_api.dart';
import 'package:dota2meta/api/fetch_meta_lanes_roles_opendota_api.dart';
import 'package:dota2meta/repositories/fetch_all_heroes_repository.dart';
import 'package:dota2meta/repositories/fetch_all_items_repository.dart';
import 'package:dota2meta/repositories/fetch_meta_items_for_hero_repository.dart';
import 'package:dota2meta/repositories/fetch_meta_lanes_roles_repository.dart';
import 'package:dota2meta/support/app_http_client.dart';
import 'package:kiwi/kiwi.dart';

// wrap for KiwiContainer, concentrates operations here, because Kiwi can be replaced
class AppContainer {
  static initialize() {
    // register repositories implementations
    registerFactory<FetchAllHeroesRepository>(
      (_) => FetchHeroOpendotaApi(AppHttpClient()),
    );
    registerFactory<FetchAllItemsRepository>(
      (_) => FetchAllItemsOpendotaApi(AppHttpClient()),
    );
    registerFactory<FetchMetaItemsForHeroRepository>(
      (_) => FetchMetaItemsForHeroOpendotaApi(
        AppHttpClient(),
        fetchAllItemsRepository: resolve<FetchAllItemsRepository>(),
      ),
    );
    registerFactory<FetchMetaLanesRolesRepository>(
      (_) => FetchMetaLanesRolesOpendotaApi(AppHttpClient()),
    );
    // end register repositories implementations
  }

  static T resolve<T>() {
    return KiwiContainer().resolve<T>();
  }

  static void registerFactory<S>(
    Factory<S> factory, {
    String? name,
  }) {
    KiwiContainer().registerFactory<S>(factory, name: name);
  }
}
