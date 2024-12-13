import 'dart:io';

void execD3P1() {
  final input = File("lib/solutions/daythree/partone/input.txt").readAsStringSync();

  final filter = RegExp(r"mul\(\d+,\d+\)");
  final matches = filter.allMatches(input);

  int total = 0;

  for (RegExpMatch match in matches) {
    final instruction = input.substring(match.start, match.end).trim();

    final digits = RegExp(r"\d+").allMatches(instruction);

    final first = int.parse(instruction.substring(digits.first.start, digits.first.end).trim());
    final second = int.parse(instruction.substring(digits.last.start, digits.last.end).trim());

    total += first * second;
  }

  print(total);
}