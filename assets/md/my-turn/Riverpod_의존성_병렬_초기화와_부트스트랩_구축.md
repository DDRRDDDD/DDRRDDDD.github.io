#### 🚨 직면했던 과제
> **"앱 구동 시 필수 인프라 로딩으로 인한 병목 현상"**
> * **순차적 초기화의 비효율성**: DB, 로컬 스토리지, 앱 정보 등 필수적인 비동기 의존성들을 UI 진입 후에 하나씩 로드하게 되면, 지연이 발생하여 초기 구동 속도가 느려졌습니다.
> * **불확실한 의존성 상태**: 위젯 트리 내부에서 초기화를 시도할 경우, 특정 시점에 해당 서비스가 준비되었는지 보장할 수 없어 방어 코드가 늘어나고 상태 관리가 복잡해졌습니다.

#### 🛠 문제 해결 및 구현 과정
> **💡 1단계: 시스템 인프라 부트스트랩 (System Bootstrap)**
> * **병렬 초기화**: `main` 함수 단계에서 `Future.wait`를 사용해 DB, 패키지 정보, 보안 저장소 등 5가지 핵심 인프라를 **병렬로 미리 초기화**했습니다.
>
> **💡 2단계: 콘텐츠 선행 로딩 (Content Eager Loading)**
> * **비동기 데이터의 정적화**: UI 렌더링에 필요한 주요 데이터들을 `eagerInitializers`로 정의하고, 스플래시 화면 뒤에서 미리 구독(`ref.watch`)했습니다.
> * **무중단 화면 전환**: 모든 데이터가 준비(`hasValue`)될 때까지 스플래시를 유지하다가, 완료 즉시 `AnimatedSwitcher`로 전환하여 **비동기 데이터를 마치 정적 리소스처럼 즉각적으로 렌더링**했습니다.

#### 📈 성과/개선
> * **초기 구동 속도 최적화** : 핵심 의존성들을 동시에 로드함으로써 앱 실행에 필요한 준비 시간을 단축했습니다.
> * **안정적인 데이터 보장** : 앱이 화면에 그려지는 시점에는 모든 인프라가 100% 준비된 상태임을 기술적으로 보장하여, UI 코드 내의 **불필요한 로딩 분기 처리를 제거**했습니다.

```dart
final ProviderContainer globalContainer = ProviderContainer();

Future<void> runMyTurnApp(Widget app) async {
  await Future.wait([
    globalContainer.read(packageInfoProvider.future),
    globalContainer.read(supabaseDataSourceProvider.future),
    globalContainer.read(secureStorageProvider.future),
    globalContainer.read(localStorageProvider.future),
    globalContainer.read(jsonStorageProvider.future),
  ]);

  runApp(
    UncontrolledProviderScope(
      container: globalContainer,
      /// `main.dart`에서 설정한 전역 구성(테마, 로케일, 네비게이션 등)과 함께 앱 루트 위젯을 전달합니다.
      child: app,
    ),
  );
}
```
```dart
class RiverpodAppInitializer extends ConsumerWidget {
  const RiverpodAppInitializer({
    super.key,
    this.eagerInitializers = const [],
    required this.builder,
  });

  final List<ProviderListenable<AsyncValue>> eagerInitializers;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isReady = eagerInitializers
        .map(ref.watch)
        .every((value) => value.hasValue);

    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: isReady
          ? Builder(builder: builder)
          : const SplashScreen(),
    );
  }
}
```