import '../models/deal_model.dart';

class SavedDealsManager {
  static final List<DealModel> _savedDeals = [];

  static List<DealModel> get savedDeals => _savedDeals;

  static bool isSaved(DealModel deal) {
    return _savedDeals.any((d) => d.id == deal.id);
  }

  static void saveDeal(DealModel deal) {
    if (!isSaved(deal)) {
      _savedDeals.add(deal);
    }
  }

  static void removeDeal(DealModel deal) {
    _savedDeals.removeWhere((d) => d.id == deal.id);
  }
}

