class Employee {
  String empNo;
  String managerName;
  String firebaseId;
  String name;
  String mobile;
  String email;
  String designation;
  String status;

  Employee({
    required this.empNo,
    required this.managerName,
    required this.firebaseId,
    required this.name,
    required this.mobile,
    required this.email,
    required this.designation,
    required this.status,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      empNo: json['emp_no'],
      managerName: json['manager_name'],
      firebaseId: json['firebase_id'],
      name: json['name'],
      mobile: json['mobile'],
      email: json['email'],
      designation: json['designation'],
      status: json['status'],
    );
  }
}

class ApiResponse {
  List<Employee> data;
  String message;
  String statusCode;

  ApiResponse({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      data: (json['data'] as List)
          .map((employeeJson) => Employee.fromJson(employeeJson))
          .toList(),
      message: json['message'],
      statusCode: json['status_code'],
    );
  }
}
