class UpdateJobRequest {
  String? id;
  String? title;
  String? location;
  String? company;
  String? description;
  String? salary;
  String? workHours;
  String? contractPeriod;
  String? imageUrl;
  List<String>? requirements;

  UpdateJobRequest({
    this.id,
    this.title,
    this.location,
    this.company,
    this.description,
    this.salary,
    this.workHours,
    this.contractPeriod,
    this.imageUrl,
    this.requirements,
  });

  factory UpdateJobRequest.fromJson(Map<String, dynamic> json) {
    return UpdateJobRequest(
      id: json['id'],
      title: json['title'],
      location: json['location'],
      company: json['company'],
      description: json['description'],
      salary: json['salary'],
      workHours: json['workHours'],
      contractPeriod: json['contractPeriod'],
      imageUrl: json['imageUrl'],
      requirements: json['requirements'] != null
          ? List<String>.from(json['requirements'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['location'] = location;
    data['company'] = company;
    data['description'] = description;
    data['salary'] = salary;
    data['workHours'] = workHours;
    data['contractPeriod'] = contractPeriod;
    data['imageUrl'] = imageUrl;
    data['requirements'] = requirements;
    return data;
  }
}