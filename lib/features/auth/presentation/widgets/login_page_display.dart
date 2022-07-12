import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_clean_architecture/core/dictionaries/errors.dart';
import 'package:training_clean_architecture/features/auth/data/models/login_model.dart';
import 'package:training_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';

class LoginPageDisplay extends StatelessWidget {
  const LoginPageDisplay({
    Key? key,
    required GlobalKey<FormState> formKeyLogin,
    required TextEditingController login,
  }) : _formKeyLogin = formKeyLogin, _login = login, super(key: key);

  final GlobalKey<FormState> _formKeyLogin;
  final TextEditingController _login;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    return requiredField;
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
    );
  }
}