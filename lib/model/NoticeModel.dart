class NoticeModel {
  final String updateDate;
  final String title;
  final String content;

  // 생성자
  NoticeModel({
    required this.updateDate,
    required this.title,
    required this.content,
  });

  // JSON 변환을 위한 팩토리 메서드
  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      updateDate: json['updateDate'],  // 문자열로 처리
      title: json['title'],
      content: json['content'],
    );
  }

  // JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'updateDate': updateDate,  // 문자열 그대로 반환
      'title': title,
      'content': content,
    };
  }
}