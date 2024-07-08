import 'package:lg_ai_touristic_explorer/models/place.dart';

class Orbit {
  buildOrbit(String content) {
    String kmlOrbit = '''
<?xml version="1.0" encoding="UTF-8"?>
      <kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
        <gx:Tour>
          <name>Orbit</name>
          <gx:Playlist> 
            $content
          </gx:Playlist>
        </gx:Tour>
      </kml>
      
    ''';
    return kmlOrbit;
  }

  generateOrbit(List<Place> places) {
    double heading = 0;
    int orbit = 0;
    String content = '';
    String range = '500';
    int altitude = 200;
    for (int i = 0; i < places.length; i++) {
      content += '''
            <gx:FlyTo>
              <gx:duration>2</gx:duration>
              <gx:flyToMode>smooth</gx:flyToMode>
              <LookAt>
                  <longitude>${places[i].longitude - 0.0}</longitude>
                  <latitude>${places[i].latitude - 0.0}</latitude>
                  <heading>$heading</heading>
                  <tilt>60</tilt>
                  <range>${range}</range>
                  <gx:fovy>00</gx:fovy> 
                  <altitude>$altitude</altitude> 
                  <gx:altitudeMode>absolute</gx:altitudeMode>
              </LookAt>
            </gx:FlyTo>
          ''';
      while (orbit <= 36) {
        if (heading >= 360) heading -= 360;
        content += '''
            <gx:FlyTo>
              <gx:duration>0.5</gx:duration>
              <gx:flyToMode>smooth</gx:flyToMode>
              <LookAt>
                  <longitude>${places[i].longitude - 0.0}</longitude>
                  <latitude>${places[i].latitude - 0.0}</latitude>
                  <heading>$heading</heading>
                  <tilt>45</tilt>
                  <range>${range}</range>
                  <gx:fovy>60</gx:fovy> 
                  <altitude>$altitude</altitude> 
                  <gx:altitudeMode>absolute</gx:altitudeMode>
              </LookAt>
            </gx:FlyTo>
          ''';
        heading += 10;
        orbit += 1;
      }
      heading = 0;
      orbit = 0;
    }
    return content;
  }
}
