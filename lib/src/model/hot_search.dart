class HotSearch {
  final int code;
  final HotSearchData data;
  final String msg;

  HotSearch({
    this.code,
    this.data,
    this.msg,
  });

  factory HotSearch.fromJson(Map<String, dynamic> json) {
    HotSearchData data = HotSearchData.fromJson(json['data']);
    return HotSearch(
      code: json['code'],
      data: data,
      msg: json['msg'],
    );
  }
}

class HotSearchData {
  final String time;
  final String imageFile;
  final String pdfFile;
  final List<SingleHotSearch> searches;

  HotSearchData({
    this.time,
    this.imageFile,
    this.pdfFile,
    this.searches,
  });

  factory HotSearchData.fromJson(Map<String, dynamic> json) {
    var list = json['searches'] as List;
    List<SingleHotSearch> searches =
        list.map((i) => SingleHotSearch.fromJson(i)).toList();
    return HotSearchData(
      time: json['time'],
      imageFile: json['image_file'],
      pdfFile: json['pdf_file'],
      searches: searches,
    );
  }
}

class SingleHotSearch {
  int rank;
  String content;
  String tag;
  int hot;
  String link;
  String topicLead;

  SingleHotSearch({
    this.rank,
    this.content,
    this.tag,
    this.hot,
    this.link,
    this.topicLead,
  });

  factory SingleHotSearch.fromJson(Map<String, dynamic> json) {
    return SingleHotSearch(
      rank: json['rank'],
      content: json['content'],
      tag: json['tag'],
      hot: json['hot'],
      link: json['link'],
      topicLead: json['topic_lead'],
    );
  }
}
