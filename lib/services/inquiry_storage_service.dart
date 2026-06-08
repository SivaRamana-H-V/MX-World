import 'package:hive_flutter/hive_flutter.dart';

import '../models/content_models.dart';

/// Persists project inquiries to a local Hive box.
///
/// Stores each [ProjectInquiry] as a primitive map (see
/// [ProjectInquiry.toMap]) so no generated Hive type adapters are required,
/// keeping the data layer free of code generation.
class InquiryStorageService {
  InquiryStorageService(this._box);

  static const String boxName = 'inquiries';
  static const String _draftKey = 'current_draft';

  final Box<dynamic> _box;

  /// Opens (or creates) the inquiries box. Call once during app bootstrap.
  static Future<InquiryStorageService> initialize() async {
    final Box<dynamic> box = await Hive.openBox<dynamic>(boxName);
    return InquiryStorageService(box);
  }

  /// Appends a submitted inquiry to the persisted history.
  Future<void> saveSubmitted(ProjectInquiry inquiry) async {
    final List<dynamic> history =
        (_box.get('history') as List<dynamic>?) ?? <dynamic>[];
    history.add(inquiry.toMap());
    await _box.put('history', history);
  }

  /// Returns all previously submitted inquiries, newest last.
  List<ProjectInquiry> readHistory() {
    final List<dynamic> history =
        (_box.get('history') as List<dynamic>?) ?? <dynamic>[];
    return history
        .whereType<Map<dynamic, dynamic>>()
        .map(ProjectInquiry.fromMap)
        .toList(growable: false);
  }

  /// Caches an in-progress draft so the form survives app restarts.
  Future<void> saveDraft(Map<String, dynamic> draft) =>
      _box.put(_draftKey, draft);

  /// Reads a cached draft, or null if none exists.
  Map<dynamic, dynamic>? readDraft() =>
      _box.get(_draftKey) as Map<dynamic, dynamic>?;

  /// Clears the cached draft after a successful submission.
  Future<void> clearDraft() => _box.delete(_draftKey);
}
