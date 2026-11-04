import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const ecoWalkTeal = Color(0xFF1E6056);
const ecoWalkPrimaryText = Color(0xFF1E1E1E);
const ecoWalkSecondaryText = Color(0xFF757575);

AppBar ecoWalkInfoAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: ecoWalkTeal,
    foregroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () => Navigator.maybePop(context),
    ),
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class EcoWalkLogo extends StatelessWidget {
  const EcoWalkLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'ECOWA',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: ecoWalkTeal,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: SvgPicture.asset(
            'lib/assets/images/runner_green.svg',
            width: 22,
            height: 22,
          ),
        ),
        const Text(
          'K',
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: ecoWalkTeal,
          ),
        ),
      ],
    );
  }
}

class EcoWalkBulletItem extends StatelessWidget {
  const EcoWalkBulletItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 1, right: 8),
            child: Text('•', style: TextStyle(fontSize: 16, height: 1.45)),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: ecoWalkPrimaryText,
                fontSize: 14,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EcoWalkSectionHeading extends StatelessWidget {
  const EcoWalkSectionHeading(this.text, {super.key, this.underlined = false});

  final String text;
  final bool underlined;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: ecoWalkPrimaryText,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          decoration: underlined ? TextDecoration.underline : null,
          height: 1.3,
        ),
      ),
    );
  }
}
