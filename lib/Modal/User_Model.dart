// class User_Lgin_Data {
//   List<Data>? data;

//   User_Lgin_Data({this.data});

//   User_Lgin_Data.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   String? empNo;
//   String? managerName;
//   String? firebaseId;
//   String? name;
//   String? mobile;
//   String? email;
//   String? designation;
//   String? status;

//   Data(
//       {this.empNo,
//       this.managerName,
//       this.firebaseId,
//       this.name,
//       this.mobile,
//       this.email,
//       this.designation,
//       this.status});

//   Data.fromJson(Map<String, dynamic> json) {
//     empNo = json['emp_no'];
//     managerName = json['manager_name'];
//     firebaseId = json['firebase_id'];
//     name = json['name'];
//     mobile = json['mobile'];
//     email = json['email'];
//     designation = json['designation'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['emp_no'] = this.empNo;
//     data['manager_name'] = this.managerName;
//     data['firebase_id'] = this.firebaseId;
//     data['name'] = this.name;
//     data['mobile'] = this.mobile;
//     data['email'] = this.email;
//     data['designation'] = this.designation;
//     data['status'] = this.status;
//     return data;
//   }
// }
