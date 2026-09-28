import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/app_widgets.dart';

class InfoScreen extends StatefulWidget {
  final VoidCallback onLogout;
  const InfoScreen({super.key, required this.onLogout});
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  bool _push = true, _bday = true, _event = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.bg,
    body: Column(children: [
      _header(),
      Expanded(child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _churchHero(),
          const SizedBox(height: 14),
          _contactCard(),
          const SizedBox(height: 14),
          _offeringCard(),
          const SizedBox(height: 14),
          _notifCard(),
          const SizedBox(height: 14),
          _appInfoCard(),
          const SizedBox(height: 14),
          _signOutButton(),
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
        Text('Church Info', style: GoogleFonts.plusJakartaSans(
            fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.navy)),
      ]),
    )),
  );

  Widget _churchHero() => ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: SizedBox(height: 140, child: Stack(fit: StackFit.expand, children: [
      Image.network(
        'https://images.unsplash.com/photo-1778911033724-77e1397a1b87?w=800&h=400&fit=crop',
        fit: BoxFit.cover,
        loadingBuilder: (_, child, p) =>
          p == null ? child : Container(color: AppColors.grayLight)),
      Container(decoration: const BoxDecoration(gradient: LinearGradient(
        begin: Alignment.bottomCenter, end: Alignment.topCenter,
        colors: [Color(0xDD1A1230), Color(0x661A1230), Colors.transparent],
        stops: [0.0, 0.5, 1.0]))),
      Positioned(bottom: 14, left: 16, right: 16,
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Gereja Kristen Kemah Daud', style: GoogleFonts.plusJakartaSans(
                fontSize: 15, fontWeight: FontWeight.w900, color: Colors.white)),
            Text('GKKD My Fire Movement · Est. 2018',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 11, color: Colors.white.withOpacity(0.7))),
          ])),
          Container(width: 40, height: 40, padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Image.asset('assets/Logo_Fire_Movement.png', fit: BoxFit.contain)),
        ])),
    ])),
  );

  Widget _contactCard() {
    const contacts = [
      (Icons.chat_rounded,          'WhatsApp Admin', '+62 812-3456-7890',           Color(0xFF25D366), 'Chat'),
      (Icons.email_outlined,        'Email',          'admin@gkkdbp.id',             AppColors.brand,   'Mail'),
      (Icons.photo_camera_outlined, 'Instagram',      '@myfiremovement',             Color(0xFFE1306C), 'Follow'),
      (Icons.location_on_outlined,  'Address',        'Jl. Kebon Jeruk No.12, Jakarta Barat', AppColors.flameOrange, 'Maps'),
    ];
    return AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Text('Official Contacts', style: GoogleFonts.plusJakartaSans(
            fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.navy))),
      Divider(color: AppColors.border, height: 12),
      ...contacts.map((c) => Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Row(children: [
            Container(width: 38, height: 38,
              decoration: BoxDecoration(color: c.$4.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(c.$1, color: c.$4, size: 18)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(c.$2, style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.gray)),
              Text(c.$3, style: GoogleFonts.plusJakartaSans(
                  fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.navy),
                overflow: TextOverflow.ellipsis),
            ])),
            GestureDetector(
              onTap: () => HapticFeedback.lightImpact(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: AppColors.brandLight, borderRadius: BorderRadius.circular(8)),
                child: Text(c.$5, style: GoogleFonts.plusJakartaSans(
                    fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.brand)))),
          ])),
        if (c != contacts.last)
          Divider(color: AppColors.border, height: 1, indent: 16, endIndent: 16),
      ])),
    ]));
  }

  Widget _offeringCard() => AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Text('Offering & Tithing', style: GoogleFonts.plusJakartaSans(
          fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.navy))),
    Divider(color: AppColors.border, height: 1),
    Padding(padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      child: Row(children: [
        Expanded(child: _bankTile('BCA', '1234567890')),
        const SizedBox(width: 10),
        Expanded(child: _bankTile('Mandiri', '9876543210')),
      ])),
    Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBE6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withOpacity(0.6), width: 1.5)),
      child: Column(children: [
        const PillBadge(label: 'QRIS · Scan & Pay', color: Color(0xFFA06A00), bg: Color(0xFFFFF3CD)),
        const SizedBox(height: 14),
        Container(
          width: 140, height: 140,
          decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
          child: Stack(alignment: Alignment.center, children: [
            CustomPaint(size: const Size(120, 120), painter: _QRPainter()),
            Container(width: 34, height: 34, padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
              child: Image.asset('assets/Logo_Fire_Movement.png', fit: BoxFit.contain)),
          ])),
        const SizedBox(height: 10),
        Text('Scan with any e-wallet or mobile banking',
          style: GoogleFonts.plusJakartaSans(fontSize: 10, color: AppColors.gray),
          textAlign: TextAlign.center),
      ])),
  ]));

  Widget _bankTile(String bank, String acc) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: AppColors.grayXLight,
      borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('a.n GKKD MFM', style: GoogleFonts.jetBrainsMono(
          fontSize: 9, color: AppColors.gray, letterSpacing: 0.3)),
      const SizedBox(height: 4),
      Text(bank, style: GoogleFonts.plusJakartaSans(
          fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.navy)),
      Text(acc, style: GoogleFonts.jetBrainsMono(
          fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.brand)),
    ]),
  );

  Widget _notifCard() => AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Text('Notification Settings', style: GoogleFonts.plusJakartaSans(
          fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.navy))),
    Divider(color: AppColors.border, height: 1),
    _notifRow('Push Notifications', 'Receive all app notifications', _push,
        (v) => setState(() => _push = v)),
    Divider(color: AppColors.border, height: 1, indent: 16, endIndent: 16),
    _notifRow('Birthday Reminders', 'Get notified on member birthdays', _bday,
        (v) => setState(() => _bday = v)),
    Divider(color: AppColors.border, height: 1, indent: 16, endIndent: 16),
    _notifRow('Event Reminders', '1-day reminder before events', _event,
        (v) => setState(() => _event = v)),
  ]));

  Widget _notifRow(String title, String sub, bool value, ValueChanged<bool> onChange) =>
    Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: GoogleFonts.plusJakartaSans(
              fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.navy)),
          const SizedBox(height: 2),
          Text(sub, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.gray)),
        ])),
        AppToggle(value: value, onChanged: onChange),
      ]));

  Widget _appInfoCard() => AppCard(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('App Version', style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.gray)),
      Text('v1.2.0', style: GoogleFonts.jetBrainsMono(
          fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.navyMid)),
    ]));

  Widget _signOutButton() => GestureDetector(
    onTap: () => showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Sign Out?', style: GoogleFonts.plusJakartaSans(
          fontSize: 17, fontWeight: FontWeight.w900, color: AppColors.navy)),
      content: Text('You will be returned to the login screen.',
        style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.gray)),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel', style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w700, color: AppColors.gray))),
        TextButton(
          onPressed: () { Navigator.of(context).pop(); widget.onLogout(); },
          child: Text('Sign Out', style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w800, color: AppColors.red))),
      ],
    )),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.red.withOpacity(0.3))),
      alignment: Alignment.center,
      child: Text('Sign Out', style: GoogleFonts.plusJakartaSans(
          fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.red))),
  );
}

class _QRPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.navy;
    final c = size.width / 10;
    void r(double x, double y, double w, double h) => canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(x*c, y*c, w*c, h*c), const Radius.circular(1)), paint);

    r(0,0,3,3); paint.color=Colors.white; r(.3,.3,2.4,2.4);
    paint.color=AppColors.navy; r(.7,.7,1.6,1.6);
    r(7,0,3,3); paint.color=Colors.white; r(7.3,.3,2.4,2.4);
    paint.color=AppColors.navy; r(7.7,.7,1.6,1.6);
    r(0,7,3,3); paint.color=Colors.white; r(.3,7.3,2.4,2.4);
    paint.color=AppColors.navy; r(.7,7.7,1.6,1.6);

    for (final m in [[4,0],[5,0],[4,1],[6,1],[4,2],[5,2],[3,4],[5,4],[7,4],[9,4],
      [3,5],[4,5],[6,5],[4,7],[6,7],[8,7],[3,8],[5,8],[7,8],[9,0],[9,1],[9,2],[4,9],[5,9],[8,9],[9,9]]) {
      r(m[0].toDouble(), m[1].toDouble(), .85, .85);
    }
  }
  @override bool shouldRepaint(covariant CustomPainter _) => false;
}
