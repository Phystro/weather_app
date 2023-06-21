import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_theme.dart';
import '../../data/constants.dart';
import '../../data/conversion.dart';
import '../../localization/language.dart';
import '../bloc/language/language_bloc.dart';
import '../bloc/language/language_event.dart';
import '../bloc/language/language_state.dart';
import '../bloc/weather/weather_state.dart';
import '../bloc/weather/weather_bloc.dart';
import '../bloc/weather/weather_event.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key, required this.acontext}) : super(key: key);

  final BuildContext acontext;

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text(
              //   // AppLocalizations.of(context)!.chooseLanguage,
              //   // style: Theme.of(context).textTheme.headline2,
              // ),
              const SizedBox(height: 16.0),
              BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: Language.values.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          context.read<LanguageBloc>().add(ChangeLanguage(
                              selectedLanguage: Language.values[index]));
                          Future.delayed(const Duration(milliseconds: 300))
                              .then((value) => Navigator.of(context).pop());
                        },
                        leading: ClipOval(
                          child: Language.values[index].image.image(
                            height: 32.0,
                            width: 32.0,
                          ),
                        ),
                        title: Text(Language.values[index].text),
                        trailing:
                            Language.values[index] == state.selectedLanguage
                                ? Icon(
                                    Icons.check_circle_rounded,
                                    color: ColorsLib.primary,
                                  )
                                : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: Language.values[index] == state.selectedLanguage
                              ? BorderSide(color: ColorsLib.primary, width: 1.5)
                              : BorderSide(color: Colors.grey[300]!),
                        ),
                        tileColor:
                            Language.values[index] == state.selectedLanguage
                                ? ColorsLib.primary.withOpacity(0.05)
                                : null,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16.0);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // essential for localization
    final lang = AppLocalizations.of(acontext)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          lang.weather,
          style: const TextStyle(color: Colors.orange),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: OutlinedButton(
              onPressed: () => showLanguageBottomSheet(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
                foregroundColor: ColorsLib.lightGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: BlocBuilder<LanguageBloc, LanguageState>(
                      builder: (context, state) {
                        return state.selectedLanguage.image.image();
                      },
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: ColorsLib.darkPrimary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: lang.cityPrompt,
              ),
              onChanged: (query) {
                context.read<WeatherBloc>().add(OnCityChanged(query));
              },
            ),
            const SizedBox(height: 32.0),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WeatherHasData) {
                  return Column(
                    key: const Key('weather_data'),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.result.cityName,
                            style: const TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                          Image(
                            image: NetworkImage(
                              Urls.weatherIcon(
                                state.result.iconCode,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '${state.result.main} | ${state.result.description}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Table(
                        defaultColumnWidth: const FixedColumnWidth(150.0),
                        border: TableBorder.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                lang.temperature,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                // state.result.temperature.toString(),
                                Conversion.ktoc(state.result.temperature)
                                    .toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ), // Will be change later
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                lang.pressure,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.result.pressure.toString(),
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold),
                              ),
                            ), // Will be change later
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                lang.humidity,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.result.humidity.toString(),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ), // Will be change later
                          ]),
                        ],
                      ),
                    ],
                  );
                } else if (state is WeatherError) {
                  return Center(
                    child: Text(lang.sthWrong),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
