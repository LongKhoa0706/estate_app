import 'package:estate_app/src/model/new.dart';
import 'package:estate_app/src/repositories/provider/new_provider.dart';

class NewsRepositories{
  NewProvider _newProvider = NewProvider();

  Future<void> addNew(New news) async {
    final newResponse = await _newProvider.addNew(news);
    print(newResponse.data);
    print(newResponse);
  }
  Future<List<New>> getNew() async {
    List<New>listProject = [];
    final authResponse = await _newProvider.getListNew();
    List listProjectt = authResponse.data['data'];
    listProject = listProjectt.map((e) => New.fromJson(e)).toList();
    return listProject;
  }
}