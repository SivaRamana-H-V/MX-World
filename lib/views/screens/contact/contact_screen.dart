import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controllers/inquiry_controller.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/content_models.dart';
import '../../../services/content_repository.dart';
import '../../widgets/common/eyebrow_label.dart';
import '../../widgets/common/mx_button.dart';
import '../../widgets/common/mx_page_scaffold.dart';
import '../../widgets/common/safe_network_image.dart';

/// Contact screen: a hero with an overlaid project-inquiry form, regional
/// office cards, a network map placeholder, and a strategic-support list.
class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MxPageScaffold(
      sections: <Widget>[
        _ContactHero(),
        _OfficesSection(),
        _NetworkMapSection(),
        _StrategicSupportSection(),
      ],
    );
  }
}

class _ContactHero extends StatelessWidget {
  const _ContactHero();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    final Widget intro = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Global\nConnectivity.',
            style: text.displayLarge?.copyWith(color: AppColors.white),),
        const SizedBox(height: AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Text(
            'Our interconnected network operates across every major trade lane. '
            'Consult with our logistics architects to engineer a seamless '
            'global supply chain solution tailored to your operational '
            'requirements.',
            style: text.bodyLarge
                ?.copyWith(color: AppColors.textOnDarkSecondary),
          ),
        ),
      ],
    );

    return Container(
      color: AppColors.black,
      constraints: BoxConstraints(minHeight: isMobile ? 0 : 560),
      child: Stack(
        children: <Widget>[
          const Positioned.fill(
            child: Opacity(
              opacity: 0.4,
              child: SafeNetworkImage(url: ContentRepository.heroImage),
            ),
          ),
          Padding(
            padding: AppSpacing.pageGutter(width).copyWith(
              top: AppSpacing.section,
              bottom: AppSpacing.section,
            ),
            child: isMobile
                ? Column(
                    children: <Widget>[
                      intro,
                      const SizedBox(height: AppSpacing.xl),
                      const _InquiryForm(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(flex: 5, child: intro),
                      const SizedBox(width: AppSpacing.xl),
                      const Expanded(flex: 5, child: _InquiryForm()),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

/// The project-inquiry form, bound to [inquiryControllerProvider].
///
/// Demonstrates Riverpod state management: each field dispatches an update to
/// the controller, validation state drives the submit button, and a success
/// state swaps the form for a confirmation panel.
class _InquiryForm extends ConsumerStatefulWidget {
  const _InquiryForm();

  @override
  ConsumerState<_InquiryForm> createState() => _InquiryFormState();
}

class _InquiryFormState extends ConsumerState<_InquiryForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _scopeController;

  @override
  void initState() {
    super.initState();
    // Seed controllers from any restored draft in the provider state.
    final InquiryFormState state = ref.read(inquiryControllerProvider);
    _nameController = TextEditingController(text: state.clientName);
    _emailController = TextEditingController(text: state.corporateEmail);
    _scopeController = TextEditingController(text: state.operationalScope);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _scopeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InquiryFormState state = ref.watch(inquiryControllerProvider);
    final InquiryController controller =
        ref.read(inquiryControllerProvider.notifier);
    final TextTheme text = Theme.of(context).textTheme;

    if (state.isSubmitted) {
      return _SuccessPanel(onReset: () {
        controller.reset();
        _nameController.clear();
        _emailController.clear();
        _scopeController.clear();
      },);
    }

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Project Inquiry', style: text.headlineMedium),
          const SizedBox(height: AppSpacing.lg),
          _FormField(
            label: 'CLIENT NAME',
            hint: 'Enter full name',
            controller: _nameController,
            onChanged: controller.updateClientName,
          ),
          const SizedBox(height: AppSpacing.lg),
          _FormField(
            label: 'CORPORATE EMAIL',
            hint: 'name@company.com',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: controller.updateEmail,
          ),
          const SizedBox(height: AppSpacing.lg),
          _ServiceVerticalDropdown(
            value: state.serviceVertical,
            onChanged: controller.updateServiceVertical,
          ),
          const SizedBox(height: AppSpacing.lg),
          _FormField(
            label: 'OPERATIONAL SCOPE',
            hint: 'Detail your logistics specifications...',
            controller: _scopeController,
            maxLines: 3,
            onChanged: controller.updateScope,
          ),
          if (state.errorMessage != null) ...<Widget>[
            const SizedBox(height: AppSpacing.md),
            Text(
              state.errorMessage!,
              style: text.bodyMedium?.copyWith(color: Colors.red.shade700),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          MxButton(
            label: state.isSubmitting
                ? 'Initializing...'
                : 'Initialize Consultation',
            expand: true,
            onPressed:
                state.isSubmitting ? null : () => controller.submit(),
          ),
        ],
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.onChanged,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label,
            style: text.labelMedium
                ?.copyWith(color: AppColors.textTertiary, letterSpacing: 1.4),),
        TextField(
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textCapitalization: maxLines > 1
              ? TextCapitalization.sentences
              : TextCapitalization.words,
          style: text.bodyLarge?.copyWith(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                text.bodyMedium?.copyWith(color: AppColors.textTertiary),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.borderLight),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.black, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

class _ServiceVerticalDropdown extends StatelessWidget {
  const _ServiceVerticalDropdown({
    required this.value,
    required this.onChanged,
  });

  final ServiceVertical value;
  final ValueChanged<ServiceVertical> onChanged;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('SERVICE VERTICAL',
            style: text.labelMedium
                ?.copyWith(color: AppColors.textTertiary, letterSpacing: 1.4),),
        const SizedBox(height: 4),
        DropdownButtonFormField<ServiceVertical>(
          initialValue: value,
          isExpanded: true,
          style: text.bodyLarge?.copyWith(color: AppColors.textPrimary),
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.borderLight),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.black, width: 1.5),
            ),
          ),
          items: <DropdownMenuItem<ServiceVertical>>[
            for (final ServiceVertical vertical in ServiceVertical.values)
              DropdownMenuItem<ServiceVertical>(
                value: vertical,
                child: Text(vertical.label),
              ),
          ],
          onChanged: (ServiceVertical? v) {
            if (v != null) onChanged(v);
          },
        ),
      ],
    );
  }
}

class _SuccessPanel extends StatelessWidget {
  const _SuccessPanel({required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.check_circle, color: AppColors.operational, size: 40),
          const SizedBox(height: AppSpacing.md),
          Text('Consultation Initialized', style: text.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Your inquiry has been logged. A logistics architect will respond '
            'to your corporate email within one business day.',
            style: text.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          MxButton(
              label: 'Submit Another', filled: false, onPressed: onReset,),
        ],
      ),
    );
  }
}

