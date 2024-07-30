import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';

extension SizedBoxPadding on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}

downloadKml(String url, String filename, String directoryName) async {
  await FileDownloader().download(
    DownloadTask(
      url: url,
      filename: '$filename.kml',
      updates: Updates.statusAndProgress,
      directory: directoryName,
      requiresWiFi: false,
      retries: 5,
      allowPause: true,
    ),
    onProgress: (progress) {
      print(progress);
    },
  );
}
