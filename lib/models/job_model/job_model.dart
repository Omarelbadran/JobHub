class JobModel {
  final String id;
  final String title;
  final String location;
  final String company;
  final String description;
  final String salary;
  final String workHours;
  final String contractPeriod;
  final String imageUrl;
  final List<String> requirements;
  final DateTime createdAt;

  JobModel({
    required this.id,
    required this.title,
    required this.location,
    required this.company,
    required this.description,
    required this.salary,
    required this.workHours,
    required this.contractPeriod,
    required this.imageUrl,
    required this.requirements,
    required this.createdAt,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['_id'] ?? "",
      title: json['title'] ?? "",
      location: json['location'] ?? "",
      company: json['company'] ?? "",
      description: json['description'] ?? "",
      salary: json['salary'] ?? "",
      workHours: json['workHours'] ?? "",
      contractPeriod: json['contractPeriod'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
      requirements: json['requirements'] != null
          ? List<String>.from(json['requirements'])
          : [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "location": location,
      "company": company,
      "description": description,
      "salary": salary,
      "workHours": workHours,
      "contractPeriod": contractPeriod,
      "imageUrl": imageUrl,
      "requirements": requirements,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}