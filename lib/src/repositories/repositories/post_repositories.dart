import 'package:estate_app/src/model/comment.dart';
import 'package:estate_app/src/model/post.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/provider/post_provider.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PostRepositories {
  PostProvider postProvider = PostProvider();

  Future<void> addPost(String content,List<Asset> listImage) async {
    final postResponse = await postProvider.addPost(listImage, content);
    return postResponse;
  }
  Future<List<Post>> getAllPost() async {
    List<Post> listPost = [];
    final postReponse = await postProvider.getAllPost();
    List listPostt = postReponse.data['data'];
    listPost = listPostt.map((e) => Post.fromJson(e)).toList();
    return listPost;
  }
  Future<List<Post>> getMyPost() async{
    List<Post> listPost = [];
    final postReponse = await postProvider.getMyPost();
    List listPostt = postReponse.data['data'];
    listPost = listPostt.map((e) => Post.fromJson(e)).toList();
    return listPost;
  }

  Future<void> likePost(int idPost,bool isLike) async {
    final projectResponse = await postProvider.likeProject(idPost,isLike);
    return projectResponse;
  }
  Future<void> createComment(int idProject,String content,int idComment,) async {
    final projectResponse = await postProvider.createComment(idProject, content,idComment);
    return projectResponse;
  }
  Future<List<Comment>> listCommentByProject(int idProject) async {
    List<Comment> listComment = [];
    final projectResponse = await postProvider.listCommentByProject(idProject);
    List listCommentt = projectResponse.data['data'];
    listComment = listCommentt.map((e) => Comment.fromJson(e)).toList();
    return listComment;
  }

  Future<List<Users>> listLikePost(int idPost) async {
    List<Users>listUser = [];
    final projectResponse  = await postProvider.listLikeByPost(idPost);
    List listUserr = projectResponse.data['data'];
    listUser = listUserr.map((e) => Users.fromJson(e['id_account_like'])).toList();
    return listUser;
  }

  Future<List<Post>> getProjectUser(int idUser) async {
    List<Post>listProject = [];
    final projectResponse = await postProvider.getPostUser(idUser);
    List listProjectt = projectResponse.data['data'];
    listProject = listProjectt.map((e) => Post.fromJson(e)).toList();
    return listProject;
  }

}