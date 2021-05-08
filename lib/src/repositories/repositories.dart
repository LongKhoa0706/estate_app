import 'package:estate_app/src/repositories/provider/home_provider.dart';
import 'package:estate_app/src/repositories/repositories/auth_repositories.dart';
import 'package:estate_app/src/repositories/repositories/city_repositories.dart';
import 'package:estate_app/src/repositories/repositories/home_repositories.dart';
import 'package:estate_app/src/repositories/repositories/news_repositories.dart';
import 'package:estate_app/src/repositories/repositories/post_repositories.dart';
import 'package:estate_app/src/repositories/repositories/project_repositories.dart';
import 'package:estate_app/src/repositories/repositories/user_repositories.dart';

class Repositories{
  static final Repositories _repository = Repositories._();

  Repositories._();
  factory Repositories() => _repository;

  final AuthRepositories authRepositories = AuthRepositories();
  final HomeRepositories homeRepositories = HomeRepositories();
  final CityRepositories cityRepositories = CityRepositories();
  final UserRepositories  userRepositories = UserRepositories();
  final ProjectRepositories projectRepositories = ProjectRepositories();
  final PostRepositories postRepositories = PostRepositories();
  final NewsRepositories newsRepositories = NewsRepositories();
}