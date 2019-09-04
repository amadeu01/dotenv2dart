import 'dart:convert';

import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:recase/recase.dart';

Builder dotEnv2DartBuilder(BuilderOptions options) => DotEnv2DartBuilder();

class DotEnv2DartBuilder extends Builder {
  @override
  Map<String, List<String>> get buildExtensions => const <String, List<String>>{
        '.env': <String>['dot_env.dart']
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    var paths = buildStep.inputId.pathSegments;
    paths.removeLast();
    final path =
        paths.reduce((value, element) => "$value/$element") + "/dot_env.dart";
    final AssetId outputId = AssetId(buildStep.inputId.package, path);

    final String dotEntContent =
        await buildStep.readAsString(buildStep.inputId);

    final StringBuffer output = StringBuffer();
    DotEnvGenerator().fromText(dotEntContent, output);
    await buildStep.writeAsString(outputId, output.toString());
  }
}

@visibleForTesting
class DotEnvGenerator {
  void fromText(String text, StringBuffer buffer) {
    LineSplitter ls = LineSplitter();
    List<String> lines = ls.convert(text);
    lines.map((l) => l.trim()).where((l) => l.isNotEmpty).forEach((line) {
      final elements = line.trim().split("=");
      final variableName = ReCase(elements[0]).constantCase;
      final variableValue =
          _isNumeric(elements[1]) ? elements[1] : '"${elements[1]}"';
      buffer.write('const $variableName = $variableValue;');
      buffer.write('\n');
    });
  }
}

bool _isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
