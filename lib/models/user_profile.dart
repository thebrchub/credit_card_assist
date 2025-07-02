import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 1)
class AppUser extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String? phone;

  @HiveField(3)
  String? imagePath;

  AppUser({
    required this.name,
    required this.email,
    this.phone,
    this.imagePath,
  });
}
