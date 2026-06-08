import 'package:flutter/widgets.dart';

/// A single statistic shown in metric strips (e.g. "12M+ / Metric tons").
@immutable
class StatItem {
  const StatItem({required this.value, required this.label});

  final String value;
  final String label;
}

/// A portfolio showcase card on the home screen.
@immutable
class PortfolioItem {
  const PortfolioItem({
    required this.tag,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.isLarge = false,
  });

  final String tag;
  final String title;
  final String description;
  final String imageUrl;
  final bool isLarge;
}

/// A full-bleed service entry on the services screen.
@immutable
class ServiceItem {
  const ServiceItem({
    required this.index,
    required this.category,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.actionLabel,
  });

  final String index;
  final String category;
  final String title;
  final String description;
  final String imageUrl;
  final String actionLabel;
}

/// A strategic hub / office location.
@immutable
class HubItem {
  const HubItem({
    required this.region,
    required this.city,
    required this.address,
    required this.capacity,
    this.phone,
  });

  final String region;
  final String city;
  final String address;
  final String capacity;
  final String? phone;
}

/// A value-driven solution bullet on the about screen.
@immutable
class SolutionItem {
  const SolutionItem({required this.label});
  final String label;
}

/// A strategic-support operations row on the contact screen.
@immutable
class OperationsDeskItem {
  const OperationsDeskItem({
    required this.code,
    required this.title,
  });

  final String code;
  final String title;
}

/// Service verticals offered in the contact inquiry dropdown.
enum ServiceVertical {
  airFreight('Air Freight Solutions'),
  seaFreight('Sea Freight Solutions'),
  roadTransport('Road Transport'),
  fourPl('4PL Integrated Logistics'),
  warehousing('Warehousing & Fulfilment');

  const ServiceVertical(this.label);
  final String label;
}

/// Immutable value object capturing a project inquiry submission.
///
/// Persisted locally via Hive so a draft survives app restarts and submitted
/// inquiries can be reviewed offline.
@immutable
class ProjectInquiry {
  const ProjectInquiry({
    required this.clientName,
    required this.corporateEmail,
    required this.serviceVertical,
    required this.operationalScope,
    required this.submittedAt,
  });

  final String clientName;
  final String corporateEmail;
  final ServiceVertical serviceVertical;
  final String operationalScope;
  final DateTime submittedAt;

  ProjectInquiry copyWith({
    String? clientName,
    String? corporateEmail,
    ServiceVertical? serviceVertical,
    String? operationalScope,
    DateTime? submittedAt,
  }) {
    return ProjectInquiry(
      clientName: clientName ?? this.clientName,
      corporateEmail: corporateEmail ?? this.corporateEmail,
      serviceVertical: serviceVertical ?? this.serviceVertical,
      operationalScope: operationalScope ?? this.operationalScope,
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }

  /// Serializes to a primitive map for Hive storage.
  Map<String, dynamic> toMap() => <String, dynamic>{
        'clientName': clientName,
        'corporateEmail': corporateEmail,
        'serviceVertical': serviceVertical.name,
        'operationalScope': operationalScope,
        'submittedAt': submittedAt.toIso8601String(),
      };

  /// Reconstructs an inquiry from a stored Hive map.
  factory ProjectInquiry.fromMap(Map<dynamic, dynamic> map) {
    return ProjectInquiry(
      clientName: map['clientName'] as String? ?? '',
      corporateEmail: map['corporateEmail'] as String? ?? '',
      serviceVertical: ServiceVertical.values.firstWhere(
        (ServiceVertical v) => v.name == map['serviceVertical'],
        orElse: () => ServiceVertical.airFreight,
      ),
      operationalScope: map['operationalScope'] as String? ?? '',
      submittedAt:
          DateTime.tryParse(map['submittedAt'] as String? ?? '') ??
              DateTime.now(),
    );
  }
}
