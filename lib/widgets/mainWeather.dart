import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';

class MainWeather extends StatelessWidget {
  final wData;

  MainWeather({required this.wData});

  final TextStyle _style1 = const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 20, color: Colors.blue);
  final TextStyle _style2 = const TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.amber,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 5),
      height: MediaQuery.of(context).size.height / 3.4,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined),
              Text('${wData.weather.cityName}', style: _style1),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.center,
            child: Text(
              DateFormat.yMMMEd().add_jm().format(DateTime.now()),
              style: _style2,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25, right: 25),
                child: MapString.mapStringToIcon(
                    '${wData.weather.currently}', context, 55),
              ),
              Text(
                '${wData.weather.temp.toStringAsFixed(0)}°C',
                style: const TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${wData.weather.tempMax.toStringAsFixed(0)}°/ ${wData.weather.tempMin.toStringAsFixed(0)}° Feels like ${wData.weather.feelsLike.toStringAsFixed(0)}°',
            style: _style1.copyWith(fontSize: 19),
          ),
          const SizedBox(height: 5),
          Text(
            toBeginningOfSentenceCase('${wData.weather.description}')
                .toString(),
            style: _style1.copyWith(fontSize: 19),
          ),
        ],
      ),
    );
  }
}
