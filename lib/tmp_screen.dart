import 'dart:math';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
// 1. Design System & Theme
// -----------------------------------------------------------------------------

class PortfolioColors {
  static const primary = Color(0xFF02569B); // Flutter Blue
  static const lightBlue = Color(0xFF42A5F5);
  static const darkBlue = Color(0xFF013E73);

  // Light Mode
  static const bgLight = Color(0xFFF9FAFB);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const textMainLight = Color(0xFF1F2937);
  static const textSubLight = Color(0xFF4B5563);
  static const borderLight = Color(0xFFE5E7EB);

  // Dark Mode
  static const bgDark = Color(0xFF111827);
  static const surfaceDark = Color(0xFF1F2937);
  static const textMainDark = Color(0xFFF3F4F6);
  static const textSubDark = Color(0xFFD1D5DB);
  static const borderDark = Color(0xFF374151);
}

class AppTheme {
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: PortfolioColors.bgLight,
    primaryColor: PortfolioColors.primary,
    cardColor: PortfolioColors.surfaceLight,
    dividerColor: PortfolioColors.borderLight,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: PortfolioColors.textMainLight, fontWeight: FontWeight.w900),
      bodyLarge: TextStyle(color: PortfolioColors.textSubLight),
      bodyMedium: TextStyle(color: PortfolioColors.textSubLight),
    ),
    colorScheme: const ColorScheme.light(
      primary: PortfolioColors.primary,
      secondary: PortfolioColors.lightBlue,
      surface: PortfolioColors.surfaceLight,
    ),
  );

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: PortfolioColors.bgDark,
    primaryColor: PortfolioColors.primary,
    cardColor: PortfolioColors.surfaceDark,
    dividerColor: PortfolioColors.borderDark,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: PortfolioColors.textMainDark, fontWeight: FontWeight.w900),
      bodyLarge: TextStyle(color: PortfolioColors.textSubDark),
      bodyMedium: TextStyle(color: PortfolioColors.textSubDark),
    ),
    colorScheme: const ColorScheme.dark(
      primary: PortfolioColors.primary,
      secondary: PortfolioColors.lightBlue,
      surface: PortfolioColors.surfaceDark,
    ),
  );
}

