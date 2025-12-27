import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'features/mainTab/bloc/main_tab_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => MainTabBloc())],
      child: const PortfolioApp(),
    ),
  );
}
