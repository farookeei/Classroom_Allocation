class ClassroomsModel {
  List<Classrooms>? classrooms;

  ClassroomsModel({this.classrooms});

  ClassroomsModel.fromJson(Map<String, dynamic> json) {
    if (json['classrooms'] != null) {
      classrooms = <Classrooms>[];
      json['classrooms'].forEach((v) {
        classrooms!.add(new Classrooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.classrooms != null) {
      data['classrooms'] = this.classrooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Classrooms {
  int? id;
  String? layout;
  String? name;
  int? size;
  String? subject;

  Classrooms({this.id, this.layout, this.name, this.size});

  Classrooms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    layout = json['layout'];
    name = json['name'];
    size = json['size'];
    subject = json["subject"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['layout'] = this.layout;
    data['name'] = this.name;
    data['size'] = this.size;
    data["subject"] = this.subject;
    return data;
  }
}
