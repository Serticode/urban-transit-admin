import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_fade_animation.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/screens/widgets/app_elevated_button.dart';
import 'package:urban_transit_admin/screens/widgets/app_text_form_field.dart';
import 'package:urban_transit_admin/router/router.dart';
import 'package:urban_transit_admin/router/routes.dart';
import 'package:urban_transit_admin/screens/auth/security_setup/widget/security_setup_invalid_email.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class SecuritySetupScreen extends ConsumerStatefulWidget {
  const SecuritySetupScreen({super.key});

  @override
  ConsumerState<SecuritySetupScreen> createState() =>
      _SecuritySetupScreenState();
}

class _SecuritySetupScreenState extends ConsumerState<SecuritySetupScreen> {
  late final TextEditingController _emailController = TextEditingController();
  final ValueNotifier<bool> _textFieldHasContent = ValueNotifier(false);
  final ValueNotifier<bool> _isEmailValidated = ValueNotifier(true);
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _emailController.clear();
    _emailController.dispose();
    _textFieldHasContent.dispose();
    _isEmailValidated.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    //! MAIN WIDGET
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: ValueListenableBuilder(
                valueListenable: _isEmailValidated,
                builder: (context, value, child) => Visibility(
                  visible: _isEmailValidated.value == false,
                  child: const SecuritySetupInvalidEmailError(),
                ),
              ),
            )
          ]),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          //! TITLE
          AppFadeAnimation(
            delay: 1.2,
            child: Text(AppTexts.securitySetup, style: textTheme.displayLarge),
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! NOTICE
          AppFadeAnimation(
            delay: 1.4,
            child: Text(AppTexts.securitySetupNotice,
                style: textTheme.displayMedium),
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceLarge,

          //! LABEL
          AppFadeAnimation(
            delay: 1.6,
            child: Text(AppTexts.emailLabel, style: textTheme.bodyLarge),
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! TEXT FORM FIELD - EMAIL
          AppFadeAnimation(
            delay: 1.6,
            child: AppTextFormField(
              controller: _emailController,
              hintText: AppTexts.emailHint,
              onChanged: (textContent) =>
                  _textFieldHasContent.value = textContent.isNotEmpty,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter an email";
                } else if (value.contains("@") == false) {
                  _isEmailValidated.value = false;
                  return "";
                } else {
                  return null;
                }
              },
            ),
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          AppFadeAnimation(
            delay: 1.8,
            child: Center(
              child: Text(
                AppTexts.securitySetupNotice2,
                style: textTheme.bodyMedium!
                    .copyWith(color: AppThemeColours.appBlue),
              ),
            ),
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! BUTTON
          AppFadeAnimation(
            delay: 2.0,
            child: ValueListenableBuilder(
              valueListenable: _textFieldHasContent,
              builder: (context, value, child) => AppElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    AppNavigator.navigateToPage(
                      thePageRouteName: AppRoutes.otpVerification,
                      context: context,
                    );
                  }
                },

                //!
                buttonColour: _textFieldHasContent.value
                    ? AppThemeColours.appBlue
                    : AppThemeColours.elevatedButtonBackgroundColour,
                buttonTitle: AppTexts.securitySetupSendOTP,
              ).ignorePointer(isLoading: _textFieldHasContent.value == false),
            ),
          )
        ],
      ),
    ).generalPadding;
  }
}
