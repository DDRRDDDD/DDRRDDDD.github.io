import 'package:flutter/material.dart';

import '../widget/bento_container.dart';
import '../widget/border_icon.dart';
import '../widget/chip.dart';
import '../widget/interactive_scale_detector.dart';

class ProjectOneHourSection extends StatelessWidget {
  const ProjectOneHourSection({super.key});

  @override
  Widget build(BuildContext context) {
    // return InteractiveScaleDetector(
    //   child: BentoContainer(
    //     color: Colors.red,
    //     child: const Placeholder(
    //       color: Colors.redAccent,
    //     ),
    //   ),
    // );
    return OneHourProjectCard();
  }
}

class OneHourProjectCard extends StatefulWidget {
  const OneHourProjectCard({super.key});

  @override
  State<OneHourProjectCard> createState() => _OneHourProjectCardState();
}

class _OneHourProjectCardState extends State<OneHourProjectCard> {
  // 모바일에서는 Hover 대신 탭으로 상세 정보를 토글합니다.
  bool _showDetails = false;

  void _toggleDetails() {
    setState(() {
      _showDetails = !_showDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleDetails,
      child: Container(
        decoration: BoxDecoration(
          // color: const Color(0xFF16181D),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // 1. 배경 이미지 및 그라데이션
            Positioned.fill(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1543269865-cbf427effbad?q=80&w=2070&auto=format&fit=crop",
                    fit: BoxFit.cover,
                  ),
                  // 어두운 오버레이 (상세 보기 시 더 어둡게)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: _showDetails
                            ? [
                          const Color(0xFF0F1115).withOpacity(0.9),
                          const Color(0xFF0F1115).withOpacity(0.95)
                        ]
                            : [
                          Colors.transparent,
                          const Color(0xFF0F1115).withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. 콘텐츠 영역
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .spaceBetween,
                children: [
                  // 상단: 아이콘 및 뱃지
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      const BorderIcon(
                        color: Colors.white,
                        icon: Icons.smartphone,
                      ),

                      // 팀 정보 & 기여도 뱃지
                      Row(
                        children: [
                          _buildBadge(Icons.people, "개발 2명", Colors.white),
                          const SizedBox(width: 8),
                          _buildBadge(Icons.emoji_events, "기여도 30%", Colors.blueAccent),
                        ],
                      ),
                    ],
                  ),

                  // 중앙/하단: 텍스트 정보 (애니메이션 전환)
                  Expanded(
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 400),
                      crossFadeState: _showDetails
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,

                      // 기본 뷰 (제목 + 설명)
                      firstChild: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Main Project",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "원아워 (One Hour)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "이웃과 소소한 모임부터 대화까지",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "시간 남을 때 근처 사람과 가볍게 만날 수 있는 번개 모임 및 이웃 연결 대화 서비스입니다.",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            children: ["Flutter", "Firebase", "Riverpod"]
                                .map((tag) => TagChip(tag: tag))
                                .toList(),
                          ),
                        ],
                      ),

                      // 상세 뷰 (기여 내용)
                      secondChild: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 40), // 상단 여백
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "KEY CONTRIBUTIONS",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildDetailItem("Firebase 기반 실시간 1:1 및 그룹 채팅 시스템 구축"),
                            const SizedBox(height: 12),
                            _buildDetailItem("계층형 데이터의 효율적 렌더링을 위한 마이페이지 트리 구조 설계"),

                            const SizedBox(height: 40),
                            // 안내 문구
                            Center(
                              child: Text(
                                "Tap to close",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label, Color highlightColor) {
    bool isHighlight = highlightColor == Colors.blueAccent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isHighlight ? Colors.blue.withOpacity(0.1) : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlight ? Colors.blue.withOpacity(0.2) : Colors.white.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: isHighlight ? Colors.blueAccent : Colors.grey[300]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isHighlight ? Colors.blueAccent : Colors.grey[300],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}