import '../../models/ceosi_flutter_catalog/catalog_entry_model.dart';

abstract class CatalogEntryRepositoryInterface {
  Future<CatalogEntryModel?> getEntryData();
}
