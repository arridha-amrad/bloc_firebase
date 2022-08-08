import 'package:bloc_firebase/home/bloc/home_bloc.dart';
import 'package:bloc_firebase/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLogout extends StatelessWidget {
  const HomeLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return IconButton(
            onPressed: () {
              context.read<HomeBloc>().add(const Logout());
              Navigator.of(context).pushAndRemoveUntil(
                LoginView.route(),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout));
      },
    );
  }
}
