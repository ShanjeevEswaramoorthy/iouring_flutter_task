import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iouring_flutter_task/features/watchlist/data/repository/watchlist_repository.dart';
import 'package:iouring_flutter_task/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:iouring_flutter_task/features/watchlist/presentation/views/home_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => WatchlistBloc(WatchlistRepository()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watchlist App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomeScreen(),
    );
  }
}
