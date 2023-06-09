import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherDetail extends StatelessWidget {
  final wData;

  WeatherDetail({this.wData});

  Widget _gridWeatherBuilder(String header, String body, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(6, 8),
          ),
        ],
        image: const DecorationImage(
            image: NetworkImage(
                'https://static.vecteezy.com/system/resources/thumbnails/000/274/926/small_2x/White_Paper_Background.jpg'),
            fit: BoxFit.cover),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15, right: 5),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 35,
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  header,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  body,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Today Details',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          child: GridView(
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 2 / 1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            children: [
              _gridWeatherBuilder('${wData.weather.humidity}%', 'Humidity',
                  WeatherIcons.raindrop),
              _gridWeatherBuilder('${wData.weather.windSpeed} km/h', 'Wind',
                  WeatherIcons.strong_wind),
              _gridWeatherBuilder(
                  '${wData.weather.feelsLike.toStringAsFixed(1)}°C',
                  'Feels Like',
                  WeatherIcons.celsius),
              _gridWeatherBuilder('${wData.weather.pressure} hPa', 'Pressure',
                  WeatherIcons.barometer),
            ],
          ),
        ),
      ],
    );
  }
}
