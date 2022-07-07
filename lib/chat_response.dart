class ChatResponse {
  final List<Data>? data;
  final int? total;

  ChatResponse({
    this.data,
    this.total,
  });

  ChatResponse.fromJson(Map<String, dynamic> json)
    : data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList(),
      total = json['total'] as int?;

  Map<String, dynamic> toJson() => {
    'data' : data?.map((e) => e.toJson()).toList(),
    'total' : total
  };
}

class Data {
  final String? name;
  final dynamic alias;
  final int? enableNotify;
  final String? role;
  final String? avatar;
  final int? id;
  final int? groupLevel;
  final int? messageCount;
  final int? memberCount;
  final dynamic departments;
  final int? banCount;
  final String? folder;
  final int? pinnedMessageId;
  final int? readCount;
  final String? type;
  final dynamic blockedBy;
  final String? link;
  final dynamic description;
  final Partner? partner;
  final String? partnerId;
  final LastMessage? lastMessage;
  final dynamic banner;
  final int? pinnedAt;
  final int? pinnedCount;
  final dynamic associateLink;
  final List<dynamic>? tags;
  final dynamic canCall;
  final int? unreadCount;
  final int? canSendMessage;
  final Settings? settings;

  Data({
    this.name,
    this.alias,
    this.enableNotify,
    this.role,
    this.avatar,
    this.id,
    this.groupLevel,
    this.messageCount,
    this.memberCount,
    this.departments,
    this.banCount,
    this.folder,
    this.pinnedMessageId,
    this.readCount,
    this.type,
    this.blockedBy,
    this.link,
    this.description,
    this.partner,
    this.partnerId,
    this.lastMessage,
    this.banner,
    this.pinnedAt,
    this.pinnedCount,
    this.associateLink,
    this.tags,
    this.canCall,
    this.unreadCount,
    this.canSendMessage,
    this.settings,
  });

  Data.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String?,
      alias = json['alias'],
      enableNotify = json['enable_notify'] as int?,
      role = json['role'] as String?,
      avatar = json['avatar'] as String?,
      id = json['id'] as int?,
      groupLevel = json['group_level'] as int?,
      messageCount = json['message_count'] as int?,
      memberCount = json['member_count'] as int?,
      departments = json['departments'],
      banCount = json['ban_count'] as int?,
      folder = json['folder'] as String?,
      pinnedMessageId = json['pinned_message_id'] as int?,
      readCount = json['read_count'] as int?,
      type = json['type'] as String?,
      blockedBy = json['blocked_by'],
      link = json['link'] as String?,
      description = json['description'],
      partner = (json['partner'] as Map<String,dynamic>?) != null ? Partner.fromJson(json['partner'] as Map<String,dynamic>) : null,
      partnerId = json['partner_id'] as String?,
      lastMessage = (json['last_message'] as Map<String,dynamic>?) != null ? LastMessage.fromJson(json['last_message'] as Map<String,dynamic>) : null,
      banner = json['banner'],
      pinnedAt = json['pinned_at'] as int?,
      pinnedCount = json['pinned_count'] as int?,
      associateLink = json['associate_link'],
      tags = json['tags'] as List?,
      canCall = json['can_call'],
      unreadCount = json['unread_count'] as int?,
      canSendMessage = json['can_send_message'] as int?,
      settings = (json['settings'] as Map<String,dynamic>?) != null ? Settings.fromJson(json['settings'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'alias' : alias,
    'enable_notify' : enableNotify,
    'role' : role,
    'avatar' : avatar,
    'id' : id,
    'group_level' : groupLevel,
    'message_count' : messageCount,
    'member_count' : memberCount,
    'departments' : departments,
    'ban_count' : banCount,
    'folder' : folder,
    'pinned_message_id' : pinnedMessageId,
    'read_count' : readCount,
    'type' : type,
    'blocked_by' : blockedBy,
    'link' : link,
    'description' : description,
    'partner' : partner?.toJson(),
    'partner_id' : partnerId,
    'last_message' : lastMessage?.toJson(),
    'banner' : banner,
    'pinned_at' : pinnedAt,
    'pinned_count' : pinnedCount,
    'associate_link' : associateLink,
    'tags' : tags,
    'can_call' : canCall,
    'unread_count' : unreadCount,
    'can_send_message' : canSendMessage,
    'settings' : settings?.toJson()
  };
}

class Partner {
  final String? id;
  final String? name;
  final String? avatar;
  final int? statusVerify;
  final String? type;
  final int? readCount;

  Partner({
    this.id,
    this.name,
    this.avatar,
    this.statusVerify,
    this.type,
    this.readCount,
  });

