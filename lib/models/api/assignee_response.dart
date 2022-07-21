class AssigneeResponse {
  final int? code;
  final String? message;
  List<Assignee>? data;
  final Links? links;

  AssigneeResponse({
    this.code,
    this.message,
    this.data,
    this.links,
  });

  AssigneeResponse.fromJson(Map<String, dynamic> json)
      : code = json['code'] as int?,
        message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map((dynamic e) => Assignee.fromJson(e as Map<String, dynamic>))
            .toList(),
        links = (json['links'] as Map<String, dynamic>?) != null
            ? Links.fromJson(json['links'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
        'links': links?.toJson()
      };
}

class Assignee {
  final int? id;
  final String? displayName;
  final String? lang;
  final String? cover;
  final String? avatar;
  final String? email;
  final AssigneeInfo? info;
  final int? status;
  final int? statusVerify;
  final String? phoneNumber;
  final Privacy? privacy;
  final Birthday? birthday;
  final Gender? gender;
  final int? dataSource;
  final int? createdAt;
  final int? updatedAt;
  final int? joinDate;
  final String? avatarThumbPattern;
  final String? coverThumbPattern;
  final int? relation;

  Assignee({
    this.id,
    this.displayName,
    this.lang,
    this.cover,
    this.avatar,
    this.email,
    this.info,
    this.status,
    this.statusVerify,
    this.phoneNumber,
    this.privacy,
    this.birthday,
    this.gender,
    this.dataSource,
    this.createdAt,
    this.updatedAt,
    this.joinDate,
    this.avatarThumbPattern,
    this.coverThumbPattern,
    this.relation,
  });

  Assignee.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        displayName = json['display_name'] as String?,
        lang = json['lang'] as String?,
        cover = json['cover'] as String?,
        avatar = json['avatar'] as String?,
        email = json['email'] as String?,
        info = (json['info'] as Map<String, dynamic>?) != null
            ? AssigneeInfo.fromJson(json['info'] as Map<String, dynamic>)
            : null,
        status = json['status'] as int?,
        statusVerify = json['status_verify'] as int?,
        phoneNumber = json['phone_number'] as String?,
        privacy = (json['privacy'] as Map<String, dynamic>?) != null
            ? Privacy.fromJson(json['privacy'] as Map<String, dynamic>)
            : null,
        birthday = (json['birthday'] as Map<String, dynamic>?) != null
            ? Birthday.fromJson(json['birthday'] as Map<String, dynamic>)
            : null,
        gender = (json['gender'] as Map<String, dynamic>?) != null
            ? Gender.fromJson(json['gender'] as Map<String, dynamic>)
            : null,
        dataSource = json['data_source'] as int?,
        createdAt = json['created_at'] as int?,
        updatedAt = json['updated_at'] as int?,
        joinDate = json['join_date'] as int?,
        avatarThumbPattern = json['avatar_thumb_pattern'] as String?,
        coverThumbPattern = json['cover_thumb_pattern'] as String?,
        relation = json['relation'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'display_name': displayName,
        'lang': lang,
        'cover': cover,
        'avatar': avatar,
        'email': email,
        'info': info?.toJson(),
        'status': status,
        'status_verify': statusVerify,
        'phone_number': phoneNumber,
        'privacy': privacy?.toJson(),
        'birthday': birthday?.toJson(),
        'gender': gender?.toJson(),
        'data_source': dataSource,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'join_date': joinDate,
        'avatar_thumb_pattern': avatarThumbPattern,
        'cover_thumb_pattern': coverThumbPattern,
        'relation': relation
      };
}

class AssigneeInfo {
  final List<Work>? work;
  final String? bio;

  AssigneeInfo({
    this.work,
    this.bio,
  });

  AssigneeInfo.fromJson(Map<String, dynamic> json)
      : work = (json['work'] as List?)
            ?.map((dynamic e) => Work.fromJson(e as Map<String, dynamic>))
            .toList(),
        bio = json['bio'] as String?;

  Map<String, dynamic> toJson() =>
      {'work': work?.map((e) => e.toJson()).toList(), 'bio': bio};
}

class Work {
  final int? userId;
  final String? workspaceId;
  final String? company;
  final String? departmentId;
  final String? department;
  final String? title;
  final String? roleId;

  Work({
    this.userId,
    this.workspaceId,
    this.company,
    this.departmentId,
    this.department,
    this.title,
    this.roleId,
  });

  Work.fromJson(Map<String, dynamic> json)
      : userId = json['user_id'] as int?,
        workspaceId = json['workspace_id'] as String?,
        company = json['company'] as String?,
        departmentId = json['department_id'] as String?,
        department = json['department'] as String?,
        title = json['title'] as String?,
        roleId = json['role_id'] as String?;

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'workspace_id': workspaceId,
        'company': company,
        'department_id': departmentId,
        'department': department,
        'title': title,
        'role_id': roleId
      };
}

class Privacy {
  final int? email;
  final int? phoneNumber;

  Privacy({
    this.email,
    this.phoneNumber,
  });

  Privacy.fromJson(Map<String, dynamic> json)
      : email = json['email'] as int?,
        phoneNumber = json['phone_number'] as int?;

  Map<String, dynamic> toJson() =>
      {'email': email, 'phone_number': phoneNumber};
}

class Birthday {
  final int? day;
  final int? month;
  final int? year;

  Birthday({
    this.day,
    this.month,
    this.year,
  });

  Birthday.fromJson(Map<String, dynamic> json)
      : day = json['day'] as int?,
        month = json['month'] as int?,
        year = json['year'] as int?;

  Map<String, dynamic> toJson() => {'day': day, 'month': month, 'year': year};
}

class Gender {
  final int? gender;
  final int? privacy;

  Gender({
    this.gender,
    this.privacy,
  });

  Gender.fromJson(Map<String, dynamic> json)
      : gender = json['gender'] as int?,
        privacy = json['privacy'] as int?;

  Map<String, dynamic> toJson() => {'gender': gender, 'privacy': privacy};
}

class Links {
  final String? next;
  final String? prev;
  final int? totalPages;
  final int? totalItems;

  Links({
    this.next,
    this.prev,
    this.totalPages,
    this.totalItems,
  });

  Links.fromJson(Map<String, dynamic> json)
      : next = json['next'] as String?,
        prev = json['prev'] as String?,
        totalPages = json['total_pages'] as int?,
        totalItems = json['total_items'] as int?;

  Map<String, dynamic> toJson() => {
        'next': next,
        'prev': prev,
        'total_pages': totalPages,
        'total_items': totalItems
      };
}
