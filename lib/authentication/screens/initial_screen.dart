import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:twitter_clone/authentication/screens/create_account_screen.dart';
import 'package:twitter_clone/authentication/widgets/authentication_button.dart';
import 'package:twitter_clone/common/widgets/twitter_app_bar.dart';
import 'package:twitter_clone/settings/constants/sizes.dart';
import 'package:twitter_clone/settings/constants/texts.dart';
import 'package:twitter_clone/utils.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  void _onCreateAccountTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateAccountScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: TwitterAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: authenticationHorizontalPadding,
            vertical: authenticationVerticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(128),
              Text(
                welcomeText,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const Gap(128),
              AuthenticationButton(
                icon: FontAwesomeIcons.google,
                text: continueWithGoogle,
                borderColor: isDarkMode ? Colors.white : Colors.black12,
                boxColor: isDarkMode ? Colors.black : Colors.white,
                textColor: isDarkMode ? Colors.white : Colors.black,
                onTap: null,
              ),
              const Gap(12),
              AuthenticationButton(
                icon: FontAwesomeIcons.apple,
                text: continueWithApple,
                borderColor: isDarkMode ? Colors.white : Colors.black12,
                boxColor: isDarkMode ? Colors.black : Colors.white,
                textColor: isDarkMode ? Colors.white : Colors.black,
                onTap: null,
              ),
              const Gap(12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Expanded(
                    child: Divider(
                      endIndent: 12,
                    ),
                  ),
                  Text(
                    "or",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Expanded(
                    child: Divider(
                      indent: 12,
                    ),
                  ),
                ],
              ),
              const Gap(12),
              AuthenticationButton(
                icon: null,
                text: createAccount,
                borderColor: isDarkMode ? Colors.black12 : Colors.black,
                boxColor: isDarkMode ? Colors.white : Colors.black,
                textColor: isDarkMode ? Colors.black : Colors.white,
                onTap: _onCreateAccountTap,
              ),
              const Gap(32),
              RichText(
                text: TextSpan(
                  text: "By signing up, you agree to our ",
                  style: Theme.of(context).textTheme.labelLarge,
                  children: [
                    getTextSpanLink(
                      context: context,
                      text: terms,
                      link: "",
                    ),
                    const TextSpan(text: ", "),
                    getTextSpanLink(
                      context: context,
                      text: privacyPolicy,
                      link: "",
                    ),
                    const TextSpan(text: ", and "),
                    getTextSpanLink(
                      context: context,
                      text: cookieUse,
                      link: "",
                    ),
                    const TextSpan(text: ".")
                  ],
                ),
              ),
              const Gap(64),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.labelMedium,
                  text: "Have an account already? ",
                  children: [
                    getTextSpanLink(
                      context: context,
                      text: logIn,
                      link: "",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