  Partner.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      name = json['name'] as String?,
      avatar = json['avatar'] as String?,
      statusVerify = json['status_verify'] as int?,
      type = json['type'] as String?,
      readCount = json['read_count'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'avatar' : avatar,
    'status_verify' : statusVerify,
    'type' : type,
    'read_count' : readCount
  };
}

class LastMessage {
  final int? id;
  final String? body;
  final RawBody? rawBody;
  final Sender? sender;
  final int? createdAt;
  final String? userId;

  LastMessage({
    this.id,
    this.body,
    this.rawBody,
    this.sender,
    this.createdAt,
    this.userId,
  });

  LastMessage.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      body = json['body'] as String?,
      rawBody = (json['raw_body'] as Map<String,dynamic>?) != null ? RawBody.fromJson(json['raw_body'] as Map<String,dynamic>) : null,
      sender = (json['sender'] as Map<String,dynamic>?) != null ? Sender.fromJson(json['sender'] as Map<String,dynamic>) : null,
      createdAt = json['created_at'] as int?,
      userId = json['user_id'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'body' : body,
    'raw_body' : rawBody?.toJson(),
    'sender' : sender?.toJson(),
    'created_at' : createdAt,
    'user_id' : userId
  };
}

class RawBody {
  final String? text;
  final String? type;
  final List<dynamic>? media;
  final dynamic forward;
  final Metadata? metadata;
  final dynamic tmpText;
  final dynamic replyToMsg;
  final bool? isMarkdownText;

  RawBody({
    this.text,
    this.type,
    this.media,
    this.forward,
    this.metadata,
    this.tmpText,
    this.replyToMsg,
    this.isMarkdownText,
  });

  RawBody.fromJson(Map<String, dynamic> json)
    : text = json['text'] as String?,
      type = json['type'] as String?,
      media = json['media'] as List?,
      forward = json['forward'],
      metadata = (json['metadata'] as Map<String,dynamic>?) != null ? Metadata.fromJson(json['metadata'] as Map<String,dynamic>) : null,
      tmpText = json['tmp_text'],
      replyToMsg = json['reply_to_msg'],
      isMarkdownText = json['is_markdown_text'] as bool?;

  Map<String, dynamic> toJson() => {
    'text' : text,
    'type' : type,
    'media' : media,
    'forward' : forward,
    'metadata' : metadata?.toJson(),
    'tmp_text' : tmpText,
    'reply_to_msg' : replyToMsg,
    'is_markdown_text' : isMarkdownText
  };
}

class Metadata {
  final AuthInformation? authInformation;

  Metadata({
    this.authInformation,
  });

  Metadata.fromJson(Map<String, dynamic> json)
    : authInformation = (json['auth_information'] as Map<String,dynamic>?) != null ? AuthInformation.fromJson(json['auth_information'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'auth_information' : authInformation?.toJson()
  };
}

class AuthInformation {
  final String? deviceId;
  final int? createdAt;
  final String? requestIp;
  final String? userAgent;

  AuthInformation({
    this.deviceId,
    this.createdAt,
    this.requestIp,
    this.userAgent,
  });

  AuthInformation.fromJson(Map<String, dynamic> json)
    : deviceId = json['device_id'] as String?,
      createdAt = json['created_at'] as int?,
      requestIp = json['request_ip'] as String?,
      userAgent = json['user_agent'] as String?;

  Map<String, dynamic> toJson() => {
    'device_id' : deviceId,
    'created_at' : createdAt,
    'request_ip' : requestIp,
    'user_agent' : userAgent
  };
}

class Sender {
  final String? id;
  final String? name;
  final String? avatar;
  final int? statusVerify;
  final String? type;

  Sender({
    this.id,
    this.name,
    this.avatar,
    this.statusVerify,
    this.type,
  });

  Sender.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      name = json['name'] as String?,
      avatar = json['avatar'] as String?,
      statusVerify = json['status_verify'] as int?,
      type = json['type'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'avatar' : avatar,
    'status_verify' : statusVerify,
    'type' : type
  };
}

class Settings {
  final int? isPublic;
  final int? disableMemberSendMessage;

  Settings({
    this.isPublic,
    this.disableMemberSendMessage,
  });

  Settings.fromJson(Map<String, dynamic> json)
    : isPublic = json['is_public'] as int?,
      disableMemberSendMessage = json['disable_member_send_message'] as int?;

  Map<String, dynamic> toJson() => {
    'is_public' : isPublic,
    'disable_member_send_message' : disableMemberSendMessage
  };
}