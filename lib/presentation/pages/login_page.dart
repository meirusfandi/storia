import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storia/core/resources/injection_container.dart';
import 'package:storia/core/routes/router.dart';
import 'package:storia/core/utils/color_widget.dart';
import 'package:storia/core/utils/container_widget.dart';
import 'package:storia/core/utils/generic_text_field.dart';
import 'package:storia/core/utils/text_widget.dart';
import 'package:storia/core/utils/toast.dart';
import 'package:storia/presentation/bloc/login_bloc.dart';
import 'package:storia/presentation/widgets/generic_button.dart';
import 'package:storia/presentation/widgets/page_template.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool seePassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (!state.isLoading && state.loginEntity != null) {
        if (!(state.loginEntity?.error ?? false)) {
          showSuccess(context,
              AppLocalizations.of(context)?.login_success_message ?? '');
          context.router.replaceAll([const StoryRoute()]);
        } else {
          showError(
              context, AppLocalizations.of(context)?.login_error_message ?? '');
        }
      }
    }, builder: (context, state) {
      return PageTemplate(
        loading: state.isLoading,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: Image.asset('assets/img_logo.png',
                      fit: BoxFit.cover, height: 100, width: 100),
                ),
                TextWidget.manropeBold(
                        AppLocalizations.of(context)?.login_page_title ?? '',
                        size: 32,
                        color: ColorWidget.textPrimaryColor)
                    .verticalPadded(),
                GenericTextField(
                  labelText:
                      AppLocalizations.of(context)?.login_input_email ?? '',
                  controller: _emailController,
                  hintText: AppLocalizations.of(context)
                          ?.login_input_email_placeholder ??
                      '',
                  onChanged: (_) {
                    setState(() {});
                  },
                  suffixIcon: const Icon(Icons.email),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                              ?.login_input_email_error ??
                          '';
                    } else {
                      return null;
                    }
                  },
                ),
                GenericTextField(
                  labelText:
                      AppLocalizations.of(context)?.login_input_password ?? '',
                  controller: _passwordController,
                  hintText: AppLocalizations.of(context)
                          ?.login_input_password_placeholder ??
                      '',
                  onChanged: (_) {
                    setState(() {});
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        seePassword = !seePassword;
                      });
                    },
                    icon: (seePassword)
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                              ?.login_input_password_error ??
                          '';
                    }
                    if (value.length < 8) {
                      return AppLocalizations.of(context)
                              ?.login_input_password_error_length ??
                          '';
                    } else {
                      return null;
                    }
                  },
                  obSecureText: !seePassword,
                ).verticalPadded(),
                GenericButton(
                  text: AppLocalizations.of(context)?.login_button ?? '',
                  onTap: (_formKey.currentState?.validate() ?? false)
                      ? () {
                          sl<LoginBloc>().add(DoLoginEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim()));
                        }
                      : null,
                  isDisable: (_formKey.currentState?.validate() ?? false),
                ).verticalPadded(),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: AppLocalizations.of(context)
                                  ?.login_dont_have_account ??
                              '',
                          style:
                              TextStyle(color: ColorWidget.textPrimaryColor)),
                      TextSpan(
                          text: AppLocalizations.of(context)
                                  ?.login_create_account ??
                              '',
                          style:
                              TextStyle(color: ColorWidget.semanticInfoColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => context.pushRoute(const RegisterRoute())),
                    ],
                  ),
                ),
              ],
            ).padded(),
          ),
        ),
      );
    });
  }
}
