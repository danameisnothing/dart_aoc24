import 'dart:io';

const faultTolerance = 1;

List<List<int>> _processInput(List<String> lines) {
  final reports = <List<int>>[];
  for (String str in lines) {
    str = str.trim(); // yikes
    
    final matches = RegExp(r"\S+").allMatches(str);

    reports.add([]);
    for (RegExpMatch match in matches) {
      final val = str.substring(match.start, match.end).trim();
      reports.last.add(int.parse(val));
    }
  }

  return reports;
}

bool _getLevelIncreasingTrend(List<int> report) {
  final areReportsIncreasing = <bool>[];
  for (int i = 1; i < report.length; i++) {
    final elBefore = report.elementAt(i - 1);
    final elNow = report.elementAt(i);

    final delta = elNow - elBefore;

    // Only do this at start of each report
    areReportsIncreasing.add((!delta.isNegative) ? true : false);
  }

  // The first thing I've thought of that is easy-ish, to deal with the assumption that the start delta of each reports can have a wrong sign
  final howManyTrue = areReportsIncreasing.where((x) => x == true).length;
  final howManyFalse = areReportsIncreasing.where((x) => x == false).length;

  return (!howManyTrue.compareTo(howManyFalse).isNegative) ? true : false;
}

void execD2P2() {
  final reports = _processInput(File("lib/solutions/daytwo/parttwo/input.txt").readAsLinesSync());

  int total = 0;

  for (List<int> report in reports) {
    int totalViolations = 0;
    bool isReportIncreasing = _getLevelIncreasingTrend(report);

    // Try elBefore deletion, then elNow deletion. If both have a fault value above 1, then ignore
    // FIXME: CLEANUP
    final backupReport = List.from(report); // So it copies
    bool detectedFault = false;
    while (true) {
      detectedFault = false;
      for (int i = 1; i < report.length; i++) {
        final elBefore = report.elementAt(i - 1);
        final elNow = report.elementAt(i);

        final delta = elNow - elBefore;

        // Check if sign is the same as initial pattern || Checks if adjacent levels differ within the threshold, the "is neither an increase or a decrease" case is already handled here
        if ((!delta.isNegative != isReportIncreasing) || (delta.abs() < 1 || delta.abs() > 3)) {
          report.removeAt(i); // elNow
          totalViolations++;
          detectedFault = true;
          break;
        }
      }
      if (!detectedFault) break;
    }

    if (totalViolations > faultTolerance) {
      totalViolations = 0;
      report = List.from(backupReport);
      while (true) {
        detectedFault = false;
        for (int i = 1; i < report.length; i++) {
          final elBefore = report.elementAt(i - 1);
          final elNow = report.elementAt(i);

          final delta = elNow - elBefore;

          // Check if sign is the same as initial pattern || Checks if adjacent levels differ within the threshold, the "is neither an increase or a decrease" case is already handled here
          if ((!delta.isNegative != isReportIncreasing) || (delta.abs() < 1 || delta.abs() > 3)) {
            report.removeAt(i - 1); // elBefore
            totalViolations++;
            detectedFault = true;
            break;
          }
        }
        if (!detectedFault) break;
      }
    }

    if (totalViolations <= faultTolerance) total++;
  }

  print(total);
}