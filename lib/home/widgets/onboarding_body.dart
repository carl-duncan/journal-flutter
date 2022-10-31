import 'package:flutter/material.dart';
import 'package:journal/res/spacers.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({
    super.key,
    required this.onContinue,
    required this.onClose,
  });

  final void Function(String value) onContinue;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacers.hPagePadding,
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: onClose,
                      child: const Icon(
                        Icons.logout,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                TextField(
                  // center the hint
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Enter your key',
                  ),
                  onSubmitted: onContinue,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
