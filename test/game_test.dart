import 'package:flutter_test/flutter_test.dart';
import 'package:kart_motoru/kart_motoru.dart';
import 'package:oyun_kart_karesi/oyun_kart_karesi.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('33 dilde ad ve anlatım', () {
    expect(kartKaresiConfig.title.length, 33);
    expect(kartKaresiConfig.tagline.length, 33);
    for (final s in kartKaresiConfig.tutorial) {
      expect(s.text.length, 33);
    }
  });

  test('bölümler çözülebilir', () {
    final planner = LevelPlanner(gameId: kartKaresiId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = kartKaresiRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      final g = SquareGame(gl.puzzle);
      var guard = 0;
      while (!g.won && guard++ < 100) {
        final h = g.hint()!;
        g.put(h.$1, h.$2);
      }
      expect(g.won, isTrue);
    }
  });
}
