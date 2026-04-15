class CreateJobRequest {
  final String title;
  final String location;
  final String company;
  final String description;
  final String salary;
  final String contractPeriod;
  final String workHours;
  final List<String>? requirements;
  final String imageUrl;
  final String? agentId;

  CreateJobRequest({
    required this.title,
    required this.location,
    required this.company,
    required this.description,
    required this.salary,
    required this.contractPeriod,
    required  this.workHours,
    this.requirements,
    required  this.imageUrl,
    this.agentId,
  });

  factory CreateJobRequest.fromJson(Map<String, dynamic> json) {
    return CreateJobRequest(
      title: json['title'],
      location: json['location'],
      company: json['company'],
      description: json['description'],
      salary: json['salary'],
      contractPeriod: json['contractPeriod'],
      workHours: json['workHours'],
      requirements: json['requirements'] != null
          ? List<String>.from(json['requirements'])
          : null,
      imageUrl: json['imageUrl'],
      agentId: json['agentId'],
    );
  }
  Map<String, dynamic> toJson() => {
    "title": title,
    "location": location,
    "company": company,
    "description": description,
    "salary": salary,
    "contractPeriod": contractPeriod,
    "workHours": workHours ?? "",
    "requirements": requirements ?? [],
    "imageUrl": imageUrl ?? "",
    "agentId": agentId ?? "",
  };
}
