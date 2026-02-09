import 'source/glyph_source.dart';

enum Constraints with GlyphLabelMixin {
  // About Section
  improvementAndOptimization('개선 및 최적화'),
  improvementDesc(
    '작은 디테일 하나가 사용자 경험의 차이를 만든다고 믿습니다. '
    '렌더링 부하 감소, 리소스 사용 개선 등 결과가 증명될 때까지 집요하게 파고들어 최적화를 완성하고 개선합니다.',
  ),
  technicalCommunication('기술적인 소통'),
  communicationDesc(
    '아키텍처와 방법론이 단순한 기술 표준을 넘어, 소통의 명확한 기준이 된다는 것을 배웠습니다. '
    '상황에 최적화된 설계로 지속 가능한 미래를 그리며, 코드뿐만 아니라 팀의 커뮤니케이션 흐름까지 설계합니다.',
  ),
  diverseExperience('다양한 경험'),
  experienceDesc(
    '플러터 역량에 더해 자바 백엔드, 웹, 인프라, 클라이언트 제어까지 폭넓게 경험했습니다. '
    '이러한 다양한 기술적 배경을 제 코드에 녹여내며, 앞으로 마주할 새로운 기술적 도전과 성장의 경험을 기대하고 있습니다.',
  ),

  // Hero Section
  persistentProblemSolving('집요한 문제 해결'),
  architectureDesigningCommunication('소통을 설계하는 아키텍처'),
  hello('안녕하세요,'),
  flutterDeveloper('플러터 개발자'),
  myName('김용민입니다.'),
  heroDescription(
    '임시방편은 없습니다. 집요하게 문제의 뿌리를 뽑습니다. \n'
    '27만 명이 사용하는 오픈소스의 오류를 해결하여 기여한 경험이 저를 증명합니다. '
    '단순한 기능 구현을 넘어, 코드로 제품의 신뢰를 쌓는 개발자가 되고 싶습니다.',
  ),

  // Info Section
  activitiesAndQualifications('활동 및 자격 사항'),
  openSourceContribution('오픈소스 기여'),
  webDriverManagerPR('WebDriverManager PR'),
  certification('자격증'),
  infoProcessingIndustryEngineer('정보처리산업기사'),

  // Skill Section
  skills('보유 기술'),
  skillDescription(
    '부딪히며 습득하고,\n'
    '끊임없이 경험을 쌓아 올렸습니다.',
  ),

  // Social Section
  workTogether('함께 일하고'),
  wantTo('싶습니다'),
  acceptSmallProposals('작은 제안도 소중히 받겠습니다'),

  // Navigation
  aboutMe('ABOUT ME'),
  projects('PROJECTS'),

  // Contact Form
  title('제목'),
  email('이메일'),
  inquiryContent('문의 내용'),
  cancel('취소'),
  send('보내기'),

  // Project Sheet
  category('분류'),
  role('역할'),
  period('기간'),
  teamAndContribution('팀 / 기여도'),
  links('링크')
  ;

  @override
  final String label;

  const Constraints(this.label);
}
