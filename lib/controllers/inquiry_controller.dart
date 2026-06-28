import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mxworld/models/content_models.dart';
import 'package:mxworld/services/inquiry_storage_service.dart';
import 'providers.dart';

/// Immutable UI state for the project-inquiry form.
@immutable
class InquiryFormState {
  const InquiryFormState({
    this.clientName = '',
    this.corporateEmail = '',
    this.serviceVertical = ServiceVertical.airFreight,
    this.operationalScope = '',
    this.isSubmitting = false,
    this.isSubmitted = false,
    this.errorMessage,
  });

  final String clientName;
  final String corporateEmail;
  final ServiceVertical serviceVertical;
  final String operationalScope;
  final bool isSubmitting;
  final bool isSubmitted;
  final String? errorMessage;

  bool get isValid =>
      clientName.trim().length >= 2 &&
      _isEmailValid(corporateEmail) &&
      operationalScope.trim().isNotEmpty;

  static bool _isEmailValid(String email) =>
      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email.trim());

  InquiryFormState copyWith({
    String? clientName,
    String? corporateEmail,
    ServiceVertical? serviceVertical,
    String? operationalScope,
    bool? isSubmitting,
    bool? isSubmitted,
    String? errorMessage,
    bool clearError = false,
  }) {
    return InquiryFormState(
      clientName: clientName ?? this.clientName,
      corporateEmail: corporateEmail ?? this.corporateEmail,
      serviceVertical: serviceVertical ?? this.serviceVertical,
      operationalScope: operationalScope ?? this.operationalScope,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}


/// Manages the project-inquiry form: field updates, draft persistence, and
/// submission to local Hive storage.
class InquiryController extends StateNotifier<InquiryFormState> {
  InquiryController(this._storage) : super(const InquiryFormState()) {
    _restoreDraft();
  }

  final InquiryStorageService _storage;

  void _restoreDraft() {
    final Map<dynamic, dynamic>? draft = _storage.readDraft();
    if (draft == null) return;
    state = state.copyWith(
      clientName: draft['clientName'] as String? ?? '',
      corporateEmail: draft['corporateEmail'] as String? ?? '',
      operationalScope: draft['operationalScope'] as String? ?? '',
      serviceVertical: ServiceVertical.values.firstWhere(
        (ServiceVertical v) => v.name == draft['serviceVertical'],
        orElse: () => ServiceVertical.airFreight,
      ),
    );
  }

  void updateClientName(String value) {
    state = state.copyWith(clientName: value, clearError: true);
    _persistDraft();
  }

  void updateEmail(String value) {
    state = state.copyWith(corporateEmail: value, clearError: true);
    _persistDraft();
  }

  void updateServiceVertical(ServiceVertical vertical) {
    state = state.copyWith(serviceVertical: vertical);
    _persistDraft();
  }

  void updateScope(String value) {
    state = state.copyWith(operationalScope: value, clearError: true);
    _persistDraft();
  }

  void _persistDraft() {
    _storage.saveDraft(<String, dynamic>{
      'clientName': state.clientName,
      'corporateEmail': state.corporateEmail,
      'serviceVertical': state.serviceVertical.name,
      'operationalScope': state.operationalScope,
    });
  }

  /// Validates and persists the inquiry, transitioning through submitting and
  /// submitted states. Returns true on success.
  Future<bool> submit() async {
    if (!state.isValid) {
      state = state.copyWith(
        errorMessage: 'Please complete all fields with valid details.',
      );
      return false;
    }
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      final ProjectInquiry inquiry = ProjectInquiry(
        clientName: state.clientName.trim(),
        corporateEmail: state.corporateEmail.trim(),
        serviceVertical: state.serviceVertical,
        operationalScope: state.operationalScope.trim(),
        submittedAt: DateTime.now(),
      );
      // Simulated network latency for the consultation request.
      await Future<void>.delayed(const Duration(milliseconds: 900));
      await _storage.saveSubmitted(inquiry);
      await _storage.clearDraft();
      state = state.copyWith(isSubmitting: false, isSubmitted: true);
      return true;
    } catch (error) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Submission failed. Please try again.',
      );
      return false;
    }
  }

  /// Resets the form to its initial empty state.
  void reset() => state = const InquiryFormState();
}

/// Exposes the inquiry form controller to the UI.
final StateNotifierProvider<InquiryController, InquiryFormState>
    inquiryControllerProvider =
    StateNotifierProvider<InquiryController, InquiryFormState>(
  (Ref ref) => InquiryController(ref.watch(inquiryStorageProvider)),
);
