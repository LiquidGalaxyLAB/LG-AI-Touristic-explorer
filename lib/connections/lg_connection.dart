import 'dart:io';

import 'package:dartssh2/dartssh2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LGConnection {
  SSHClient? _client;
  late String _host;
  late String _port;
  late String _username;
  late String _passwordOrKey;
  late String _numberOfRigs;

  Future<void> initConnectionDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _host = prefs.getString('ipAddress') ?? '192.168.56.101';
    _port = prefs.getString('sshPort') ?? '22';
    _username = prefs.getString('username') ?? 'lg';
    _passwordOrKey = prefs.getString('password') ?? 'lg';
    _numberOfRigs = prefs.getString('numberOfRigs') ?? '3';
  }

  Future<bool?> connectToLG() async {
    await initConnectionDetails();
    try {
      _client = SSHClient(await SSHSocket.connect(_host, int.parse(_port)),
          username: _username, onPasswordRequest: () => _passwordOrKey);
      return true;
    } on SocketException catch (e) {
      print('Failed to connect: $e');
      return false;
    }
  }

  rebootLG() async {
    try {
      connectToLG();

      for (int i = int.parse(_numberOfRigs); i > 0; i--) {
        await _client!.execute(
            'sshpass -p $_passwordOrKey ssh -t lg$i "echo $_passwordOrKey | sudo -S reboot"');
      }
      return null;
    } catch (e) {
      print("An error occurred while executing the command: $e");
      return null;
    }
  }

  relaunchLG() async {
    try {
      connectToLG();

      final execResult = await _client!.execute("""RELAUNCH_CMD="\\
          if [ -f /etc/init/lxdm.conf ]; then
            export SERVICE=lxdm
          elif [ -f /etc/init/lightdm.conf ]; then
            export SERVICE=lightdm
          else
            exit 1
          fi
          if  [[ \\\$(service \\\$SERVICE status) =~ 'stop' ]]; then
            echo $_passwordOrKey | sudo -S service \\\${SERVICE} start
          else
            echo $_passwordOrKey | sudo -S service \\\${SERVICE} restart
          fi
          " && sshpass -p $_passwordOrKey ssh -x -t lg@lg1 "\$RELAUNCH_CMD\"""");
      return execResult;
    } catch (e) {
      print("An error occurred while executing the command: $e");
      return null;
    }
  }

  Future shutdownLG() async {
    try {
      connectToLG();

      for (var i = int.parse(_numberOfRigs); i >= 1; i--) {
        await _client!.execute(
            'sshpass -p ${_passwordOrKey} ssh -t lg$i "echo ${_passwordOrKey} | sudo -S poweroff"');
      }
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  cleanVisualization() async {
    try {
      connectToLG();

      // var a = await _client!.execute('> /var/www/html/kmls.txt');
      // return a;
      await stopOrbit();
      await _client!.execute("echo '' > /var/www/html/kmls.txt");
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  flyTo(String command) async {
    try {
      print(command);
      connectToLG();
      await _client!.execute(command);
    } catch (e) {
      print("error in flyto");
    }
  }

  Future<void> setRefresh() async {
    const search = '<href>##LG_PHPIFACE##kml\\/slave_{{slave}}.kml<\\/href>';
    const replace =
        '<href>##LG_PHPIFACE##kml\\/slave_{{slave}}.kml<\\/href><refreshMode>onInterval<\\/refreshMode><refreshInterval>2<\\/refreshInterval>';
    final command =
        'echo $_passwordOrKey | sudo -S sed -i "s/$search/$replace/" ~/earth/kml/slave/myplaces.kml';

    final clear =
        'echo $_passwordOrKey | sudo -S sed -i "s/$replace/$search/" ~/earth/kml/slave/myplaces.kml';
    try {
      connectToLG();
      for (var i = int.parse(_numberOfRigs); i >= 1; i--) {
        final clearCmd = clear.replaceAll('{{slave}}', i.toString());
        final cmd = command.replaceAll('{{slave}}', i.toString());
        String query = 'sshpass -p $_passwordOrKey ssh -t lg$i \'{{cmd}}\'';
        await _client!.execute(query.replaceAll('{{cmd}}', clearCmd));
        await _client!.execute(query.replaceAll('{{cmd}}', cmd));
      }
      rebootLG();
    } catch (e) {
      print(e);
    }
  }

  searchPlace(String placeName) async {
    try {
      connectToLG();
      final execResult =
          await _client?.execute('echo "search=$placeName" >/tmp/query.txt');
      return execResult;
    } catch (e) {
      print('An error occurred while executing the command: $e');
      return null;
    }
  }

  Future cleanBalloon() async {
    String blank = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
  <Document>
  </Document>
</kml>''';
    int rigs = (int.parse(_numberOfRigs) / 2).floor() + 1;
    try {
      connectToLG();
      return await _client!
          .execute("echo '$blank' > /var/www/html/kml/slave_$rigs.kml");
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  buildOrbit(String content) async {
    String localPath = await _localPath;
    File localFile = File('$localPath/Orbit.kml');
    localFile.writeAsString(content);
    try {
      connectToLG();
      await _client!.run('echo "" > /tmp/query.txt');
      await _client!.run("echo '$content' > /var/www/html/Orbit.kml");
      await _client!.execute(
          "echo '\nhttp://lg1:81/Orbit.kml' >> /var/www/html/kmls.txt");

      return await _client!.execute('echo "playtour=Orbit" > /tmp/query.txt');
    } catch (e) {
      print('Error in building orbit');
      return Future.error(e);
    }
  }

  startOrbit() async {
    try {
      return await _client!.execute('echo "playtour=Orbit" > /tmp/query.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  stopOrbit() async {
    try {
      return await _client!.execute('echo "exittour=true" > /tmp/query.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  cleanOrbit() async {
    try {
      return await _client!.execute('echo "" > /tmp/query.txt');
    } catch (e) {
      print('Could not connect to host LG');
      return Future.error(e);
    }
  }

  openBalloon(String name, String track, String time, int height,
      String description, double cityLat, double cityLng) async {
    int rigs = (int.parse(_numberOfRigs) / 2).floor() + 1;
    String openBalloonKML = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
<Document>
	<name>$name.kml</name>
	<Style id="purple_paddle">
		<BalloonStyle>
			<text>\$[description]</text>
      <bgColor>4169E11e</bgColor>
		</BalloonStyle>
	</Style>
	<Placemark id="0A7ACC68BF23CB81B354">
		<name>$track</name>
		<Snippet maxLines="0"></Snippet>
		<description><![CDATA[
<div style="display: flex; justify-content: center;">
  <div style="width: 400px; padding: 10px; font-family: Arial, sans-serif;">
    <div style="background-color: #f5f5f5; padding: 10px; border-radius: 10px; text-align: center;">
      <img src="https://myapp33bucket.s3.amazonaws.com/geo-tale-high-resolution-logo-transparent.png" alt="picture" width="350" height="100" />
    </div>
    <div style="background-color: #f5f5f5; padding: 10px; margin-top: 10px; border-radius: 10px; text-align: center;">
      <h1 style="color: #00CC99; font-size: 24px; font-weight: bold; margin: 0;">$track</h1>
      <h1 style="color: #00CC99; font-size: 18px; margin: 5px 0;">$time</h1>
    </div>
    <div style="background-color: #f5f5f5; padding: 10px; margin-top: 10px; border-radius: 10px; text-align: center;">
      <h2 style="color: #3399CC; font-size: 16px; font-weight: bold; margin: 0;">$description</h2>
    </div>
  </div>
</div>

]]></description>
		<LookAt>
			<longitude>${cityLng}</longitude>
			<latitude>${cityLat}</latitude>
			<altitude>0</altitude>
			<heading>0</heading>
			<tilt>0</tilt>
			<range>24000</range>
		</LookAt>
		<styleUrl>#purple_paddle</styleUrl>
		<gx:balloonVisibility>1</gx:balloonVisibility>
		<Point>
			<coordinates>${cityLat},${cityLng},0</coordinates>
		</Point>
	</Placemark>
</Document>
</kml>
''';
    try {
      connectToLG();
      return await _client!.execute(
          "echo '$openBalloonKML' > /var/www/html/kml/slave_$rigs.kml");
    } catch (e) {
      return Future.error(e);
    }
  }
}
