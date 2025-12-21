import 'dart:math';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:forge2d/forge2d.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../extension/timer_extension.dart';

class BouncingBallContainer extends StatefulWidget {
  const BouncingBallContainer({
    super.key,
    required this.containerSize,
    required this.ballOptions,
  });

  final Size containerSize;
  final List<BallOption> ballOptions;

  @override
  State<BouncingBallContainer> createState() {
    return _BouncingBallContainerState();
  }
}

class _BouncingBallContainerState extends State<BouncingBallContainer>
    with SingleTickerProviderStateMixin {
  late final BouncingBallController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BouncingBallController(
      vsync: this,
      containerSize: widget.containerSize,
      ballOptions: widget.ballOptions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.containerSize,
      painter: PhysicsBallPainter(
        controller: _controller,
      ),
    );
  }
}

class PhysicsBallPainter extends CustomPainter {
  const PhysicsBallPainter({required this.controller})
    : super(repaint: controller);

  final BouncingBallController controller;

  @override
  bool shouldRepaint(PhysicsBallPainter oldDelegate) {
    return true; // 항상 다시 그리기
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    final double scale = controller.scale;

    for (final body in controller.currentBalls) {
      final Shape shape = body.fixtures.first.shape;
      final BallOption option = body.userData as BallOption; // 캐스팅 명시

      // 공의 실제 반지름(픽셀 단위) 및 중심 좌표 계산
      final Offset centerOffset =
          Offset(body.position.x, body.position.y) * scale;
      final double radius = shape.radius * scale;

      canvas.drawCircle(
        centerOffset,
        radius,
        Paint()
          ..color = option.color
          ..style = PaintingStyle.fill,
      );

      if (option.pictureInfo != null) {
        canvas.save(); // 현 상태 저장

        // [순서 A] 공의 중심으로 캔버스 이동
        canvas.translate(centerOffset.dx, centerOffset.dy);

        // [순서 B] 공의 회전 적용
        canvas.rotate(body.angle);

        // [순서 C] 아이콘 크기 압축 (여기서 비대한 크기가 공 크기로 줄어듦)
        final double iconTargetSize = radius * 2 * 0.7; // 공 지름의 70%
        final double svgWidth = option.pictureInfo!.size.width;

        canvas.scale(iconTargetSize / svgWidth);

        // [순서 D] 중심점 보정 (이제 자(Ruler)가 줄어들었으므로 원본 크기의 절반만큼만 이동)
        // [주의] 이 줄을 drawPicture보다 반드시 먼저 실행해야 합니다.
        canvas.translate(-svgWidth / 2, -svgWidth / 2);

        // [순서 E] 드디어 그리기
        // 이 시점의 캔버스는 이미 공 중심에 있고, 회전되어 있으며, 크기도 공에 맞춰 압축된 상태입니다.
        canvas.drawPicture(option.pictureInfo!.picture);

        canvas.restore(); // 다음 공을 위해 캔버스 복구
      }
    }
  }
}

class BouncingBallController extends ChangeNotifier with LeadingDebounce {
  final double gravity;
  final double scale;
  final Size containerSize;
  final List<BallOption> ballOptions;

  Ticker? _ticker;
  World? _world;

  BouncingBallController({
    this.gravity = 15.0,
    this.scale = 100.0,
    required this.containerSize,
    required this.ballOptions,
    required TickerProvider vsync,
  }) {
    _world = World(Vector2(0, gravity));
    _ticker = vsync.createTicker(_tick);
    _createBoundaries();
    _ticker?.start();
  }

  List<Body> get currentBalls {
    return [
      ...?_world?.bodies
          .where((body) => body.userData is BallOption)
          .where((body) => body.bodyType == BodyType.dynamic),
    ];
  }

  bool get isAllBallsDisplayed {
    return ballOptions.length <= currentBalls.length;
  }

  bool get _isWorldSleeping {
    return currentBalls.every((body) => !body.isAwake);
  }

  Future<void> _tick(Duration elapsed) async {
    final bool isAllBallsDisplayed = this.isAllBallsDisplayed;

    if (isAllBallsDisplayed && _isWorldSleeping) {
      _ticker?.stop();
      return;
    }

    _world?.stepDt(1 / 60);
    debounce(_spawnBall, 30.milliseconds);
    notifyListeners();
  }

  void _createBoundaries() {
    if (_world == null || _world!.bodies.length > 1) {
      return;
    }

    final double halfWidth = (containerSize.width / scale) / 2;
    final double halfHeight = (containerSize.height / scale) / 2;

    final Shape containerShape = ChainShape()
      ..createChain([
        Vector2(-halfWidth, -halfHeight), // 왼쪽 위
        Vector2(-halfWidth, halfHeight), // 왼쪽 아래
        Vector2(halfWidth, halfHeight), // 오른쪽 아래
        Vector2(halfWidth, -halfHeight), // 오른쪽 위
      ]);

    _world!
        .createBody(BodyDef(type: BodyType.static))
        .createFixture(FixtureDef(containerShape, friction: 0.5));
  }

  void _spawnBall() {
    final int currentBallCount = currentBalls.length;

    if (currentBallCount >= ballOptions.length) {
      return;
    }

    final double halfWidth = (containerSize.width / scale) / 2;
    final double halfHeight = (containerSize.height / scale) / 2;

    final double randomPercent = Random().nextDouble().clamp(0.4, 0.6);
    final double xPos = lerpDouble(-halfWidth, halfWidth, randomPercent)!;
    final double yPos = -halfHeight - 3.0; // - 3.0: 컨테이너 영역 위쪽 바깥에서 생성

    final BallOption ballOption = ballOptions.elementAt(currentBallCount);

    _world!
        .createBody(
          BodyDef(
            position: Vector2(xPos, yPos),
            type: BodyType.dynamic,
            userData: ballOption,
          ),
        )
        .createFixture(
          FixtureDef(
            CircleShape(radius: ballOption.radius),
            density: 1.0,
            friction: 0.5,
            restitution: 0.3,
          ),
        );
  }

  @override
  void dispose() {
    _ticker?.dispose();
    debounceTimer?.cancel();
    super.dispose();
  }
}

class BallOption {
  final double width;
  final Color color;
  final PictureInfo? pictureInfo;

  const BallOption({
    required this.width,
    required this.color,
    this.pictureInfo,
  });

  BallOption.randomColor({
    required this.width,
    this.pictureInfo,
  }) : color = Color.fromARGB(
          255,
          Random().nextInt(200) + 50,
          Random().nextInt(200) + 50,
          Random().nextInt(200) + 50,
        );

  double get radius {
    return width / 2;
  }
}
