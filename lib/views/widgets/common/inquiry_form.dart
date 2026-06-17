import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';

/// Enhanced customer inquiry form replacing the legacy QUICK INQUIRY sections.
///
/// Features labeled fields with validation, dropdown menus for country and
/// enquiry type, a multi-line message area, and a dark-themed card layout.
/// At minimum the Business Email field is required; all validated fields show
/// inline error messages and the submit button triggers a snack-bar on success.
class InquiryForm extends StatefulWidget {
  const InquiryForm({super.key});

  @override
  State<InquiryForm> createState() => _InquiryFormState();
}

class _InquiryFormState extends State<InquiryForm> {
  /// Global key for form validation.
  final _formKey = GlobalKey<FormState>();

  /// Controllers for every text input.
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _companyController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _messageController = TextEditingController();

  /// Currently selected country.
  String? _selectedCountry;

  /// Currently selected enquiry type.
  String? _selectedEnquiryType;

  /// Sample country list – extend or replace with a full dataset in production.
  static const _countries = <String>[
    'United Kingdom',
    'United States',
    'Canada',
    'Australia',
    'India',
    'Germany',
    'France',
    'Netherlands',
    'Singapore',
    'Japan',
    'China',
    'Brazil',
  ];

  /// Pre-populated enquiry types matching the screenshot spec.
  static const _enquiryTypes = <String>[
    'Technical Support',
    'Sales Inquiry',
    'General Feedback',
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _companyController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  /// Validates all fields and shows a success snack-bar.
  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your inquiry has been submitted. We will be in touch shortly.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  /// Builds a labeled text field inside the dark card.
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Field label rendered above the input.
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textOnDarkSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: const TextStyle(color: AppColors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.textOnDarkTertiary, fontSize: 14),
              filled: true,
              fillColor: AppColors.charcoal,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.accent, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.redAccent, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }

  /// Builds a labeled dropdown wrapped in the same visual style.
  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textOnDarkSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            initialValue: value,
            decoration: InputDecoration(
              hintText: '-- Select --',
              hintStyle: const TextStyle(color: AppColors.textOnDarkTertiary, fontSize: 14),
              filled: true,
              fillColor: AppColors.charcoal,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.accent, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.redAccent, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
              ),
            ),
            dropdownColor: AppColors.charcoal,
            style: const TextStyle(color: AppColors.white, fontSize: 14),
            icon: const Icon(Icons.expand_more, color: AppColors.textOnDarkSecondary),
            isExpanded: true,
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: onChanged,
            validator: (v) => v == null ? 'Please select an option' : null,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = AppBreakpoints.isMobile(width);
    final text = Theme.of(context).textTheme;

    // The form card with dark background – reused in both mobile and desktop layout.
    final Widget formCard = Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.nearBlack,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Text(
              'CUSTOMER ENQUIRIES',
              style: text.titleMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Row: First Name + Last Name
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _firstNameController,
                    label: 'First Name',
                    hint: 'John',
                    validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _buildTextField(
                    controller: _lastNameController,
                    label: 'Last Name',
                    hint: 'Doe',
                    validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),

            // Company Name
            _buildTextField(
              controller: _companyController,
              label: 'Company Name',
              hint: 'Acme Corp',
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),

            // Business Email (required – submission blocked if empty)
            _buildTextField(
              controller: _emailController,
              label: 'Business Email',
              hint: 'john@acme.com',
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Business Email is required';
                if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim())) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),

            // Mobile Number
            _buildTextField(
              controller: _mobileController,
              label: 'Mobile Number',
              hint: '081234 56789',
              keyboardType: TextInputType.phone,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                final digitsOnly = v.replaceAll(RegExp(r'\D'), '');
                if (digitsOnly.length < 7 || digitsOnly.length > 15) {
                  return 'Enter a valid phone number (7–15 digits)';
                }
                return null;
              },
            ),

            // Row: Country + Enquiry Type
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    label: 'Select Country',
                    value: _selectedCountry,
                    items: _countries,
                    onChanged: (v) => setState(() => _selectedCountry = v),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _buildDropdown(
                    label: 'Select Enquiry Type',
                    value: _selectedEnquiryType,
                    items: _enquiryTypes,
                    onChanged: (v) => setState(() => _selectedEnquiryType = v),
                  ),
                ),
              ],
            ),

            // Message text area
            _buildTextField(
              controller: _messageController,
              label: 'Message',
              hint: 'Describe your inquiry...',
              maxLines: 4,
              validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
            ),

            const SizedBox(height: AppSpacing.sm),

            // Submit button
            SizedBox(
              width: isMobile ? double.infinity : 180,
              height: 48,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: _submit,
                child: const Text(
                  'SUBMIT INQUIRY',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Wraps the form in a full-width section with a dark background.
    // On desktop the header text sits to the left of the card; on mobile
    // the entire content stacks vertically.
    return Container(
      color: AppColors.black,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppSpacing.xxl : AppSpacing.section,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width >= 1200 ? 80 : width >= 768 ? 48 : 24,
            ),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _InquiryHeader(),
                      const SizedBox(height: AppSpacing.xxl),
                      formCard,
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(flex: 4, child: _InquiryHeader()),
                      const SizedBox(width: AppSpacing.section),
                      Expanded(flex: 6, child: formCard),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// The left-side header text ("QUICK INQUIRY") extracted so only one widget
/// needs to be defined for both mobile and desktop branches.
class _InquiryHeader extends StatelessWidget {
  const _InquiryHeader();

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUICK\nINQUIRY',
          style: text.headlineLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.white,
            height: 1.1,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Have a specific logistics challenge? Reach out to our global team '
          'for a tailored solution that meets your scale and precision requirements.',
          style: text.bodyMedium?.copyWith(
            color: AppColors.textOnDarkSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
