import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/inquiry_storage_service.dart';

/// Provides the Hive-backed inquiry storage service.
///
/// Overridden in `main()` with the initialized instance so the rest of the
/// app can depend on it synchronously via manual dependency injection.
final Provider<InquiryStorageService> inquiryStorageProvider =
    Provider<InquiryStorageService>(
  (Ref ref) => throw UnimplementedError(
    'inquiryStorageProvider must be overridden in main()',
  ),
);
