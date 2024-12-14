import 'dart:io';

import 'package:collection/collection.dart';

void execD5P1() {
  final input = File("lib/solutions/dayfive/partone/input.txt").readAsLinesSync();

  final splitPoint = input.indexOf("");
  final orderingRules = input.sublist(0, splitPoint);
  final pageNumbersSection = input.sublist(splitPoint + 1, input.length);

  final correctNumbers = <List<String>>[];

  for (String e in pageNumbersSection) {
    final pageNumbers = e.split(",");
    /// A list which contains a rule that only needs to contain just one of the current filter (e.g. filter is 25, 7, 6. Data is 25|9, 27|8, 17|7. 25|9 and 17|7 would pass)
    final filteredRules = orderingRules.where((f) => RegExp("(${pageNumbers.join(")|(")})").hasMatch(f)).toList();

    /// A list with each rule having to contain 2 of the current filter (e.g. filter is 25, 7, 6.  Data is 25|9, 27|8, 17|7, 6|7. Only 6|7 would pass)
    final containsAll = filteredRules.where((g) {
      final result = <bool>[];
      for (String number in pageNumbers) {
        result.add(g.contains(number));
      }
      return result.where((x) => x == true).length == 2;
    }).toList();

    final encounters = <String, int>{};
    for (String el in containsAll) {
      final firstNum = el.substring(0, 2); // Assuming that each number is 2 digits long
      encounters[firstNum] = (encounters[firstNum] ?? 0) + 1;
    }
    final notEncountered = pageNumbers.where((x) => !encounters.containsKey(x)).toList();

    /// Turns each entry inside a list, which we then sort from highest to lowest
    final sortedNumberKeyTmp = encounters.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final sortedNumberKey = sortedNumberKeyTmp.map((data) => data.key).toList(); // I forgot how to do this in one line with Dart :(

    sortedNumberKey.addAll(notEncountered);

    if (ListEquality().equals(sortedNumberKey, pageNumbers) == true) correctNumbers.add(sortedNumberKey);
  }

  int total = 0;

  for (final numbers in correctNumbers) {
    total += int.parse(numbers.elementAt((numbers.length / 2).floor()));
  }

  print(total);
}