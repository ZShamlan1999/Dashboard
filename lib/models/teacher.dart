class TeacherModel {
  final String accountNo;
  final String employeeID;
  final String fullName;
  final String degreeType;

  TeacherModel(
      {required this.accountNo,
      required this.employeeID,
      required this.fullName,
      required this.degreeType});

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      accountNo: json['AccountNo'].toString(),
      employeeID: json['EmployeeID'].toString(),
      fullName: json['FullName'],
      degreeType: json['DegreeType'],
    );
  }
}
