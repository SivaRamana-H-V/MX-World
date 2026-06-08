import 'package:flutter_test/flutter_test.dart';
import 'package:mxworld/controllers/inquiry_controller.dart';
import 'package:mxworld/models/content_models.dart';

void main() {
  group('InquiryFormState validation', () {
    test('is invalid when fields are empty', () {
      const InquiryFormState state = InquiryFormState();
      expect(state.isValid, isFalse);
    });

    test('is invalid with a malformed email', () {
      const InquiryFormState state = InquiryFormState(
        clientName: 'Acme Corp',
        corporateEmail: 'not-an-email',
        operationalScope: 'Move 40 containers monthly.',
      );
      expect(state.isValid, isFalse);
    });

    test('is valid when all fields are well-formed', () {
      const InquiryFormState state = InquiryFormState(
        clientName: 'Acme Corp',
        corporateEmail: 'ops@acme.com',
        serviceVertical: ServiceVertical.seaFreight,
        operationalScope: 'Move 40 containers monthly.',
      );
      expect(state.isValid, isTrue);
    });

    test('copyWith can clear the error message', () {
      const InquiryFormState state =
          InquiryFormState(errorMessage: 'Something failed');
      final InquiryFormState cleared = state.copyWith(clearError: true);
      expect(cleared.errorMessage, isNull);
    });
  });

  group('ProjectInquiry serialization', () {
    test('round-trips through a map', () {
      final ProjectInquiry original = ProjectInquiry(
        clientName: 'Globex',
        corporateEmail: 'logistics@globex.com',
        serviceVertical: ServiceVertical.fourPl,
        operationalScope: 'Cross-dock electronics in APAC.',
        submittedAt: DateTime(2024, 6, 1, 9, 30),
      );

      final ProjectInquiry restored =
          ProjectInquiry.fromMap(original.toMap());

      expect(restored.clientName, original.clientName);
      expect(restored.corporateEmail, original.corporateEmail);
      expect(restored.serviceVertical, original.serviceVertical);
      expect(restored.operationalScope, original.operationalScope);
      expect(restored.submittedAt, original.submittedAt);
    });
  });
}
