import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:twitter_clone/authentication/screens/confirmation_code_screen.dart';
import 'package:twitter_clone/authentication/widgets/authentication_button.dart';
import 'package:twitter_clone/common/widgets/twitter_app_bar.dart';
import 'package:twitter_clone/settings/constants/sizes.dart';
import 'package:twitter_clone/settings/constants/texts.dart';
import 'package:twitter_clone/utils.dart';

class CustomizeExperienceScreen extends StatefulWidget {
  const CustomizeExperienceScreen({super.key});

  @override
  State<CustomizeExperienceScreen> createState() =>
      _CustomizeExperienceScreenState();
}

class _CustomizeExperienceScreenState extends State<CustomizeExperienceScreen> {
  bool _switchValue = false;

  void _onChanged(bool? value) {
    setState(() {
      _switchValue = value ?? false;
    });
  }

  void _onNextTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ConfirmationCodeScreen(),
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: authenticationHorizontalPadding,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customize your experience",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(28),
                      Text(
                        "Track where you see Twitter content across the web",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Gap(28),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              customizeText,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          CupertinoSwitch(
                            value: _switchValue,
                            onChanged: (value) => _onChanged(value),
                          )
                        ],
                      ),
                      const Gap(28),
                      RichText(
                        text: TextSpan(
                          text: "By signing up, you agree to our ",
                          style: Theme.of(context).textTheme.labelMedium,
                          children: [
                            getTextSpanLink(
                              context: context,
                              text: "Terms of Servive",
                              link: "",
                            ),
                            const TextSpan(text: ", "),
                            getTextSpanLink(
                              context: context,
                              text: "Privacy Policy",
                              link: "",
                            ),
                            const TextSpan(text: ", and "),
                            getTextSpanLink(
                              context: context,
                              text: "Cookie Use",
                              link: "",
                            ),
                            const TextSpan(
                              text:
                                  ". Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy. ",
                            ),
                            getTextSpanLink(
                              context: context,
                              text: "Learn more",
                              link: "",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AuthenticationButton(
                icon: null,
                text: "Next",
                borderColor: _switchValue
                    ? isDarkMode
                        ? Colors.black12
                        : Colors.white
                    : isDarkMode
                        ? Colors.grey
                        : Colors.grey,
                boxColor: _switchValue
                    ? isDarkMode
                        ? Colors.white
                        : Colors.black
                    : isDarkMode
                        ? Colors.grey
                        : Colors.grey,
                textColor: _switchValue
                    ? isDarkMode
                        ? Colors.black
                        : Colors.white
                    : isDarkMode
                        ? Colors.white
                        : Colors.white,
                onTap: _switchValue ? _onNextTap : null,
              ),
              const Gap(28),
            ],
          ),
        ),
      ),
    );
  }
}
