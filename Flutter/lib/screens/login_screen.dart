import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/app_widgets.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;
  const LoginScreen({super.key, required this.onLogin});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl  = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() { _emailCtrl.dispose(); _passCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _hero(),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Welcome back 👋', style: GoogleFonts.plusJakartaSans(
                    fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.navy)),
                const SizedBox(height: 4),
                Text('Sign in to your MFM account', style: GoogleFonts.plusJakartaSans(
                    fontSize: 13, color: AppColors.gray)),
                const SizedBox(height: 24),
                _fieldLabel('Email Address'),
                const SizedBox(height: 6),
                TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.navy),
                  decoration: const InputDecoration(
                    hintText: 'samuel@gkkdbp.id',
                    prefixIcon: Icon(Icons.email_outlined, size: 18, color: AppColors.gray)),
                ),
                const SizedBox(height: 14),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  _fieldLabel('Password'),
                  TextButton(onPressed: () {},
                    child: Text('Forgot?', style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.brand))),
                ]),
                const SizedBox(height: 6),
                TextField(
                  controller: _passCtrl,
                  obscureText: _obscure,
                  style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.navy),
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    prefixIcon: const Icon(Icons.lock_outline_rounded, size: 18, color: AppColors.gray),
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => _obscure = !_obscure),
                      child: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          size: 18, color: AppColors.gray))),
                ),
                const SizedBox(height: 20),
                BrandButton(label: 'Sign In', onTap: widget.onLogin),
                const SizedBox(height: 20),
                Row(children: [
                  const Expanded(child: Divider(color: AppColors.border)),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or', style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, color: AppColors.gray))),
                  const Expanded(child: Divider(color: AppColors.border)),
                ]),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border)),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('G', style: GoogleFonts.plusJakartaSans(
                          fontSize: 18, fontWeight: FontWeight.w900,
                          color: const Color(0xFF4285F4))),
                      const SizedBox(width: 10),
                      Text('Continue with Google', style: GoogleFonts.plusJakartaSans(
                          fontSize: 14, fontWeight: FontWeight.w700,
                          color: AppColors.navyMid)),
                    ]),
                  ),
                ),
                const SizedBox(height: 20),
                Center(child: RichText(text: TextSpan(
                  style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.gray),
                  children: [
                    const TextSpan(text: 'New member? '),
                    WidgetSpan(child: GestureDetector(
                      onTap: () {},
                      child: Text('Contact your Cell Leader',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 12, fontWeight: FontWeight.w700,
                            color: AppColors.brand)),
                    )),
                  ],
                ))),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _hero() => Container(
    height: 260,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.brandDark, AppColors.brand, AppColors.brandMid],
        begin: Alignment.topLeft, end: Alignment.bottomRight),
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
    ),
    child: Stack(alignment: Alignment.center, children: [
      Positioned(top: 20, child: Container(
        width: 180, height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.gold.withOpacity(0.12)),
      )),
      SafeArea(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          width: 104, height: 104,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
            boxShadow: [BoxShadow(
              color: Colors.black.withOpacity(0.22),
              blurRadius: 24, offset: const Offset(0, 8))]),
          child: Image.asset('assets/Logo_Fire_Movement.png', fit: BoxFit.contain),
        ),
        const SizedBox(height: 16),
        Text('Youth GKKD BP', style: GoogleFonts.plusJakartaSans(
            fontSize: 20, fontWeight: FontWeight.w900,
            color: Colors.white, letterSpacing: -0.3)),
        const SizedBox(height: 2),
        Text('Fire Movement', style: GoogleFonts.plusJakartaSans(
            fontSize: 14, fontWeight: FontWeight.w800,
            color: Colors.white.withOpacity(0.85))),
        const SizedBox(height: 4),
        Text('Church Management System', style: GoogleFonts.plusJakartaSans(
            fontSize: 11, fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.55))),
      ])),
    ]),
  );

  Widget _fieldLabel(String text) => Text(text, style: GoogleFonts.plusJakartaSans(
      fontSize: 11, fontWeight: FontWeight.w700,
      color: AppColors.navyMid, letterSpacing: 0.6));
}
