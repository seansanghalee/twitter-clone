import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:twitter_clone/authentication/screens/customize_experience_screen.dart';
import 'package:twitter_clone/authentication/widgets/authentication_button.dart';
import 'package:twitter_clone/settings/constants/sizes.dart';
import 'package:twitter_clone/settings/constants/texts.dart';
import 'package:twitter_clone/utils.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _birthdayFocusNode;

  final DateTime _today = DateTime.now();

  String _name = "";
  String _email = "";
  String _birthday = "";

  final Map<String, dynamic> _map = {};

  void _initControllers() {
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _birthdayController.addListener(() {
      setState(() {
        _birthday = _birthdayController.text;
      });
    });
  }

  void _initFoci() {
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _birthdayFocusNode = FocusNode();
  }

  @override
  void initState() {
    super.initState();
    _initControllers();
    _initFoci();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthdayController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _birthdayFocusNode.dispose();
    super.dispose();
  }

  void _setBirthday(DateTime date) {
    final dateString = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: dateString);
  }

  void _onNameTap() {
    _emailFocusNode.unfocus();
    _birthdayFocusNode.unfocus();
    FocusScope.of(context).requestFocus(_nameFocusNode);
  }

  void _onEmailTap() {
    _nameFocusNode.unfocus();
    _birthdayFocusNode.unfocus();
    FocusScope.of(context).requestFocus(_emailFocusNode);
  }

  void _onBirthdayTap() {
    _nameFocusNode.unfocus();
    _emailFocusNode.unfocus();
    FocusScope.of(context).requestFocus(_birthdayFocusNode);
  }

  void _onSignUpTap(BuildContext context) {
    if (_key.currentState != null) {
      if (_key.currentState!.validate()) {
        _key.currentState!.save();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CustomizeExperienceScreen(),
          ),
        );
      }
    }
    return;
  }

  bool _validate() {
    return _name.isNotEmpty && _email.isNotEmpty & _birthday.isNotEmpty;
  }

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    bool isDatePickerOpen = _birthdayFocusNode.hasFocus;
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Cancel",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        leadingWidth: MediaQuery.of(context).size.width / 4,
        title: const FaIcon(
          FontAwesomeIcons.twitter,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: authenticationHorizontalPadding,
          ),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create your account",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            TextFormField(
                              controller: _nameController,
                              focusNode: _nameFocusNode,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                hintText: "Name",
                                labelText: "Name",
                                suffix: _name.isEmpty
                                    ? null
                                    : const FaIcon(
                                        FontAwesomeIcons.solidCircleCheck,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              onTap: _onNameTap,
                              validator: (value) {
                                if (value != null) {
                                  if (value.isNotEmpty) {
                                    return null;
                                  }
                                }
                                return "Invalid name.";
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  _map["name"] = newValue;
                                }
                              },
                            ),
                            TextFormField(
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              decoration: InputDecoration(
                                hintText: "Phone number or email address",
                                labelText: _emailFocusNode.hasFocus
                                    ? "Email"
                                    : "Phone number or email address",
                                suffix: _email.isEmpty
                                    ? null
                                    : const FaIcon(
                                        FontAwesomeIcons.solidCircleCheck,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                              ),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              onTap: _onEmailTap,
                              validator: (value) {
                                if (value != null) {
                                  if (value.isNotEmpty) {
                                    return null;
                                  }
                                }
                                return "Invalid email.";
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  _map["email"] = newValue;
                                }
                              },
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: _birthdayController,
                              focusNode: _birthdayFocusNode,
                              decoration: InputDecoration(
                                hintText: "Date of birth",
                                labelText: "Date of birth",
                                suffix: _birthday.isEmpty
                                    ? null
                                    : const FaIcon(
                                        FontAwesomeIcons.solidCircleCheck,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                              ),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              onTap: _onBirthdayTap,
                              validator: (value) {
                                if (value != null) {
                                  if (value.isNotEmpty) {
                                    return null;
                                  }
                                }
                                return "Invalid date of birth.";
                              },
                              onSaved: (newValue) {
                                if (newValue != null) {
                                  _map["dob"] = newValue;
                                }
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 12,
                              ),
                              child: AnimatedOpacity(
                                opacity: _birthdayFocusNode.hasFocus ? 0.7 : 0,
                                duration: const Duration(milliseconds: 200),
                                child: Text(
                                  dateText,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      if (_validate() && !isKeyboardOpen && !isDatePickerOpen)
                        RichText(
                          text: TextSpan(
                            text: "By signing up, you agree to the ",
                            style: Theme.of(context).textTheme.labelMedium,
                            children: [
                              getTextSpanLink(
                                context: context,
                                text: "Terms of Servive",
                                link: "",
                              ),
                              const TextSpan(text: " and "),
                              getTextSpanLink(
                                context: context,
                                text: "Privacy Policy",
                                link: "",
                              ),
                              const TextSpan(text: ", including "),
                              getTextSpanLink(
                                context: context,
                                text: "Cookie Use",
                                link: "",
                              ),
                              const TextSpan(
                                  text:
                                      ". Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy, like keeping your account secure and personalizing our services, including ads. "),
                              getTextSpanLink(
                                context: context,
                                text: "Learn more",
                                link: "",
                              ),
                              const TextSpan(
                                  text:
                                      ". Others will be able to find you by email or phone number, when provided, unless you choose otherwise "),
                              getTextSpanLink(
                                context: context,
                                text: "here",
                                link: "",
                              ),
                              const TextSpan(text: "."),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: AnimatedFractionallySizedBox(
                        duration: const Duration(milliseconds: 200),
                        alignment: Alignment.centerRight,
                        widthFactor: _validate() ? 1 : 0.3,
                        child: AuthenticationButton(
                          icon: null,
                          text: _validate() ? "Sign up" : "Next",
                          borderColor: _validate()
                              ? Theme.of(context).primaryColor
                              : isDarkMode
                                  ? Colors.grey
                                  : Colors.grey,
                          boxColor: _validate()
                              ? Theme.of(context).primaryColor
                              : isDarkMode
                                  ? Colors.grey
                                  : Colors.grey,
                          textColor: _validate()
                              ? Colors.white
                              : isDarkMode
                                  ? Colors.white
                                  : Colors.white,
                          onTap: _validate() ? _onSignUpTap : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Visibility(
          visible: _birthdayFocusNode.hasFocus,
          child: FractionallySizedBox(
            heightFactor: 0.3,
            child: CupertinoDatePicker(
              onDateTimeChanged: _setBirthday,
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _today,
              maximumDate: _today,
            ),
          ),
        ),
      ),
    );
  }
}
