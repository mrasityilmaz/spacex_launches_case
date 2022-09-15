import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:spacex_launches_case/View/main_screen.dart';

import 'Bloc/SpaceXBloc/spacex_bloc.dart';
import 'DataProvider/spacex_data_provider.dart';
import 'Repository/spacex_repository.dart';

void main() {
  SpaceXDataProvider spaceXDataProvider =
      SpaceXDataProvider(httpClient: http.Client());

  SpaceXRepository spaceXRepository = SpaceXRepository(spaceXDataProvider);

  runApp(
    BlocProvider<SpaceXBloc>(
        create: (context) => SpaceXBloc(serviceRepository: spaceXRepository),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SpaceXMainScreen());
  }
}
