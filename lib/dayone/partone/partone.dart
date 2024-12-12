import 'dart:io';

void exec() {
  final input = File("lib/dayone/partone/input.txt").readAsLinesSync();

  final firstEls = <int>[];
  final secEls = <int>[];

  for (String str in input) {
    str = str.trim(); // yikes
    
    final matches = RegExp(r"\S+").allMatches(str);

    final firstEl = matches.elementAt(0);
    final secEl = matches.elementAt(1);

    final first = str.substring(firstEl.start, firstEl.end).trim();
    final second = str.substring(secEl.start, secEl.end).trim();

    firstEls.add(int.parse(first));
    secEls.add(int.parse(second));
  }

  firstEls.sort();
  secEls.sort();

  int total = 0;

  assert(firstEls.length == secEls.length);

  for (int i = 0; i < firstEls.length; i++) {
    assert((secEls.elementAt(i) - firstEls.elementAt(i)).abs() >= 0);
    total += (secEls.elementAt(i) - firstEls.elementAt(i)).abs();
  }

  print(total);
}