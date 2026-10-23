import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab5/main.dart';

void main() {
  testWidgets('Photo app starts', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: PhotoApp()));

    expect(find.text('Danh sách Photo'), findsOneWidget);
  });
}
