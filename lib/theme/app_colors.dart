import 'package:flutter/material.dart';

class AppColors {
  // 인스턴스화 방지
  AppColors._();

  // ===========================================================================
  // ☀️ Light Mode (라이트 모드)
  // : 선명한 블루 + 밝은 쿨 그레이
  // ===========================================================================

  // Brand Colors (브랜드)
  static const Color lightPrimary = Color(0xFF2563EB);    // 캐릭터 옷 색상 (Vivid Royal Blue)
  static const Color lightSecondary = Color(0xFF60A5FA);  // 보조용 밝은 블루

  // Background & Surface (배경)
  static const Color lightBackground = Color(0xFFF8FAFC); // 아주 연한 푸른 회색 (Slate 50)
  static const Color lightSurface = Color(0xFFFFFFFF);    // 카드/다이얼로그 배경 (White)

  // Grays & Text (회색 톤 - Slate 계열)
  static const Color lightTextMain = Color(0xFF1E293B);   // 제목/본문 (진한 네이비 그레이)
  static const Color lightTextSub = Color(0xFF64748B);    // 설명/날짜 (중간 회색)
  static const Color lightOutline = Color(0xFFE2E8F0);    // 테두리/디바이더 (연한 회색)


  // ===========================================================================
  // 🌙 Dark Mode (다크 모드)
  // : 눈이 편한 밝은 블루 + 깊은 밤하늘색 배경
  // ===========================================================================

  // Brand Colors (브랜드)
  static const Color darkPrimary = Color(0xFF3B82F6);     // 가독성을 위해 명도를 높인 블루
  static const Color darkSecondary = Color(0xFF93C5FD);   // 파스텔 톤 블루

  // Background & Surface (배경)
  static const Color darkBackground = Color(0xFF0F172A);  // 딥 다크 네이비 (Slate 900)
  static const Color darkSurface = Color(0xFF1E293B);     // 카드 배경 (Slate 800)

  // Grays & Text (회색 톤 - Slate 계열)
  static const Color darkTextMain = Color(0xFFF1F5F9);    // 제목/본문 (거의 흰색에 가까운 회색)
  static const Color darkTextSub = Color(0xFF94A3B8);     // 설명/날짜 (은회색)
  static const Color darkOutline = Color(0xFF334155);     // 테두리/디바이더 (어두운 회색)
}