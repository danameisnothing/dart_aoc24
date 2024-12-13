import 'dart:io';

void exec() {
  final input = File("lib/daytwo/parttwo/input.txt").readAsLinesSync();

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
    final areReportsIncreasing = <bool>[];
    int usedChance = 0;
    for (int i = 1; i < report.length; i++) {
      final elBefore = report.elementAt(i - 1);
      final elNow = report.elementAt(i);

      final delta = elNow - elBefore;

      // Only do this at start of each report
      areReportsIncreasing.add((!delta.isNegative && delta.sign != 0) ? true : false);
    }

    // The first thing I've thought of that is easy-ish
    // To deal with the wrong values at start
    final howManyTrue = areReportsIncreasing.where((x) => x == true).length;
    final howManyFalse = areReportsIncreasing.where((x) => x == false).length;

    assert(howManyTrue.compareTo(howManyFalse) != 0, "Report $report has same amount of instances where value is increasing and decreasing.");

    bool areMajorityReportsIncreasing = (!howManyTrue.compareTo(howManyFalse).isNegative) ? true : false;

    print("$areReportsIncreasing for report $report with result is $areMajorityReportsIncreasing for areMajorityIncreasing");

    continue;

    /*for (int i = 1; i < report.length; i++) {
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
        report.removeAt(i);
        i--;
        usedChance++;
        print("$usedChance");
      }
    }*/
    if (usedChance <= 1) total++;
  }

  //print(total);
}