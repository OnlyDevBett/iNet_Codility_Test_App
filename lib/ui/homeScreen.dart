import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../helper/provider/weatherProvider.dart';
import '../widgets/WeatherInfo.dart';
import '../widgets/hourlyForecast.dart';
import '../widgets/locationError.dart';
import '../widgets/mainWeather.dart';
import '../widgets/requestError.dart';
import '../widgets/searchBar.dart';
import '../widgets/weatherDetail.dart';
import '../widgets/sevenDayForecast.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  late bool _isLoading;

  //the first action that is performed when this screen is called
  @override
  void initState() {
    super.initState();
    //first method to be executed on the HomeScreen page
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    //clear _oageController
    _pageController.dispose();
  }

  //method call to get weather data
  Future<void> _getData() async {
    _isLoading = true;
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getWeatherData();
    _isLoading = false;
  }

  //this method refreshes to update the data
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false).getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    //variable declaration
    final weatherData = Provider.of<WeatherProvider>(context);
    final myContext = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: myContext.primaryColor,
                ),
              )
            :
            //check if weather data is null
            weatherData.loading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: myContext.primaryColor,
                    ),
                  )
                : weatherData.isLocationError
                    ? LocationError()
                    : Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1612908055356-8c51bc883355?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80'),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          children: [
                            //render the search input field
                            SearchBar(),
                            //page controller
                            SmoothPageIndicator(
                              controller: _pageController,
                              count: 2,
                              effect: ExpandingDotsEffect(
                                activeDotColor: myContext.primaryColor,
                                dotHeight: 6,
                                dotWidth: 6,
                              ),
                            ),
                            weatherData.isRequestError
                                ? RequestError()
                                : Expanded(
                                    //render page views
                                    child: PageView(
                                      controller: _pageController,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: mediaQuery.size.width,
                                          child: RefreshIndicator(
                                            onRefresh: () =>
                                                _refreshData(context),
                                            backgroundColor: Colors.black54,
                                            child: ListView(
                                              children: [
                                                MainWeather(wData: weatherData),
                                                //weather information widget
                                                WeatherInfo(
                                                    wData: weatherData
                                                        .currentWeather),
                                                HourlyForecast(
                                                    weatherData.hourlyWeather),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: mediaQuery.size.height,
                                          width: mediaQuery.size.width,
                                          child: ListView(
                                            children: [
                                              //Render 7 day Widget
                                              SevenDayForecast(
                                                wData: weatherData,
                                                dWeather:
                                                    weatherData.sevenDayWeather,
                                              ),
                                              WeatherDetail(wData: weatherData),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
      ),
    );
  }
}