class _OfficesSection extends StatelessWidget {
  const _OfficesSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    const List<HubItem> offices = ContentRepository.contactOffices;

    return ColoredBox(
      color: AppColors.offWhite,
      child: ContentContainer(
        vertical: AppSpacing.xxl,
        child: isMobile
            ? Column(
                children: <Widget>[
                  for (final HubItem office in offices)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                      child: _OfficeCard(office: office),
                    ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (int i = 0; i < offices.length; i++) ...<Widget>[
                    Expanded(child: _OfficeCard(office: offices[i])),
                    if (i < offices.length - 1)
                      const SizedBox(width: AppSpacing.xl),
                  ],
                ],
              ),
      ),
    );
  }
}

class _OfficeCard extends StatelessWidget {
  const _OfficeCard({required this.office});

  final HubItem office;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        EyebrowLabel(office.region, color: AppColors.textTertiary),
        const SizedBox(height: AppSpacing.sm),
        Text(office.city, style: text.headlineMedium),
        const SizedBox(height: AppSpacing.sm),
        Text(office.address, style: text.bodyMedium?.copyWith(height: 1.5)),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: <Widget>[
            const Icon(Icons.call_outlined,
                size: 15, color: AppColors.textSecondary,),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Text(office.phone ?? '', style: text.bodyMedium),
            ),
          ],
        ),
      ],
    );
  }
}

class _NetworkMapSection extends StatelessWidget {
  const _NetworkMapSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      color: AppColors.offWhite,
      padding: AppSpacing.pageGutter(width).copyWith(bottom: AppSpacing.xxl),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Container(
            height: 280,
            color: AppColors.charcoal,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(Icons.public,
                    size: 120,
                    color: AppColors.white.withValues(alpha: 0.06),),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md, vertical: AppSpacing.sm,),
                  color: AppColors.black,
                  child: Text(
                    'ACTIVE NODE: SG-01',
                    style: text.labelMedium?.copyWith(
                      color: AppColors.white,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StrategicSupportSection extends StatelessWidget {
  const _StrategicSupportSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool isMobile = AppBreakpoints.isMobile(width);
    final TextTheme text = Theme.of(context).textTheme;

    final Widget intro = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Strategic Support',
            style: text.headlineLarge?.copyWith(color: AppColors.white),),
        const SizedBox(height: AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Text(
            'Our operational desks provide continuous oversight and technical '
            'intervention for complex logistics requirements, ensuring '
            'mission-critical reliability 24/7/365.',
            style: text.bodyMedium
                ?.copyWith(color: AppColors.textOnDarkSecondary),
          ),
        ),
      ],
    );

    final Widget desks = Column(
      children: <Widget>[
        for (final OperationsDeskItem desk in ContentRepository.operationsDesks)
          _DeskRow(desk: desk),
      ],
    );

    return Container(
      color: AppColors.nearBlack,
      padding: AppSpacing.pageGutter(width).copyWith(
        top: AppSpacing.section,
        bottom: AppSpacing.section,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    intro,
                    const SizedBox(height: AppSpacing.xl),
                    desks,
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 4, child: intro),
                    const SizedBox(width: AppSpacing.xl),
                    Expanded(flex: 6, child: desks),
                  ],
                ),
        ),
      ),
    );
  }
}

class _DeskRow extends StatelessWidget {
  const _DeskRow({required this.desk});

  final OperationsDeskItem desk;

  @override
  Widget build(BuildContext context) {
    final TextTheme text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(desk.code,
                  style: text.labelMedium?.copyWith(
                    color: AppColors.textOnDarkTertiary,
                    letterSpacing: 1.4,
                  ),),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Text(
                  desk.title,
                  style: text.headlineMedium?.copyWith(color: AppColors.white),
                ),
              ),
              const Icon(Icons.arrow_forward,
                  size: 18, color: AppColors.accentMuted,),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.borderDark, height: 1),
        ],
      ),
    );
  }
}
