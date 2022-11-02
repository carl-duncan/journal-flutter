import 'package:flutter/material.dart';
import 'package:journal/l10n/l10n.dart';
import 'package:journal/res/widgets/two_tone_text.dart';

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget({super.key, required this.onContinue});
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.theJournalApp,
          style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 28),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                TwoToneText(
                  key: UniqueKey(),
                  firstText: l10n.theMost,
                  secondText: ' ${l10n.secure}',
                  fontSize: 68,
                  thirdText: ' ${l10n.personalJournalApp}.',
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onContinue,
                        child: Text(l10n.continueWord),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    text: '${l10n.byContinuingYouAgreeToOur} ',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: l10n.termsOfService,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                      TextSpan(
                        text: ' ${l10n.and} ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                      ),
                      TextSpan(
                        text: l10n.privacyPolicy,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
