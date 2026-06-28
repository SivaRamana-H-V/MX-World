import 'package:mxworld/models/content_models.dart';

/// In-memory content source for the marketing site.
///
/// In production these would come from a CMS or API behind a repository; here
/// they are static so the UI layer has a single, swappable data dependency.
abstract final class ContentRepository {
  const ContentRepository._();

  // Image URLs use Unsplash source links as licensed placeholders that match
  // the logistics theme of the original design comps.
  static const String _port = 'assets/images/port.jpg';
  static const String _warehouse = 'assets/images/warehouse.jpg';
  static const String _terminal = 'assets/images/terminal.jpg';
  static const String _room = 'assets/images/room.jpg';
  static const String airFreightImage = 'assets/images/air_freight.png';
  static const String seaFreightImage = 'assets/images/sea_freight.png';
  static const String importExportImage = 'assets/images/import_export.png';

  static const String expressCargoImage = 'assets/images/express_cargo.png';

  static const String doorToDoorImage = 'assets/images/door_to_door.png';
  static const String heroImage = _terminal;
  static const String aboutHeroImage = _room;

  static const List<StatItem> homeStats = <StatItem>[
    StatItem(value: '12M+', label: 'METRIC TONS SHIPPED YEARLY'),
    StatItem(value: '1,300', label: 'GLOBAL OPERATIONAL SITES'),
    StatItem(value: '99.9%', label: 'TRANSIT RELIABILITY RATE'),
    StatItem(value: '24/7', label: 'LIVE OPERATIONS'),
  ];

  static const List<StatItem> whyChooseUsStats = <StatItem>[
    StatItem(value: '12M+', label: 'ANNUAL TONNAGE'),
    StatItem(value: '1,300', label: 'OPERATIONAL SITES'),
    StatItem(value: '99.9%', label: 'RELIABILITY RATE'),
    StatItem(value: '24/7', label: 'GLOBAL COVERAGE'),
  ];

  static const List<StatItem> aboutStats = <StatItem>[
    StatItem(value: '400K', label: 'WORLDWIDE CUSTOMERS'),
    StatItem(value: '1.3K', label: 'ACTIVE SITES'),
    StatItem(value: '24/7', label: 'LIVE OPERATIONS'),
    StatItem(value: '365', label: 'RELIABILITY INDEX'),
  ];

  static const List<SolutionItem> solutions = <SolutionItem>[
    SolutionItem(label: '4PL INTEGRATED LOGISTICS'),
    SolutionItem(label: 'SUSTAINABLE LOGISTICS'),
    SolutionItem(label: 'COLD CHAIN MANAGEMENT'),
    SolutionItem(label: 'ADVANCED CUSTOMS CLEARANCE'),
  ];

  static const List<ServiceItem> services = <ServiceItem>[
    ServiceItem(
      index: '01',
      category: 'GLOBAL AVIATION',
      title: 'Air Freight',
      description:
          'Precision-timed global logistics for high-value cargo. Our aviation '
          'network provides real-time visibility and industry-leading security '
          'for your urgent assets across continents.',
      imageUrl: airFreightImage,
      actionLabel: 'PRIORITY NETWORK',
    ),
    ServiceItem(
      index: '02',
      category: 'MARITIME SOLUTIONS',
      title: 'Sea Freight',
      description:
          'Economic scale meets global reach. Managing full container loads '
          'with end-to-end supply chain transparency across every major '
          'deep-water port globally.',
      imageUrl: _port,
      actionLabel: 'GLOBAL PORTS',
    ),
    ServiceItem(
      index: '03',
      category: 'CUSTOMS & COMPLIANCE',
      title: 'Import & Export',
      description:
          'Our specialized customs clearance expertise ensures seamless '
          'navigation of international trade regulations through automated '
          'compliance monitoring and HS code optimization.',
      imageUrl: _warehouse,
      actionLabel: 'TRADE COMPLIANCE',
    ),
    ServiceItem(
      index: '04',
      category: 'RAPID TRANSIT',
      title: 'Express Cargo',
      description: 'Time-critical delivery solutions for an accelerated world. '
          'Leveraging real-time transportation visibility to guarantee express '
          'windows across our integrated global network.',
      imageUrl: _terminal,
      actionLabel: 'NEXT DAY DELIVERY',
    ),
    ServiceItem(
      index: '05',
      category: 'LAST MILE INTEGRATION',
      title: 'Door to Door',
      description: 'The final link in the global chain. We provide absolute '
          'door-to-door reliability with white-glove service, fully integrated '
          'with our 4PL management systems.',
      imageUrl: doorToDoorImage,
      actionLabel: 'FULL INTEGRATION',
    ),
  ];

  static const List<HubItem> hubs = <HubItem>[
    HubItem(
      region: 'EUROPE GATEWAY',
      city: 'ROTTERDAM',
      address: 'Wilhelminakade 901\n3072 AP Rotterdam, NL',
      capacity: '14.5M TEU / Annum',
    ),
    HubItem(
      region: 'ASIA-PACIFIC HUB',
      city: 'SINGAPORE',
      address: '7 Keppel Road\nPSA Tanjong Pagar Terminal, SG',
      capacity: '37.2M TEU / Annum',
    ),
    HubItem(
      region: 'AMERICAS ANCHOR',
      city: 'NEW YORK',
      address: '233 Broadway\nManhattan, NY 10279, USA',
      capacity: '9.1M TEU / Annum',
    ),
  ];

  static const List<StatItem> networkStats = <StatItem>[
    StatItem(value: '142', label: 'COUNTRIES'),
    StatItem(value: 'Global', label: 'COVERAGE'),
    StatItem(value: '650+', label: 'NODES'),
    StatItem(value: '12.4M', label: 'METRIC TONS'),
  ];

  static const List<HubItem> contactOffices = <HubItem>[
    HubItem(
      region: 'HEADQUARTERS',
      city: 'COIMBATORE',
      address:
          '141, EB Colony Ponnairajpuram,\nPalaniappa Nagar, Coimbatore-641001',
      capacity: '',
      phone: '+91 83004 47268',
      email: 'lokeshkiran@mxworld.in',
    ),
  ];

  static const List<OperationsDeskItem> operationsDesks = <OperationsDeskItem>[
    OperationsDeskItem(code: 'OPS-01', title: 'GLOBAL OPERATIONS DESK'),
    OperationsDeskItem(code: 'OPS-02', title: 'COMPLIANCE & REGULATORY'),
    OperationsDeskItem(code: 'OPS-03', title: 'CHAIN OPTIMIZATION AUDIT'),
  ];
}
