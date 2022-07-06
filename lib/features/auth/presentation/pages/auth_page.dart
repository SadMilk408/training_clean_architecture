import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_clean_architecture/core/dictionaries/errors.dart';
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';
import 'package:training_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:training_clean_architecture/features/users_list/presentation/pages/users_list_page.dart';
import 'package:training_clean_architecture/injection_container.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _login = TextEditingController();

  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>()..add(AutoAuthEvent(context: context)),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 50),
                    child: Form(
                      key: _formKeyLogin,
                      child: TextFormField(
                        controller: _login,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            fillColor: Colors.black12,
                            labelText: 'Логин',
                            filled: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return Errors.requiredField;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: MaterialButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              SaveLoginToCacheEvent(
                                loginModel: LoginModel(username: _login.text),
                                context: context,
                              ),
                            );
                      },
                      child: Container(
                        width: 200,
                        height: 60,
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            'Войти',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
