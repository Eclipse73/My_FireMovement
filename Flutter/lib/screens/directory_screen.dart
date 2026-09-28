import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/app_widgets.dart';

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({super.key});
  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  int? _open = 0;
  final _searchCtrl = TextEditingController();

  static const _leaders = [
    ('Pdt. Jonathan Hartono', 'Senior Pastor',     'JH', AppColors.brandDark),
    ('Pdt. Grace Lumban',     'Youth Pastor',      'GL', AppColors.brand),
    ('Min. Alvin Kusuma',     'Worship Leader',    'AK', AppColors.brandMid),
    ('Ev. Samuel Wijaya',     'Cell Coordinator',  'SW', AppColors.flameOrange),
    ('Min. Diana Pratiwi',    'Creative Director', 'DP', AppColors.flameRed),
  ];

  static const _cells = [
    ('Joshua 1',  'Samuel W.', 'Wednesday', '19:00', 'Jl. Sudirman No.12',     6, AppColors.brand),
    ('Caleb 2',   'Diana P.',  'Thursday',  '19:30', 'Jl. Gatot Subroto No.7', 8, AppColors.brandMid),
    ('Esther 3',  'Ryan S.',   'Friday',    '18:30', 'Jl. Thamrin No.55',      5, AppColors.flameOrange),
    ('Deborah 4', 'Maria L.',  'Saturday',  '16:00', 'Jl. Hayam Wuruk No.3',   7, AppColors.flameRed),
  ];

  static const _services = [
    ('Sunday Worship',  '08:00 & 10:30 WIB', 'Main Sanctuary', AppColors.brand),
    ('Youth Night',     'Friday · 19:30 WIB', 'Youth Hall',    AppColors.flameOrange),
    ('Prayer Meeting',  'Tuesday · 06:00 WIB', 'Chapel',       Color(0xFFA06A00)),
  ];

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.bg,
    body: Column(children: [
      _header(),
      _searchBar(),
      Expanded(child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _accordion(0, 'Ministry Leaders', '${_leaders.length} people', _leadersList()),
          const SizedBox(height: 10),
          _accordion(1, 'Cell Groups', '${_cells.length} active groups', _cellList()),
          const SizedBox(height: 10),
          _accordion(2, 'Service Schedule', 'Weekly recurring', _serviceList()),
        ],
      )),
    ]),
  );

  Widget _header() => Container(
    color: Colors.white,
    child: SafeArea(bottom: false, child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('My Fire Movement', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.gray)),
        Text('Ministry Directory', style: GoogleFonts.plusJakartaSans(
            fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.navy)),
      ]),
    )),
  );

  Widget _searchBar() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
      child: Row(children: [
        const Icon(Icons.search_rounded, color: AppColors.gray, size: 18),
        const SizedBox(width: 10),
        Expanded(child: TextField(
          controller: _searchCtrl,
          style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.navy),
          decoration: InputDecoration.collapsed(
            hintText: 'Search leaders, cell groups...',
            hintStyle: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.gray)),
        )),
      ]),
    ),
  );

  Widget _accordion(int idx, String title, String sub, Widget content) {
    final open = _open == idx;
    return AppCard(child: Column(children: [
      GestureDetector(
        onTap: () => setState(() => _open = open ? null : idx),
        behavior: HitTestBehavior.opaque,
        child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: GoogleFonts.plusJakartaSans(
                fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.navy)),
            const SizedBox(height: 2),
            Text(sub, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.gray)),
          ])),
          AnimatedRotation(turns: open ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.gray, size: 22)),
        ])),
      ),
      AnimatedCrossFade(
        firstChild: const SizedBox(width: double.infinity),
        secondChild: Column(children: [
          Divider(color: AppColors.border, height: 1),
          Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 16), child: content),
        ]),
        crossFadeState: open ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200)),
    ]));
  }

  Widget _leadersList() => Column(children: _leaders.map((l) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(children: [
      AppAvatar(initials: l.$3, color: l.$4, size: 42),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(l.$1, style: GoogleFonts.plusJakartaSans(
            fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.navy)),
        Text(l.$2, style: GoogleFonts.plusJakartaSans(
            fontSize: 11, fontWeight: FontWeight.w600, color: l.$4)),
      ])),
      Container(width: 32, height: 32,
        decoration: BoxDecoration(color: AppColors.grayXLight, borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.chevron_right_rounded, color: AppColors.gray, size: 18)),
    ]),
  )).toList());

  Widget _cellList() => Column(children: _cells.map((g) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: AppColors.grayXLight,
      borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 38, height: 38,
          decoration: BoxDecoration(color: g.$7, borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          child: Text('CG', style: GoogleFonts.plusJakartaSans(
              fontSize: 10, fontWeight: FontWeight.w900, color: Colors.white))),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(g.$1, style: GoogleFonts.plusJakartaSans(
              fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.navy)),
          Text('Leader: ${g.$2}',
            style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.gray)),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('${g.$6}', style: GoogleFonts.jetBrainsMono(
              fontSize: 20, fontWeight: FontWeight.w900, color: g.$7)),
          Text('members', style: GoogleFonts.plusJakartaSans(fontSize: 9, color: AppColors.gray)),
        ]),
      ]),
      const SizedBox(height: 10),
      Row(children: [
        const Icon(Icons.schedule_rounded, color: AppColors.gray, size: 13),
        const SizedBox(width: 4),
        Text('${g.$3} · ${g.$4} WIB',
          style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.gray)),
        const SizedBox(width: 12),
        const Icon(Icons.location_on_outlined, color: AppColors.gray, size: 13),
        const SizedBox(width: 4),
        Expanded(child: Text(g.$5,
          style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.gray),
          overflow: TextOverflow.ellipsis)),
      ]),
    ]),
  )).toList());

  Widget _serviceList() => Column(children: _services.map((s) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    decoration: BoxDecoration(color: AppColors.grayXLight,
      borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
    child: Row(children: [
      Container(width: 4, height: 40,
        decoration: BoxDecoration(color: s.$4, borderRadius: BorderRadius.circular(2))),
      const SizedBox(width: 12),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(s.$1, style: GoogleFonts.plusJakartaSans(
            fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.navy)),
        Text(s.$2, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.gray)),
        Row(children: [
          const Icon(Icons.location_on_outlined, color: AppColors.gray, size: 12),
          const SizedBox(width: 2),
          Text(s.$3, style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.gray)),
        ]),
      ]),
    ]),
  )).toList());
}
