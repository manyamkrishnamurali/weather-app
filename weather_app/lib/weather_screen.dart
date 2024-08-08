import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additional_info.dart';
//import 'package:weather_app/hourly_forecast.dart';
import 'package:weather_app/secrets.dart';
//import 'tiles.dart'; 
import 'package:http/http.dart' as http;
import 'package:weather_app/tiles.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  
  late Future<Map<String,dynamic>> weather;
  Future<Map<String,dynamic>> getCurrentWeather() async{
   try{
    String cityName = 'Hyderabad';
    final res = await http.get(
      Uri.parse('http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$APIKey'));
  
    final data = jsonDecode(res.body);

    if(data['cod']!='200'){
      throw data['message'];
    }
    //data['list'][0]['main']['temp'];
    return data;
   }
  
  catch(e){
    throw e.toString();
  }

  //print(res.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          //textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          // GestureDetector(
          //   onTap: (){},
          //   child: Icon(Icons.refresh),),
          IconButton(
            onPressed: () {
              setState(() {
                weather=getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      //body: temp==0? Center( child: CircularProgressIndicator.adaptive()):
      body:FutureBuilder(
        //future: getCurrentWeather(), 
        future: weather,       
        builder :(context, snapshot) {  
          print(snapshot);
          //print(snapshot.runtimeType);
          
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: const CircularProgressIndicator.adaptive());
          }

          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }

          final data =snapshot.data!;
          final w =data['list'][0];

          final currentTemp= data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];
          final currentPressure = w['main']['pressure'];
          final windSpeed =w['wind']['speed'];
          final humidity =w['main']['humidity'];

          return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              //main card
             SizedBox(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          elevation: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      '$currentTemp K',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      (currentSky=='Clouds'||currentSky=='Rain') ? Icons.cloud: Icons.sunny,
                      size: 60,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      currentSky,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
            ),
              SizedBox(
                height: 15,
              ),
               Text(
                  'Weather Forecast',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              
              // SizedBox(
              //   height: 5,
              // ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       for(int i=0;i<5;i++){}
              //       tiles(
              //         time:data['list'][i+1];
              //       ),
              //       tiles(),
              //       tiles(),
              //       tiles(),
              //       tiles(),             
              //     ],
              //   ),
              // ),
              // const Placeholder(
              //   fallbackHeight: 150,
              // ),

              SizedBox(
                height: 120,
                child: ListView.builder(
                scrollDirection:Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context,index){
                    final tileData =data['list'][index+1];
                    final skyy =tileData['weather'][0]['main'];
                    final timee = DateTime.parse(tileData['dt_txt']);
                    return tiles(
                      time:DateFormat.Hm().format(timee),
                        //DateFormat('Hm').format(timee),
                      temparature : tileData['main']['temp'].toString(),
                      icon:(skyy=='Clouds'||skyy=='Rain') ? Icons.cloud: Icons.sunny,
                    );
                }),
              ),
              const SizedBox(height: 16,),
        
              Text(
                'Additional Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround ,
                children: [
                  additionalInfo(
                    icon:Icons.water_drop,
                    label:'humidity',
                    value :humidity
                    ),
                  additionalInfo(
                    icon:Icons.air,
                    label:'wind speed',
                    value: windSpeed ,
                    ),
                  additionalInfo(
                    icon:Icons.beach_access,
                    label:'Pressure',
                    value:currentPressure),
                ],
              )
            ],
          ),
        );
        },
      ),
    );
  }
}



