import 'dart:io';

void execD2P1() {
  final input = File("lib/solutions/daytwo/partone/input.txt").readAsLinesSync();

  final reports = <List<int>>[];

  for (String str in input) {
    str = str.trim(); // yikes
    
    final matches = RegExp(r"\S+").allMatches(str);

    reports.add([]);
    for (RegExpMatch match in matches) {
      final val = str.substring(match.start, match.end).trim();
      reports.last.add(int.parse(val));
    }
  }

  int total = 0;

  for (List<int> report in reports) {
    bool isReportIncreasing = false;
    bool isSafe = true;
    for (int i = 1; i < report.length; i++) {
      final elBefore = report.elementAt(i - 1);
      final elNow = report.elementAt(i);

      final delta = elNow - elBefore;

      // Only do this at start of each report
      if (i == 1) {
        if (!delta.isNegative) {
          isReportIncreasing = true;
        }
      }

      // Check if sign is the same as initial pattern || Checks if adjacent levels differ within the threshold, the "is neither an increase or a decrease" case is already handled here
      if ((!delta.isNegative != isReportIncreasing) || (delta.abs() < 1 || delta.abs() > 3)) {
        isSafe = false;
        break;
      }
    }
    if (isSafe) total++;
  }

  print(total);
}