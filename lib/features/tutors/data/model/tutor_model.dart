class TutorModel {
  final String id;
  final String? vemail;
  final String? name;
  final String? profession;
  final String? pdfUrl;
  final String? status;

  TutorModel(
      {
        required this.id,
        required this.vemail,
      required this.name,
      required this.pdfUrl,
      required this.profession,
      required this.status});
  factory TutorModel.fromFirestore(Map<String, dynamic> json) {
    return TutorModel(
      id: json['id']??"",
        name: json['name']??"",
        vemail: json['vemail']??"",
        pdfUrl: json['pdfUrl']??"",
        profession: json['profession']??"",
        status: json['status']??"");
  }
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'name': name,
      'vemail': vemail,
      'pdfUrl': pdfUrl,
      'profession': profession,
      'status': status
    };
  }
}
