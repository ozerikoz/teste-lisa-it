import 'dart:math';

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
        body: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login successful")),
              );
            } else if (state.status == LoginStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? "Login failed")),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.email != current.email,
                    builder: (context, state) {
                      return TextFormField(
                        initialValue: state.email,
                        decoration: const InputDecoration(labelText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(EmailChangedEvent(value)),
                        validator: (value) {
                          // todo create password validator

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
                        decoration:
                            const InputDecoration(labelText: "Password"),
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
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return ElevatedButton(
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
                            ? const CircularProgressIndicator()
                            : const Text("Login"),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