// -----------------------------------------------------------------------------
// 2. Main App Structure
// -----------------------------------------------------------------------------

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dev Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      home: HomePage(onThemeToggle: toggleTheme),
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const HomePage({super.key, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildNavBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const HeroSection(),
            const AboutSection(),
            const ProjectSection(),
            const LabSection(),
            const InteractiveSkillSection(),
            const FooterSection(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildNavBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          const Icon(Icons.flutter_dash, color: PortfolioColors.primary),
          const SizedBox(width: 8),
          Text(
            'Dev.Seungyn',
            style: TextStyle(
              color: isDark ? PortfolioColors.textMainDark : PortfolioColors.textMainLight,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          color: isDark ? Colors.yellow : Colors.grey,
          onPressed: onThemeToggle,
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 3. Components (Chips, Cards)
// -----------------------------------------------------------------------------

enum ChipType { primary, neutral }

class PortfolioChip extends StatelessWidget {
  final String label;
  final ChipType type;

  const PortfolioChip({
    super.key,
    required this.label,
    this.type = ChipType.neutral,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color bgColor, borderColor, textColor;

    if (type == ChipType.primary) {
      bgColor = isDark ? const Color(0xFF1E3A8A).withOpacity(0.3) : const Color(0xFFDBEAFE);
      borderColor = isDark ? const Color(0xFF1E40AF) : const Color(0xFFBFDBFE);
      textColor = isDark ? const Color(0xFF93C5FD) : PortfolioColors.primary;
    } else {
      bgColor = isDark ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6);
      borderColor = isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB);
      textColor = isDark ? const Color(0xFFD1D5DB) : const Color(0xFF374151);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 4. Sections
// -----------------------------------------------------------------------------

// --- Hero Section ---
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text Area
          Expanded(
            flex: isDesktop ? 5 : 0,
            child: Column(
              crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
                  children: const [
                    PortfolioChip(label: '소통을 설계하는 아키텍처', type: ChipType.primary),
                    PortfolioChip(label: '집요한 문제 해결', type: ChipType.neutral),
                  ],
                ),
                const SizedBox(height: 24),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: '핑계 대신 결과로,\n'),
                      TextSpan(
                        text: '반드시 해냅니다.',
                        style: TextStyle(color: PortfolioColors.primary),
                      ),
                    ],
                  ),
                  textAlign: isDesktop ? TextAlign.start : TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: isDesktop ? 60 : 36,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '아키텍처는 코드의 구조를 넘어선 팀의 공통 언어입니다.\n기획의 빈틈을 메우는 TDD, Atomic Design, Clean Architecture로\n빈틈없이 소통하고 문제를 해결합니다.',
                  textAlign: isDesktop ? TextAlign.start : TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 32),
                Wrap(
                  spacing: 16,
                  alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PortfolioColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('프로젝트 보기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text('이력서 다운로드', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
              ],
            ),
          ),
          if (isDesktop) const SizedBox(width: 40),
          if (!isDesktop) const SizedBox(height: 60),
          // Rive Avatar Placeholder
          Expanded(
            flex: isDesktop ? 5 : 0,
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue.shade50, Theme.of(context).scaffoldBackgroundColor],
                  ),
                  border: Border.all(color: Colors.grey.withOpacity(0.2), width: 4),
                  boxShadow: [
                    BoxShadow(color: PortfolioColors.primary.withOpacity(0.2), blurRadius: 40, spreadRadius: 10),
                  ],
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.face, size: 80, color: PortfolioColors.primary),
                    SizedBox(height: 16),
                    Text('Rive Avatar Area', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- About Section ---
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      width: double.infinity,
      child: Column(
        children: [
          const Text('Core Competencies', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(width: 60, height: 4, color: PortfolioColors.primary),
          const SizedBox(height: 40),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: const [
              CompetencyCard(
                icon: Icons.bolt,
                color: Colors.orange,
                title: 'Tenacity for Optimization',
                desc: "렌더링 부하 90% 감소, 리소스 용량 50% 절감 등 수치로 증명될 때까지 집요하게 파고들어 최적화를 해냅니다.",
              ),
              CompetencyCard(
                icon: Icons.group_work,
                color: Colors.green,
                title: 'Architecture for Team',
                desc: "아키텍처는 협업의 기준입니다. TDD, Atomic Design, Clean Architecture를 통해 명확한 소통을 주도합니다.",
                /// 아키텍처는 협업의 근거가 된다고 생각합니다
                /// 아키텍처는 대화의 근거가 된다고 생각합니다 같은 개발자는 물론이고 비개발자와도 명확한 소통을 주도합니다.
              ),
              CompetencyCard(
                icon: Icons.code,
                color: Colors.purple,
                title: 'Active Contribution',
                desc: "혼자 해결하는 것을 넘어 생태계에 기여합니다. WebDriverManager 공식 프로젝트에 기여하며 함께 성장합니다.",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CompetencyCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String desc;

  const CompetencyCard({super.key, required this.icon, required this.color, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 24),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(desc, style: const TextStyle(height: 1.6)),
        ],
      ),
    );
  }
}

// --- Project Section (Evolution) ---
class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          const Text('Main Projects', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('출시의 경험을 넘어, 기술적 완성도에 집중한 성장 기록입니다.'),
          const SizedBox(height: 60),

          // Project 1
          const ProjectCard(
            title: '프로젝트 A (Meeting App)',
            tag: 'Released',
            desc: '"만남"을 주제로 한 첫 번째 앱. Socket.io로 실시간 채팅 구현 및 배포 완료.',
            techs: ['Socket.io', 'Provider', 'FCM'],
            isLeft: true,
            icon: Icons.favorite,
            color: Colors.pink,
          ),

          // Connector Line
          SizedBox(
            height: 60,
            child: Stack(
              alignment: Alignment.center,
              children: [
                VerticalDivider(thickness: 2, color: Theme.of(context).dividerColor),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Pivot & Technical Deep Dive', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),

          // Project 2
          const ProjectCard(
            title: '보드게임 파티 (Pivot Project)',
            tag: 'Technical Masterpiece',
            desc: 'SVG 렌더링 부하 90% 개선, 아키텍처 재설계. 전작의 부채를 청산한 기술 집약체.',
            techs: ['vector_graphics', 'Riverpod v2', 'GoRouter'],
            isLeft: false,
            icon: Icons.casino,
            color: Colors.indigo,
            isHighlight: true,
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String tag;
  final String desc;
  final List<String> techs;
  final bool isLeft;
  final IconData icon;
  final Color color;
  final bool isHighlight;

  const ProjectCard({
    super.key,
    required this.title,
    required this.tag,
    required this.desc,
    required this.techs,
    required this.isLeft,
    required this.icon,
    required this.color,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isHighlight ? PortfolioColors.primary : Theme.of(context).dividerColor,
          width: isHighlight ? 2 : 1,
        ),
        boxShadow: isHighlight ? [BoxShadow(color: PortfolioColors.primary.withOpacity(0.1), blurRadius: 20)] : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(tag, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(desc, style: const TextStyle(fontSize: 16, height: 1.6)),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: techs.map((t) => Chip(
              label: Text(t),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              labelStyle: const TextStyle(fontSize: 12),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

// --- Lab Section ---
class LabSection extends StatelessWidget {
  const LabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      width: double.infinity,
      child: Column(
        children: [
          const Text('Dev.Lab & Experiments', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: const [
              LabCard(title: 'WebDriverManager PR', icon: Icons.code, color: Colors.blue, desc: 'Docker 환경 호환성 문제 해결 및 기여'),
              LabCard(title: 'Image Compressor', icon: Icons.image, color: Colors.purple, desc: 'Dart CLI 기반 이미지 최적화 도구'),
              LabCard(title: 'Clean Arch Boilerplate', icon: Icons.layers, color: Colors.green, desc: 'Riverpod + MVVM 템플릿'),
            ],
          ),
        ],
      ),
    );
  }
}

class LabCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String desc;

  const LabCard({super.key, required this.title, required this.icon, required this.color, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color),
              const Icon(Icons.arrow_outward, size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }
}

// --- Interactive Skill Section (Chaos vs Order) ---
class InteractiveSkillSection extends StatefulWidget {
  const InteractiveSkillSection({super.key});

  @override
  State<InteractiveSkillSection> createState() => _InteractiveSkillSectionState();
}

class _InteractiveSkillSectionState extends State<InteractiveSkillSection> {
  bool isOrderMode = false;
  final List<String> skills = [
    "Flutter", "Dart", "Riverpod", "GoRouter", "Clean Arch", "MVVM",
    "Atomic Design", "Firebase", "Socket.io", "Drift", "Docker", "CI/CD",
    "Git", "Figma", "WebP Opt", "Vector Graphics", "DevTools", "CustomPainter"
  ];

  // Random positions for chaos mode
  late List<Offset> chaosPositions;

  @override
  void initState() {
    super.initState();
    _generateChaosPositions();
  }

  void _generateChaosPositions() {
    final random = Random();
    chaosPositions = List.generate(skills.length, (index) {
      return Offset(
        random.nextDouble() * 300 - 150, // x: -150 to 150
        random.nextDouble() * 300 - 150, // y: -150 to 150
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Technical Stack', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(width: 16),
              Switch(
                value: isOrderMode,
                activeColor: PortfolioColors.primary,
                onChanged: (value) => setState(() => isOrderMode = value),
              ),
              Text(isOrderMode ? 'Order Mode' : 'Chaos Mode', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            height: 400,
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: List.generate(skills.length, (index) {
                // Calculate Order Position (Grid)
                const int cols = 4;
                final int row = index ~/ cols;
                final int col = index % cols;
                final double orderX = (col - 1.5) * 120;
                final double orderY = (row - 2) * 60;

                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOutBack,
                  left: (MediaQuery.of(context).size.width > 800 ? 400 : 200) + (isOrderMode ? orderX : chaosPositions[index].dx) - 50, // Center offset
                  top: 200 + (isOrderMode ? orderY : chaosPositions[index].dy) - 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isOrderMode ? Theme.of(context).scaffoldBackgroundColor : PortfolioColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isOrderMode ? Theme.of(context).dividerColor : PortfolioColors.lightBlue),
                      boxShadow: isOrderMode ? [] : [BoxShadow(color: PortfolioColors.lightBlue.withOpacity(0.2), blurRadius: 8)],
                    ),
                    child: Text(
                      skills[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isOrderMode ? Theme.of(context).textTheme.bodyLarge?.color : PortfolioColors.primary,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Footer ---
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PortfolioColors.bgDark,
      padding: const EdgeInsets.all(40),
      width: double.infinity,
      child: const Column(
        children: [
          Text('Ready to Optimize?', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text(
            '극한의 성능 최적화와 견고한 아키텍처가 필요하시다면 연락주세요.',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email, color: Colors.white),
              SizedBox(width: 24),
              Icon(Icons.link, color: Colors.white),
            ],
          ),
          SizedBox(height: 40),
          Text(
            '© 2024 Dev.Seungyn. Built with Flutter.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}