import '../models/content_models.dart';

/// In-memory content source for the marketing site.
///
/// In production these would come from a CMS or API behind a repository; here
/// they are static so the UI layer has a single, swappable data dependency.
abstract final class ContentRepository {
  const ContentRepository._();

  // Image URLs use Unsplash source links as licensed placeholders that match
  // the logistics theme of the original design comps.
  static const String _port =
      'https://images.unsplash.com/photo-1494412574643-ff11b0a5c1c3?w=1200&q=80';
  static const String _warehouse =
      'https://images.unsplash.com/photo-1553413077-190dd305871c?w=1200&q=80';
  static const String _airCargo =
      'https://images.unsplash.com/photo-1583500178690-f7fd39d8a4f7?w=1200&q=80';
  static const String _containerShip =
      'https://images.unsplash.com/photo-1605281317010-fe5ffe798166?w=1200&q=80';
  static const String _terminal =
      'https://images.unsplash.com/photo-1578575437130-527eed3abbec?w=1200&q=80';
  static const String _crane =
      'https://images.unsplash.com/photo-1571086291540-b137f3e2a9f1?w=1200&q=80';

  static const String heroImage = _terminal;

  static const List<PortfolioItem> portfolio = <PortfolioItem>[
    PortfolioItem(
      tag: 'HUB EXPANSION',
      title: 'SHANGHAI HUB EXPANSION',
      description:
          'Strategic terminal expansion increasing throughput capacity by 40% '
          'with automated sorting and real-time cargo tracking systems.',
      imageUrl: _port,
      isLarge: true,
    ),
    PortfolioItem(
      tag: 'LOGISTICS CARE',
      title: 'EURA-LOGIC CARE',
      description: 'Precision cold-chain logistics for pharmaceutical networks.',
      imageUrl: _warehouse,
    ),
    PortfolioItem(
      tag: 'AVIATION FLEET',
      title: 'RAPID AIR FLEET',
      description: 'Time-critical air freight solutions with dedicated cargo '
          'aircraft operating across intercontinental routes.',
      imageUrl: _airCargo,
      isLarge: true,
    ),
    PortfolioItem(
      tag: 'OCEAN FREIGHT',
      title: "INT'L OCEAN FREIGHT",
      description: 'End-to-end container shipping with real-time vessel '
          'tracking and automated documentation handling.',
      imageUrl: _containerShip,
    ),
  ];

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
      imageUrl: _airCargo,
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
      description:
          'Time-critical delivery solutions for an accelerated world. '
          'Leveraging real-time transportation visibility to guarantee express '
          'windows across our integrated global network.',
      imageUrl: _terminal,
      actionLabel: 'NEXT DAY DELIVERY',
    ),
    ServiceItem(
      index: '05',
      category: 'LAST MILE INTEGRATION',
      title: 'Door to Door',
      description:
          'The final link in the global chain. We provide absolute '
          'door-to-door reliability with white-glove service, fully integrated '
          'with our 4PL management systems.',
      imageUrl: _crane,
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
      region: 'EMEA HEADQUARTERS',
      city: 'Rotterdam',
      address: 'Prinses Beatrixlaan 5\n2595 AK Den Haag, Netherlands',
      capacity: '',
      phone: '+31 (0) 70 344 0000',
    ),
    HubItem(
      region: 'APAC COMMAND CENTER',
      city: 'Singapore',
      address: '78 Shenton Way, Tower 1\nSingapore 079120',
      capacity: '',
      phone: '+65 6220 1234',
    ),
    HubItem(
      region: 'AMERICAS REGIONAL HUB',
      city: 'New York',
      address: '150 Greenwich St, 4 World Trade Center\nNew York, NY 10007, USA',
      capacity: '',
      phone: '+1 212 555 0198',
    ),
  ];

  static const List<OperationsDeskItem> operationsDesks =
      <OperationsDeskItem>[
    OperationsDeskItem(code: 'OPS-01', title: 'GLOBAL OPERATIONS DESK'),
    OperationsDeskItem(code: 'OPS-02', title: 'COMPLIANCE & REGULATORY'),
    OperationsDeskItem(code: 'OPS-03', title: 'CHAIN OPTIMIZATION AUDIT'),
  ];
}
