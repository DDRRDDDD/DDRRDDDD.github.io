import 'dart:math';
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.applyBlast(details.localPosition);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: _onTapDown,
        child: CustomPaint(
          size: widget.containerSize,
          painter: PhysicsBallPainter(
            controller: _controller,
          ),
        ),
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
      final BallOption option = body.userData as BallOption;

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

      canvas.save();

      final double iconTargetSize = radius * 2 * 0.7; // 공 지름의 70%
      final double svgWidth = option.pictureInfo.size.width;

      canvas.translate(centerOffset.dx, centerOffset.dy);
      canvas.rotate(body.angle);
      canvas.scale(iconTargetSize / svgWidth);
      canvas.translate(-svgWidth / 2, -svgWidth / 2);
      canvas.drawPicture(option.pictureInfo.picture);

      canvas.restore();
    }
  }
}

class BouncingBallController extends ChangeNotifier with LeadingDebounce {
  static const double defaultScale = 100.0;

  final double gravity;
  final double scale;
  final Size containerSize;
  final List<BallOption> ballOptions;

  Ticker? _ticker;
  World? _world;
  bool _isLidClosed = false;

  BouncingBallController({
    this.gravity = 25.0,
    this.scale = defaultScale,
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

  void applyBlast(Offset localPosition) {
    if (_world == null || !_isLidClosed) {
      return;
    }

    final double worldX = (localPosition.dx - containerSize.width / 2) / scale;
    final double worldY = (localPosition.dy - containerSize.height / 2) / scale;

    final Vector2 blastPoint = Vector2(worldX, worldY);

    const double blastForce = 15.0;
    const double blastRadius = 4.0;

    _world!.queryAABB(
      BlastQueryCallback(
        blastPoint: blastPoint,
        blastRadius: blastRadius,
        blastForce: blastForce,
      ),
      AABB()
        ..lowerBound.setValues(
          blastPoint.x - blastRadius,
          blastPoint.y - blastRadius,
        )
        ..upperBound.setValues(
          blastPoint.x + blastRadius,
          blastPoint.y + blastRadius,
        ),
    );

    if (_ticker?.isActive == false) {
      _ticker?.start();
    }
  }

  Future<void> _tick(Duration elapsed) async {
    if (isAllBallsDisplayed && _isWorldSleeping) {
      _closeLid();
      _ticker?.stop();
      return;
    }

    _world?.stepDt(1 / 60);
    debounce(_spawnBall, 80.milliseconds);
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

  void _closeLid() {
    if (_isLidClosed || _world == null || !isAllBallsDisplayed) {
      return;
    }

    final double halfWidth = (containerSize.width / scale) / 2;
    final double halfHeight = (containerSize.height / scale) / 2;

    final Shape lidShape = EdgeShape()
      ..set(
        Vector2(-halfWidth, -halfHeight),
        Vector2(halfWidth, -halfHeight),
      );

    _world!
        .createBody(BodyDef(type: BodyType.static))
        .createFixture(FixtureDef(lidShape, friction: 0.5, restitution: 0.2));
    _isLidClosed = true;
  }

  void _spawnBall() {
    final int currentBallCount = currentBalls.length;

    if (currentBallCount >= ballOptions.length) {
      return;
    }

    final double halfWidth = (containerSize.width / scale) / 2;
    final double halfHeight = (containerSize.height / scale) / 2;

    final double randomPercent = Random().nextDouble().clamp(0.3, 0.7);
    final double xPos = lerpDouble(-halfWidth, halfWidth, randomPercent)!;
    final double yPos = -halfHeight - 1.0; // - 1.0: 컨테이너 영역 위쪽 바깥에서 생성

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

/// 폭발 로직을 담당하는 QueryCallback 구현체 정의
class BlastQueryCallback extends QueryCallback {
  final Vector2 blastPoint;
  final double blastRadius;
  final double blastForce;

  BlastQueryCallback({
    required this.blastPoint,
    required this.blastRadius,
    required this.blastForce,
  });

  @override
  bool reportFixture(Fixture fixture) {
    final Body body = fixture.body;

    // 두 점 사이의 벡터 및 거리 계산
    final Vector2 direction = body.position - blastPoint;
    final double distance = direction.length;

    // 실제 원형 범위 내에 있는지 확인
    if (distance < blastRadius && distance > 0) {
      // 거리에 따른 힘의 감쇄 (가까울수록 강함)
      final double forceMagnitude = (1 - (distance / blastRadius)) * blastForce;

      // 벡터 정규화 및 충격량 계산
      // (direction / distance)는 정규화된 방향 벡터
      final Vector2 impulse = direction..scale(forceMagnitude / distance);

      // 잠든 바디를 깨우고 물리적인 힘 적용
      body.setAwake(true);
      body.applyLinearImpulse(impulse);
    }

    // true를 반환해야 범위 내의 다음 Fixture를 계속 탐색함
    return true;
  }
}

class BallOption {
  final double width;
  final Color color;
  final PictureInfo pictureInfo;

  const BallOption({
    required this.width,
    required this.color,
    required this.pictureInfo,
  });

  double get radius {
    return width / 2;
  }
}
