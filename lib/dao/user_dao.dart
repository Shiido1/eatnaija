
import 'package:eatnaija/database/user_database.dart';
import 'package:eatnaija/presentation/screens/login/models/user.dart';

class UserDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createUser(User user) async {
    final db = await dbProvider.database;

    var result = db.insert(userTable, user.toJson());
    return result;
  }

  Future<int> deleteUser() async {
    final db = await dbProvider.database;
    var result =
    await db.delete(userTable);
    return result;
  }

  Future<bool> checkUser(String id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
      await db.query(userTable);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<int> update(User user) async {
    final db = await dbProvider.database;

    return await db.update(userTable, user.toJson(),
        where: 'id = ?', whereArgs: [user.id]);
  }

  Future<bool> updateUser(String id) async {



    final db = await dbProvider.database;
    try {
      List<Map> users =
      await db.query(userTable);
      if (users.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<Map<String, dynamic>> getUser(String id) async {
    final db = await dbProvider.database;
    try {
      List<Map> users =
      await db.query(userTable);
      if (users.length > 0) {

        Map<String, dynamic> hmap = users[0];

        print(hmap);

        return hmap;

      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
