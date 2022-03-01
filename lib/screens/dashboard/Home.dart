
// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttermanager/screens/public.dart';
import 'package:fluttermanager/services/userService.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'temps.dart';
import 'package:fluttermanager/my_flutter_app_icons.dart';
import 'package:geocode/geocode.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserService _userService = UserService();

  /*GLOBAL VAR*/
  String key = "city";
  List<String> cities = [];
  // ignore: prefer_typing_uninitialized_variables
  var choosenCity;
  Temps? temperature;
  String convertedCoordCity = "";
  GeoCode geoCode = GeoCode();

  /*LOCALISATION VAR*/
  late Location location;
  late LocationData locationData;
  late Stream<LocationData> stream;
  
  /*ASSETS VAR*/
  AssetImage sun = const AssetImage("assets/d1.jpg");
  AssetImage rain = const AssetImage("assets/d2.jpg");
  AssetImage night = const AssetImage("assets/n.jpg");


/* Obtenir la location du telephone au démarrage */
  getInitialLocation() async {
    try{
      print('TOOTOOOOOOOOOOOOOOOOOOOOOOOOOOOOO');
      locationData = await location.getLocation();
      print("Nouvelle position: ${locationData.latitude} / ${locationData.longitude}");
      locationToString();
      weatherApi();
    } catch (e) {
      print("Error");
    }
  }

/*Convertion de la localisation en Ville : Don't Work yet*/
  locationToString() async {
    double? latitude = locationData.latitude!;
    double? longitude = locationData.longitude!;

    Address convertedCity = await geoCode.reverseGeocoding(latitude: latitude, longitude: longitude);

    setState(() {
      convertedCoordCity = convertedCity.city!;
    });

    weatherApi();
  }

/* Zone d'appel API */
  weatherApi() async {
    double? latitude = locationData.latitude;
    double? longitude = locationData.longitude;

    try {
      Coordinates coordinates = await geoCode.forwardGeocoding(
          address: choosenCity);

      print("Latitude: ${coordinates.latitude}");
      print("Longitude: ${coordinates.longitude}");

      latitude = coordinates.latitude;
      longitude = coordinates.longitude;

    } catch (e) {
      print(e);
    }

    const key = "b30c2e6abe71d24e67bcaca91b3046c7";
    String lang = Localizations.localeOf(context).languageCode;

    String urlApi = "http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&lang=$lang&APPID=$key";

    final response = await http.get(Uri.parse(urlApi));

    if(response.statusCode == 200){
      Map map = jsonDecode(response.body);
      setState(() {
        temperature = Temps(map);
        print(temperature?.description);
        print(temperature?.humidity);
        print(temperature?.temp);
      });
    }

  }

  /*BASE INIT*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    location = Location();
    getInitialLocation();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text('Accue Weather'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: GestureDetector(
              onTap: () async {
                await _userService.logout();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => const PublicScreen()),
                        (route) => false);
              },
              child: const Icon(Icons.logout, size: 30.0,),
            )
          )
        ],
      ),

        drawer: Drawer(
          child: Container(
            child: ListView.builder(
              itemCount: cities.length + 2 ,
                itemBuilder: (context, i ){
                if(i == 0){
                  return DrawerHeader(
                    child: Column(
                      mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                      children: [
                        styleText("My cities", fontSize: 25.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[50],
                            elevation: 8.0,
                          ),
                            child: styleText('New City', fontSize: 18.0, color: Colors.orange[500]),
                            onPressed: addCity,
                        )
                      ],
                    ),
                  );
                }else if (i == 1) {
                  return ListTile(
                    title: styleText("My localisation: ${convertedCoordCity}"),
                      onTap: () {
                        setState(() {
                          choosenCity = null;
                          Navigator.pop(context);
                        });
                      });
                }else{
                  String city = cities[i - 2];
                  return ListTile(
                    title: styleText(city),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: (() => delete(city)),
                    ),
                    onTap: () {
                      setState(() {
                        choosenCity = city;
                        print(choosenCity);
                        weatherApi();
                        Navigator.pop(context);
                      });
                    },
                  );
                }
                }),
            color: Colors.orange[500],
          ) ,
        ),

      body: Center(
        child: (temperature == null)
          ? Center(child:(Text((choosenCity == null) ? "Ville actuelle" : choosenCity)))
          : Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(image: getBackground(), fit: BoxFit.cover)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              styleText((choosenCity == null) ? convertedCoordCity :choosenCity, fontSize: 40.0, ),
              Text("${temperature?.description.toUpperCase()}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.white),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(image: getLocalIcon()),
                  styleText("${temperature?.temp.toInt()} °C", fontSize: 75.0),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  extra("${temperature?.min.toInt()}°C", MyFlutterApp.arrow_downward),
                  extra("${temperature?.max.toInt()}°C", MyFlutterApp.arrow_upward),
                  extra("${temperature?.pressure.toInt()} Pa", MyFlutterApp.temperatire),
                  extra("${temperature?.humidity.toInt()}%", MyFlutterApp.droplet)
                ],
              )
            ],
          ) ,
        )
      )
    );
  }

  Column extra(String data, IconData iconData){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(iconData, color: Colors.white, size: 32.0),
        styleText(data)
      ],
    );
  }

  /* Style pour texte*/
  Text styleText(String data,
      {color = Colors.white,
        fontSize = 19.0,
        textAlign = TextAlign.center}){
    return Text(
      data,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize
      ),
    );
  }

  /*locationToString() async {
    Coordinates coordinates = Coordinates(locationData.latitude, locationData.longitude);
    final cityName = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print(cityName.first.locality);
  }*/

  /* Ajout d'une ville dans le Drager*/
  Future<void> addCity() async {
    return showDialog(
      barrierDismissible: true,
      builder: (BuildContext buildContext){
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(20.0),
          title: styleText("Ajouter une ville", fontSize: 22.0, color: Colors.blueAccent),
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: "Ville : "),
              onSubmitted: (String city) {
                add(city);
                Navigator.pop(buildContext);
              },
            )

          ],
        );
      },
      context: context
    );
  }

  /* Obtenir liste des villes */
  void get() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? list = sharedPreferences.getStringList(key);
    if(list != null){
      setState(() {
        cities = list;
      });
    }
  }

  /*Ajout ville dans le tableau */
  void add(String city) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cities.add(city);
    await sharedPreferences.setStringList(key, cities);
    get();
  }

  /*Supression d'une ville dans le tableau*/
  void delete(String city) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cities.remove(city);
    await sharedPreferences.setStringList(key, cities);
    get();
  }

  /* Suivis de la localisation actuelle du telephone*/
  listenStream() {
    stream = location.onLocationChanged;
    stream.listen((newPosition) {
      if((newPosition.longitude != locationData.longitude) && (newPosition.latitude != locationData.latitude)){
        setState(() {
          print("New => ${newPosition.latitude} ---------- ${newPosition.longitude}");
          locationData = newPosition;
        });
      }
      setState(() {
        locationData = newPosition;
      });
    });
  }

  /* Adaptation du background en fonction de l'icone recu par l'API*/
  AssetImage getBackground() {
    if(temperature?.icon.contains('n')){
      return night;
    }else if(temperature?.icon.contains('01') ||
              temperature?.icon.contains('02') ||
              temperature?.icon.contains('04'))
    {
      return sun;
    }else{
      return rain;
    }
  }

  AssetImage getLocalIcon(){
    String icon = temperature?.icon.replaceAll('d', '').replaceAll('n','');
    return AssetImage("assets/$icon.png");
  }

}
