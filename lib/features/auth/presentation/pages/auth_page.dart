import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_clean_architecture/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:training_clean_architecture/features/users_list/presentation/pages/users_list_page.dart';
import 'package:training_clean_architecture/features/auth/presentation/widgets/widgets.dart';
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
            body: LoginPageDisplay(formKeyLogin: _formKeyLogin, login: _login),
          );
        },
      ),
    );
  }
}
