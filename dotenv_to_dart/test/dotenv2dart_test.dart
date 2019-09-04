import 'package:dotenv2dart/dotenv2dart.dart';
import 'package:test/test.dart';

void main() {
  group('generate dart types from text', () {
    DotEnvGenerator _generator;

    setUp(() {
      _generator = DotEnvGenerator();
    });

    test('can generate int constant', () {
      var buffer = StringBuffer();
      final mockText = '''
      myBuildNumber=1
      ''';

      _generator.fromText(mockText, buffer);
      expect(buffer.toString(), "const MY_BUILD_NUMBER = 1;");
    });

    test('can generate string constant', () {
      var buffer = StringBuffer();
      final mockText = '''
      mySecret=9afffqsdqaios99123
      ''';

      _generator.fromText(mockText, buffer);
      expect(buffer.toString(), 'const MY_SECRET = "9afffqsdqaios99123";');
    });
  });
}
