import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:async_generator_builder/async_generator_builder.dart';

void main() {
  testWidgets('Future', (tester) async {
    await tester.pumpWidget(_buildWidget(
      FutureGeneratorBuilder(
        generator: () => _futureGenerator(),
        waiting: (_) => const Text('waiting'),
        done: (_, value) => Text('$value'),
        error: (_, error, __) => Text('$error'),
      ),
    ));

    expect(tester.widget<Text>(find.byType(Text)).data, equals('waiting'));

    await tester.pump(Duration.zero);

    expect(tester.widget<Text>(find.byType(Text)).data, equals('42'));
  });

  testWidgets('Stream', (tester) async {
    await tester.pumpWidget(_buildWidget(
      StreamGeneratorBuilder(
        generator: () => _streamGenerator(),
        waiting: (_) => const Text('waiting'),
        active: (_, value) => Text('$value'),
        done: (_, value) => Text('$value'),
        error: (_, error, __) => Text('$error'),
      ),
    ));

    expect(tester.widget<Text>(find.byType(Text)).data, equals('waiting'));

    await tester.pump(Duration.zero);

    expect(tester.widget<Text>(find.byType(Text)).data, equals('42'));
  });
}

Future<int> _futureGenerator() async {
  await Future.delayed(Duration.zero);
  return 42;
}

Stream<int> _streamGenerator() async* {
  await Future.delayed(Duration.zero);
  yield 42;
}

Widget _buildWidget(Widget child) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: child,
  );
}
