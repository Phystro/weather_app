import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/bloc/language/language_bloc.dart';
import 'package:weather_app/presentation/bloc/language/language_state.dart';
import 'package:weather_app/presentation/bloc/weather/weather_bloc.dart';
import 'package:weather_app/presentation/pages/weather_page.dart';

import 'injection.dart' as di;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//git@github.com:codestronaut/flutter-weather-app-sample.git

void main() {
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<WeatherBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<LanguageBloc>(),
          child: BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              // wrap MaterialApp with BlocBuilder to rebuild widget tree when state changes.
              // register bloc with Bloc provider., then set the locale property with the state value
              return MaterialApp.router(
                locale: state.selectedLanguage
                    .value, // change language based on the state
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
              );
            },
          ),
        ),
      ],
      child: MaterialApp(
        title: "Flutter Weather App Demo",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.orange,
        ),
        // supportedLocales: AppLocalizations.supportedLocales,
        // localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: WeatherPage(acontext: context),
      ),
    );
  }
}
