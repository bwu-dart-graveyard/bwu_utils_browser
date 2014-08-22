library bwu_testrunner.test.content_shell_launcher.groupe_with_one_failing_test;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_config.dart' show useHtmlConfiguration;
import 'package:bwu_utils_browser/html/html.dart' as tools;

void main() {
  useHtmlConfiguration();

  group('parseInt', () {

    test('simple int', () {
      expect(tools.parseInt('0'), equals(0));
      expect(tools.parseInt('1'), equals(1));
      expect(tools.parseInt(' 1'), equals(1));
      expect(tools.parseInt('184'), equals(184));
    });

    test('with double value', () {
      expect(tools.parseInt('184.984375'), equals(185));
    });

  });
}
