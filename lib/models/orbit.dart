import 'package:lg_ai_touristic_explorer/models/place.dart';

class Orbit {
  String buildOrbit(String content, List<Place> places) {
    String placemarks = '';
    for (var place in places) {
      placemarks += '''
      <Placemark>
        <name>${place.name}</name>
        <LookAt>
          <longitude>${place.longitude}</longitude>
          <latitude>${place.latitude}</latitude>
          <altitude>0</altitude>
          <heading>0</heading>
          <tilt>0</tilt>
          <range>1000</range>
          <gx:altitudeMode>relativeToGround</gx:altitudeMode>
        </LookAt>
        <styleUrl>#m_ylw-pushpin</styleUrl>
        <Point>
          <gx:drawOrder>1</gx:drawOrder>
          <coordinates>${place.longitude},${place.latitude},0</coordinates>
        </Point>
      </Placemark>
    ''';
    }

    String kmlOrbit = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document>
    <StyleMap id="m_ylw-pushpin">
      <Pair>
        <key>normal</key>
        <styleUrl>#s_ylw-pushpin</styleUrl>
      </Pair>
      <Pair>
        <key>highlight</key>
        <styleUrl>#s_ylw-pushpin_hl</styleUrl>
      </Pair>
    </StyleMap>
    <Style id="s_ylw-pushpin">
      <IconStyle>
        <color>ff0000ff</color>
        <scale>1.1</scale>
        <Icon>
          <href>https://myapp33bucket.s3.amazonaws.com/pin.png</href>
        </Icon>
        <hotSpot x="0.5" y="0.5" xunits="fraction" yunits="fraction"/>
      </IconStyle>
      <LabelStyle>
        <color>ff00ff00</color>
        <scale>1.7</scale>
      </LabelStyle>
      <ListStyle>
      </ListStyle>
    </Style>
    <Style id="s_ylw-pushpin_hl">
      <IconStyle>
        <color>ff0000ff</color>
        <scale>1.3</scale>
        <Icon>
          <href>https://myapp33bucket.s3.amazonaws.com/pin.png</href>
        </Icon>
        <hotSpot x="0.5" y="0.5" xunits="fraction" yunits="fraction"/>
      </IconStyle>
      <LabelStyle>
        <color>ff00ff00</color>
        <scale>1.7</scale>
      </LabelStyle>
      <ListStyle>
      </ListStyle>
    </Style>
    $placemarks
    <gx:Tour>
      <name>Orbit</name>
      <gx:Playlist> 
        $content
      </gx:Playlist>
    </gx:Tour>
  </Document>
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
                  <latitude>${places[i].latitude - 0.0}</latitude>d
                  <heading>$heading</heading>
                  <tilt>60</tilt>
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
