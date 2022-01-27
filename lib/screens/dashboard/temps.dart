class Temps {


  var main;
  var description;
  var icon;
  var temp;
  var pressure;
  var humidity;
  var min;
  var max;

  Temps(Map map){
    List weather = map['weather'];
    Map weatherMap = weather.first;
    main = weatherMap['main'];
    description = weatherMap['description'];
    icon = weatherMap['icon'];
    Map mainMap = map['main'];
    temp = mainMap['temp'];
    pressure = mainMap['pressure'];
    humidity = mainMap['humidity'];
    min = mainMap['temp_min'];
    max = mainMap['temp_max'];
  }

}