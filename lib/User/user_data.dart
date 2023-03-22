class personal_info0 {
  String? login_Id;
  String? card_Value;
  String? email_Id;
  String? role;
  String? f_Name;
  String? l_Name;
  String? contact_No;
  String? status;
  String? dOB;

  personal_info0(
      {this.login_Id,
        this.card_Value,
        this.email_Id,
        this.role,
        this.f_Name,
        this.l_Name,
        this.contact_No,
        this.status,
        this.dOB});

  factory personal_info0.fromJson(Map<String, dynamic> parsedJson) {
    return personal_info0(
      login_Id: parsedJson['Login_Id'].toString(),
      card_Value: parsedJson['Card_Value'].toString(),
      email_Id: parsedJson['Email_Id'].toString(),
      role: parsedJson['Role'].toString(),
      f_Name: parsedJson['F_Name'].toString(),
      l_Name: parsedJson['L_Name'].toString(),
      contact_No: parsedJson['Contact_No'].toString(),
      status: parsedJson['Status'].toString(),
      dOB: parsedJson['DOB'].toString(),
    );
  }
}

class personal_info1 {
  static String? login_Id;
  static String? card_Value;
  static String? email_Id;
  static String? role;
  static String? f_Name;
  static String? l_Name;
  static String? contact_No;
  static String? status;
  static String? dOB;

  static void getJson(var a) {
    final obj = personal_info0.fromJson(a);
    login_Id = obj.login_Id;
    card_Value = obj.card_Value;
    email_Id = obj.email_Id;
    role = obj.role;
    f_Name = obj.f_Name;
    l_Name = obj.l_Name;
    contact_No = obj.contact_No;
    status = obj.status;
    dOB = obj.dOB;
  }
}