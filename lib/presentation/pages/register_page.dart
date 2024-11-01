import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storia/core/resources/injection_container.dart';
import 'package:storia/core/routes/router.dart';
import 'package:storia/core/utils/color_widget.dart';
import 'package:storia/core/utils/container_widget.dart';
import 'package:storia/core/utils/generic_text_field.dart';
import 'package:storia/core/utils/text_widget.dart';
import 'package:storia/core/utils/toast.dart';
import 'package:storia/presentation/bloc/register_bloc.dart';
import 'package:storia/presentation/widgets/generic_button.dart';
import 'package:storia/presentation/widgets/page_template.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool seePassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
      if (!state.isLoading && state.registerEntity != null) {
        if (!(state.registerEntity?.error ?? false)) {
          showSuccess(context, state.registerEntity?.message ?? "");
          context.router.replaceAll([const LoginRoute()]);
        } else {
          showError(context, state.registerEntity?.message ?? "");
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
                        AppLocalizations.of(context)?.register_page_title ?? '',
                        size: 32,
                        color: ColorWidget.textPrimaryColor)
                    .verticalPadded(),
                GenericTextField(
                  labelText:
                      AppLocalizations.of(context)?.register_input_email ?? '',
                  controller: _emailController,
                  hintText: AppLocalizations.of(context)
                          ?.register_input_email_placeholder ??
                      '',
                  onChanged: (_) {
                    setState(() {});
                  },
                  suffixIcon: const Icon(Icons.email),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                              ?.register_input_email_error ??
                          '';
                    } else {
                      return null;
                    }
                  },
                ),
                GenericTextField(
                  labelText:
                      AppLocalizations.of(context)?.register_input_name ?? '',
                  controller: _nameController,
                  hintText: AppLocalizations.of(context)
                          ?.register_input_name_placeholder ??
                      '',
                  onChanged: (_) {
                    setState(() {});
                  },
                  suffixIcon: const Icon(Icons.email),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)
                              ?.register_input_name_error ??
                          '';
                    } else {
                      return null;
                    }
                  },
                ).verticalPadded(),
                GenericTextField(
                  labelText:
                      AppLocalizations.of(context)?.register_input_password ??
                          '',
                  controller: _passwordController,
                  hintText: AppLocalizations.of(context)
                          ?.register_input_password_placeholder ??
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
                              ?.register_input_password_error ??
                          '';
                    } else if (value.length < 8) {
                      AppLocalizations.of(context)
                              ?.register_input_password_error_length ??
                          '';
                    }
                    {
                      return null;
                    }
                  },
                  obSecureText: !seePassword,
                ),
                GenericButton(
                  text: AppLocalizations.of(context)?.register_button ?? '',
                  onTap: (_formKey.currentState?.validate() ?? false)
                      ? () {
                          sl<RegisterBloc>().add(DoRegisterEvent(
                              name: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim()));
                        }
                      : null,
                  isDisable: (_formKey.currentState?.validate() ?? false),
                ).verticalPadded(32)
              ],
            ).padded(),
          ),
        ),
      );
    });
  }
}
