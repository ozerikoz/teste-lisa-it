import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:teste_lisa_it/domain/validators/credentials_validator.dart";
import "package:teste_lisa_it/presentation/auth/login/bloc/login_bloc.dart";
import "package:teste_lisa_it/presentation/core/widgets/error_snackbar.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
              child: BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) {
                  return previous.autovalidateMode != current.autovalidateMode;
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    autovalidateMode: state.autovalidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          key: const ValueKey("email-field"),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: "Email",
                            hintText: "Digite seu email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            _emailController.text = value;
                          },
                          validator: CredentialsValidator.validateEmail,
                        ),
                        const SizedBox(height: 16),
                     BlocBuilder<LoginBloc, LoginState>(
                          builder: (context,state) {
                            return TextFormField(
                              key: const ValueKey("password-field"),
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintText: "Digite sua senha",
                                labelText: "Senha",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    context.read<LoginBloc>().add(
                                          LoginPasswordVisibilityChangedEvent(
                                            isPasswordObscure:
                                                state.isPasswordObscure,
                                          ),
                                        );
                                  },
                                  icon: Icon(
                                    state.isPasswordObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).colorScheme.primary,
                                    size: 24,
                                  ),
                                ),
                              ),
                              obscureText: state.isPasswordObscure,
                              onChanged: (value) {
                                _passwordController.text = value;
                              },
                              validator: CredentialsValidator.validatePassword,
                            );
                          }
                        ),
                        const SizedBox(height: 24),
                        BlocConsumer<LoginBloc, LoginState>(
                          listenWhen: (previous, current) {
                            return previous.status != current.status;
                          },
                          listener: (context, state) {
                            // Show error message if login fails
                            if (state.status == LoginStatus.failure) {
                              ErrorSnackbar.show(
                                context,
                                state.errorMessage ??
                                    "Algo deu errado, tente novamente mais tarde!",
                              );
                            }
                          },
                          builder: (context, state) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  key: const ValueKey("login-button"),
                                  onPressed: state.status == LoginStatus.loading
                                      ? null
                                      : () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // Trigger login event
                                            context.read<LoginBloc>().add(
                                                  LoginRequestedEvent(
                                                    email:
                                                        _emailController.text,
                                                    password:
                                                        _passwordController
                                                            .text,
                                                  ),
                                                );
                                          } else {
                                            // Change autovalidate mode
                                            context.read<LoginBloc>().add(
                                                  LoginAutovalidateModeChangedEvent(
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                  ),
                                                );
                                          }
                                        },
                                  child: state.status == LoginStatus.loading
                                      ? SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        )
                                      : Text(
                                          "Login",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
