import 'dart:io';

List<String> processInput(String input) {
  final instructions = <String>[];
  final matches = RegExp(r"(mul\(\d+,\d+\))|(don't\(\))|(do\(\))").allMatches(input);

  for (RegExpMatch match in matches) {
    final instruction = input.substring(match.start, match.end).trim();
    instructions.add(instruction);
  }

  return instructions;
}

void exec() {
  final instructions = processInput(File("lib/daythree/parttwo/input.txt").readAsStringSync());

  int total = 0;
  bool mulEnabled = true; // Starts enabled

  for (String ins in instructions) {
    if (ins.startsWith("mul")) {
      if (!mulEnabled) continue;

      final digits = RegExp(r"\d+").allMatches(ins);

      final first = int.parse(ins.substring(digits.first.start, digits.first.end).trim());
      final second = int.parse(ins.substring(digits.last.start, digits.last.end).trim());
      total += first * second;
    }
    else if (ins.startsWith("don't")) {
      mulEnabled = false;
    }
    else if (ins.startsWith("do")) {
      mulEnabled = true;
    }
  }

  print(total);
}