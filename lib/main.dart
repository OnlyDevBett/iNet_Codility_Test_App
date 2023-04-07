import 'package:flutter/material.dart';
import 'package:inet_test_app/helper/provider/weatherProvider.dart';
import 'package:inet_test_app/ui/homeScreen.dart';
import 'package:inet_test_app/ui/hourlyWeatherScreen.dart';
import 'package:inet_test_app/ui/weeklyWeatherScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const DaliliApp());
}

class DaliliApp extends StatelessWidget {
  const DaliliApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //on app initialization, if listens to api calls from the weather api notifier
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        title: 'Dalili App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
        home: HomeScreen(),
        routes: {
          WeeklyScreen.routeName: (myCtx) => WeeklyScreen(),
          HourlyScreen.routeName: (myCtx) => HourlyScreen(),
        },
      ),
    );
  }
}
