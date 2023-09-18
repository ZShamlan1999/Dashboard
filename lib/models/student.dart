class StudentsModel {
  String accountNo;
  String studentID;
  String fullName;
  String department;
  String level;
  String macAddress;

  StudentsModel(
      {required this.accountNo,
      required this.studentID,
      required this.fullName,
      required this.department,
      required this.level,
      required this.macAddress});

  factory StudentsModel.fromJson(Map<String, dynamic> json) {
    return StudentsModel(
      accountNo: json['AccountNo'].toString(),
      studentID: json['StudentID'].toString(),
      fullName: json['FullName'],
      department: json['Department'],
      level: json['Level'].toString(),
      macAddress: json['MacAddress'].toString(),
    );
  }
}
