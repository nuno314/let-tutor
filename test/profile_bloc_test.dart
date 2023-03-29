import 'package:extended_image/extended_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart' as dio_p;
import 'package:let_tutor/data/models/user.dart';
import 'package:mockito/mockito.dart';
import 'package:let_tutor/data/data_source/remote/rest_api_repository/rest_api_repository.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements Client {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final RestApiRepository restApi;
  late final MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    restApi = RestApiRepository(dio_p.Dio(dio_p.BaseOptions(
      followRedirects: false,
      receiveTimeout: 30000, // 30s
      sendTimeout: 30000, // 30s
    )));
  });

  test('get profile', () async {
    // Given
    when(mockClient
            .get(Uri.parse('https://sandbox.api.lettutor.com/user/info')))
        .thenAnswer(
      (answer) async {
        print(answer);
        return http.Response('', 200);
      },
    );
    // When
    final res = await restApi.getUserInfomation({});
    // Then
    expect(res?.user, isA<User>());
  });
}
