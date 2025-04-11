import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_lisa_it/presentation/auth/login/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.email != current.email,
                      builder: (context, state) {
                        return TextFormField(
                          initialValue: state.email,
                          decoration: InputDecoration(
                            labelText: "Email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => context
                              .read<LoginBloc>()
                              .add(EmailChangedEvent(value)),
                          validator: (value) {
                            // todo create email validator
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<LoginBloc, LoginState>(
                      buildWhen: (previous, current) =>
                          previous.password != current.password,
                      builder: (context, state) {
                        return TextFormField(
                          initialValue: state.password,
                          decoration: InputDecoration(
                            labelText: "Password",
                          ),
                          obscureText: true,
                          onChanged: (value) => context
                              .read<LoginBloc>()
                              .add(PasswordChangedEvent(value)),
                          validator: (value) {
                            // todo create password validator
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        // todo if LoginStatus.failure show a snackbar with the error message
                      },
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state.status == LoginStatus.loading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<LoginBloc>().add(
                                              LoginRequestedEvent(
                                                email: state.email,
                                                password: state.password,
                                              ),
                                            );
                                      }
                                    },
                              child: state.status == LoginStatus.loading
                                  ? SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  : Text(
                                      "Login",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
