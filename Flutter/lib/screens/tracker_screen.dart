import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../theme.dart';
import '../widgets/app_widgets.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});
  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  int _tab = 0;
  DateTime _date = DateTime(2026, 9, 3);
  late Map<int, bool> _attendance;
  late Map<int, bool> _bdk;

  static const _members = [
    ('Andreas Lim',    'AL', AppColors.brand),
    ('Bunga Cahyani',  'BC', AppColors.brandMid),
    ('Calvin Tanoto',  'CT', AppColors.flameOrange),
    ('Desi Paramitha', 'DP', AppColors.flameRed),
    ('Eric Sunandar',  'ES', Color(0xFFA06A00)),
    ('Fiona Hartati',  'FH', AppColors.brandDark),
  ];

  static const _modules = [
    ('BDK-1', 'Pengenalan Keselamatan', 'Salvation Basics'),
    ('BDK-2', 'Hidup Baru dalam Kristus', 'New Life in Christ'),
    ('BDK-3', 'Doa dan Firman', 'Prayer & Scripture'),
    ('BDK-4', 'Roh Kudus', 'The Holy Spirit'),
    ('BDK-5', 'Gereja & Persekutuan', 'Church & Fellowship'),
  ];

  @override
  void initState() {
    super.initState();
    _attendance = {0: true, 2: true, 4: true};
    _bdk = {0: true, 1: true};
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.bg,
    body: Column(children: [
      _header(),
      _summaryCard(),
      const SizedBox(height: 10),
      _datePicker(),
      const SizedBox(height: 10),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DualTabBar(
          selected: _tab,
          labels: const ['Attendance', 'BDK Progress'],
          onChanged: (i) => setState(() => _tab = i))),
      const SizedBox(height: 10),
      Expanded(child: _tab == 0 ? _attendanceList() : _bdkList()),
    ]),
  );

  Widget _header() => Container(
    color: Colors.white,
    child: SafeArea(bottom: false, child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Cell Group Leader', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.gray)),
        Text('Discipleship Tracker', style: GoogleFonts.plusJakartaSans(
            fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.navy)),
      ]),
    )),
  );

  Widget _summaryCard() => Container(
    margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.border)),
    child: Row(children: [
      Container(width: 48, height: 48,
        decoration: BoxDecoration(color: AppColors.brandLight, borderRadius: BorderRadius.circular(14)),
        alignment: Alignment.center,
        child: const Text('🔥', style: TextStyle(fontSize: 24))),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Cell Group — Joshua 1', style: GoogleFonts.plusJakartaSans(
            fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.navy)),
        Text('Ev. Samuel Wijaya · 6 Members',
          style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.gray)),
      ])),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text('${_attendance.values.where((v) => v).length}/${_members.length}',
          style: GoogleFonts.jetBrainsMono(
              fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.brand)),
        Text('Present', style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.gray)),
      ]),
    ]),
  );

  Widget _datePicker() => GestureDetector(
    onTap: () async {
      final picked = await showDatePicker(
        context: context,
        initialDate: _date, firstDate: DateTime(2025), lastDate: DateTime(2030),
        builder: (ctx, child) => Theme(
          data: Theme.of(ctx).copyWith(colorScheme: const ColorScheme.light(
            primary: AppColors.brand, onPrimary: Colors.white,
            surface: Colors.white, onSurface: AppColors.navy)),
          child: child!));
      if (picked != null) setState(() => _date = picked);
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
      child: Row(children: [
        const Icon(Icons.calendar_month_rounded, color: AppColors.brand, size: 18),
        const SizedBox(width: 10),
        Text(DateFormat('EEEE, d MMMM yyyy').format(_date),
          style: GoogleFonts.jetBrainsMono(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.navy)),
        const Spacer(),
        const Icon(Icons.arrow_drop_down_rounded, color: AppColors.gray),
      ]),
    ),
  );

  Widget _attendanceList() => ListView(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    children: [
      ..._members.asMap().entries.map((e) {
        final i = e.key; final m = e.value;
        final present = _attendance[i] ?? false;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: present ? AppColors.brand.withOpacity(0.25) : AppColors.border)),
          child: Row(children: [
            AppAvatar(initials: m.$2, color: m.$3, size: 40),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(m.$1, style: GoogleFonts.plusJakartaSans(
                  fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.navy)),
              Text('Cell Member', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.gray)),
            ])),
            Text(present ? 'HADIR' : 'ABSEN',
              style: GoogleFonts.jetBrainsMono(fontSize: 10, fontWeight: FontWeight.w700,
                  color: present ? AppColors.green : AppColors.gray)),
            const SizedBox(width: 8),
            AppToggle(value: present,
              onChanged: (v) => setState(() => _attendance = {..._attendance, i: v})),
          ]),
        );
      }),
      const SizedBox(height: 14),
      BrandButton(label: 'Save Report', onTap: () =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Attendance saved!',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
          backgroundColor: AppColors.brand,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          behavior: SnackBarBehavior.floating))),
      const SizedBox(height: 16),
    ],
  );

  Widget _bdkList() => ListView(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: AppColors.brandLight,
          borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.grayLight)),
        child: Row(children: [
          const Text('📋', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(child: Text('Track BDK completion for your cell group members',
            style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.brand, fontWeight: FontWeight.w700))),
        ])),
      ..._modules.asMap().entries.map((e) {
        final i = e.key; final m = e.value;
        final done = _bdk[i] ?? false;
        return GestureDetector(
          onTap: () => setState(() => _bdk = {..._bdk, i: !done}),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: done ? AppColors.brand.withOpacity(0.25) : AppColors.border)),
            child: Row(children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 22, height: 22,
                decoration: BoxDecoration(
                  color: done ? AppColors.brand : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: done ? AppColors.brand : AppColors.grayLight, width: 1.5)),
                child: done ? const Icon(Icons.check_rounded, color: Colors.white, size: 14) : null),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  PillBadge(label: m.$1, color: AppColors.brand, bg: AppColors.brandLight),
                  const SizedBox(width: 8),
                  Expanded(child: Text(m.$2, style: GoogleFonts.plusJakartaSans(
                      fontSize: 13, fontWeight: FontWeight.w800,
                      color: done ? AppColors.gray : AppColors.navy,
                      decoration: done ? TextDecoration.lineThrough : TextDecoration.none))),
                ]),
                const SizedBox(height: 3),
                Text(m.$3, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.gray)),
              ])),
              if (done) const Text('⭐', style: TextStyle(fontSize: 16)),
            ]),
          ),
        );
      }),
      const SizedBox(height: 14),
      BrandButton(label: 'Save BDK Progress', onTap: () =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('BDK progress saved!',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
          backgroundColor: AppColors.brand,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          behavior: SnackBarBehavior.floating))),
      const SizedBox(height: 16),
    ],
  );
}
