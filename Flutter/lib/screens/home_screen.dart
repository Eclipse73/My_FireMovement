import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/app_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bannerIdx = 0;
  final _pageCtrl = PageController();

  static const _banners = [
    ('https://images.unsplash.com/photo-1770097043369-4ee5a231ecc0?w=800&h=400&fit=crop', 'UPCOMING EVENT', 'Youth Night 2026', 'Sat, Sep 20 · GKKD Main Hall'),
    ('https://images.unsplash.com/photo-1583472032780-5654e59e060a?w=800&h=400&fit=crop', 'DEVOTIONAL', 'Encounter God This Week', 'Daily reading challenge starts Monday'),
    ('https://images.unsplash.com/photo-1769755411779-e4c43e7b7742?w=800&h=400&fit=crop', 'ANNOUNCEMENT', 'New BDK Materials Out!', 'Download BDK Seri 3 now'),
  ];

  @override
  void dispose() { _pageCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.bg,
    body: Column(children: [
      _topBar(),
      _birthdayBanner(),
      Expanded(child: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          _carousel(),
          const SizedBox(height: 18),
          _quickLinks(),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Daily Devotional', action: 'Read More'),
          _devotionalCard(),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Church News', action: 'See All'),
          _newsFeed(),
          const SizedBox(height: 20),
          const SectionHeader(title: 'Upcoming Events', action: 'Calendar'),
          _eventList(),
        ],
      )),
    ]),
  );

  Widget _topBar() => Container(
    color: Colors.white,
    child: SafeArea(bottom: false, child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Good morning,', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.gray)),
          Text('Samuel Wijaya 👋', style: GoogleFonts.plusJakartaSans(
              fontSize: 17, fontWeight: FontWeight.w900, color: AppColors.navy)),
        ])),
        Stack(children: [
          Container(
            width: 38, height: 38,
            decoration: BoxDecoration(color: AppColors.grayXLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border)),
            child: const Icon(Icons.notifications_outlined, size: 18, color: AppColors.navyMid),
          ),
          Positioned(top: 6, right: 6, child: Container(
            width: 8, height: 8,
            decoration: BoxDecoration(color: AppColors.brand, shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5)),
          )),
        ]),
        const SizedBox(width: 8),
        const AppAvatar(initials: 'SW', color: AppColors.brand, size: 38),
      ]),
    )),
  );

  Widget _birthdayBanner() => Container(
    margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFFF5EEFF), AppColors.brandLight]),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.grayLight)),
    child: Row(children: [
      const Text('🎂', style: TextStyle(fontSize: 22)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Birthday Today!', style: GoogleFonts.plusJakartaSans(
            fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.brandMid)),
        Text('Rizky Pratama & Alicia Chen 🎉', style: GoogleFonts.plusJakartaSans(
            fontSize: 11, color: AppColors.navyMid)),
      ])),
      const Icon(Icons.chevron_right_rounded, color: AppColors.brand, size: 18),
    ]),
  );

  Widget _carousel() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
    child: Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(height: 176,
          child: PageView.builder(
            controller: _pageCtrl,
            onPageChanged: (i) => setState(() => _bannerIdx = i),
            itemCount: _banners.length,
            itemBuilder: (_, i) {
              final b = _banners[i];
              return Stack(fit: StackFit.expand, children: [
                Image.network(b.$1, fit: BoxFit.cover,
                  loadingBuilder: (_, child, p) =>
                    p == null ? child : Container(color: AppColors.grayLight)),
                Container(decoration: const BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.bottomCenter, end: Alignment.topCenter,
                  colors: [Color(0xCC000000), Colors.transparent], stops: [0, 0.6]))),
                Positioned(bottom: 14, left: 16, right: 16, child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, children: [
                    PillBadge(label: b.$2, color: Colors.white, bg: Colors.white.withOpacity(0.25)),
                    const SizedBox(height: 4),
                    Text(b.$3, style: GoogleFonts.plusJakartaSans(
                        fontSize: 15, fontWeight: FontWeight.w900, color: Colors.white)),
                    Text(b.$4, style: GoogleFonts.plusJakartaSans(
                        fontSize: 11, color: Colors.white.withOpacity(0.75))),
                  ])),
              ]);
            },
          )),
      ),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_banners.length, (i) => GestureDetector(
          onTap: () => _pageCtrl.animateToPage(i,
              duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == _bannerIdx ? 20 : 6, height: 6,
            decoration: BoxDecoration(
              color: i == _bannerIdx ? AppColors.brand : AppColors.grayLight,
              borderRadius: BorderRadius.circular(3)),
          ),
        ))),
    ]),
  );

  Widget _quickLinks() {
    const links = [
      ('📖', 'Devotional', AppColors.brandLight),
      ('🙏', 'Giving',     Color(0xFFEBFFF3)),
      ('📅', 'Events',     Color(0xFFFFFBE6)),
      ('🎧', 'Sermons',    Color(0xFFFFF0EB)),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: links.map((l) => Expanded(child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
        child: Column(children: [
          Container(width: 44, height: 44,
            decoration: BoxDecoration(color: l.$3, borderRadius: BorderRadius.circular(14)),
            alignment: Alignment.center,
            child: Text(l.$1, style: const TextStyle(fontSize: 20))),
          const SizedBox(height: 8),
          Text(l.$2, textAlign: TextAlign.center, style: GoogleFonts.plusJakartaSans(
              fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.navyMid)),
        ]),
      ))).toList()),
    );
  }

  Widget _devotionalCard() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        child: Stack(children: [
          SizedBox(height: 100, child: Image.network(
            'https://images.unsplash.com/photo-1497621122273-f5cfb6065c56?w=400&h=200&fit=crop',
            fit: BoxFit.cover, width: double.infinity)),
          Container(height: 100, decoration: const BoxDecoration(gradient: LinearGradient(
            colors: [Color(0xDE6B2C8A), Color(0x8DD92F1A)],
            begin: Alignment.centerLeft, end: Alignment.centerRight))),
          Positioned(bottom: 12, left: 16, right: 16, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Sep 3, 2026 · Joshua 1:9', style: GoogleFonts.plusJakartaSans(
                  fontSize: 9, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w700)),
              Text('"Be strong and courageous."', style: GoogleFonts.plusJakartaSans(
                  fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white)),
            ])),
        ]),
      ),
      Padding(padding: const EdgeInsets.all(16), child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Have I not commanded you? Be strong and courageous. Do not be afraid; do not be discouraged, for the Lord your God will be with you wherever you go.',
            style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.navyMid, height: 1.6)),
          const SizedBox(height: 10),
          Text('Read Full Devotional →', style: GoogleFonts.plusJakartaSans(
              fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.brand)),
        ])),
    ])),
  );

  Widget _newsFeed() {
    const news = [
      ('🔥', 'Youth Night Registration Open!', 'Register before Sep 15 to secure your spot.', '2h ago'),
      ('📚', 'BDK Seri 3 Now Available', 'New discipleship material released for all CG leaders.', '1d ago'),
      ('🤝', 'Sunday Volunteer Sign-up', 'We need ushers and tech team for Sep 7 service.', '2d ago'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: news.map((n) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 42, height: 42,
            decoration: BoxDecoration(color: AppColors.grayXLight, borderRadius: BorderRadius.circular(12)),
            alignment: Alignment.center,
            child: Text(n.$1, style: const TextStyle(fontSize: 20))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(n.$2, style: GoogleFonts.plusJakartaSans(
                fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.navy)),
            const SizedBox(height: 3),
            Text(n.$3, style: GoogleFonts.plusJakartaSans(
                fontSize: 11, color: AppColors.gray, height: 1.4)),
          ])),
          const SizedBox(width: 8),
          Text(n.$4, style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.gray)),
        ]),
      )).toList()),
    );
  }

  Widget _eventList() {
    const events = [
      ('Youth Sunday Service', 'Sun, Sep 7',  'Worship',    AppColors.brand,       AppColors.brandLight),
      ('Cell Group · Joshua 1','Wed, Sep 10', 'Cell Group', AppColors.flameOrange, Color(0xFFFFF0EB)),
      ('Youth Conference 2026','Sat, Sep 20', 'Event',      Color(0xFFB8860B),     Color(0xFFFFFBE6)),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: events.map((ev) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
        child: Row(children: [
          Container(width: 42, height: 42,
            decoration: BoxDecoration(color: AppColors.brandLight, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.calendar_month_rounded, color: AppColors.brand, size: 20)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(ev.$1, style: GoogleFonts.plusJakartaSans(
                fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.navy)),
            Text(ev.$2, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.gray)),
          ])),
          PillBadge(label: ev.$3, color: ev.$4, bg: ev.$5),
        ]),
      )).toList()),
    );
  }
}
