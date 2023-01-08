part of 'document_viewer_screen.dart';

extension DocumentReaderAction on _DocumentViewerScreenState {
  Future<Uint8List?> getDataFrom({required String url}) async {
    if (url.contains('http')) {
      final request = await HttpClient().getUrl(Uri.parse(url));
      final response = await request.close();
      final data = await consolidateHttpClientResponseBytes(response);

      return data;
    }
    return null;
  }
}
