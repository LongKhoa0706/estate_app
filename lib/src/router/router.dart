import 'package:estate_app/src/screen/add_buy_screen.dart';
import 'package:estate_app/src/screen/buy_screen.dart';
import 'package:estate_app/src/screen/chat_screen.dart';
import 'package:estate_app/src/screen/detail_product.dart';
import 'package:estate_app/src/screen/add_post_screen/addpostscreen.dart';
import 'package:estate_app/src/screen/addprojectscreen.dart';
import 'package:estate_app/src/screen/changeinfoscreen.dart';
import 'package:estate_app/src/screen/changepasswordscreen.dart';
import 'package:estate_app/src/screen/commentpostscreen.dart';
import 'package:estate_app/src/screen/contract_screen/contractscreen.dart';
import 'package:estate_app/src/screen/dashboard/dashboard.dart';
import 'package:estate_app/src/screen/detailinformationscreen.dart';
import 'package:estate_app/src/screen/detailnewsscreen.dart';
import 'package:estate_app/src/screen/detailpostscreen.dart';
import 'package:estate_app/src/screen/detailproductscreen.dart';
import 'package:estate_app/src/screen/favoritescreen.dart';
import 'package:estate_app/src/screen/forgot_pass_screen/forgotpassscreen.dart';
import 'package:estate_app/src/screen/get_project_by_type_screen.dart';
import 'package:estate_app/src/screen/getallscreen.dart';
import 'package:estate_app/src/screen/list_like_comment_post_screen.dart';
import 'package:estate_app/src/screen/listlikepostscreen.dart';
import 'package:estate_app/src/screen/listlikeprojectscreen.dart';
import 'package:estate_app/src/screen/login_screen/loginscreen.dart';
import 'package:estate_app/src/screen/forgot_pass_screen/newpassscreen.dart';
import 'package:estate_app/src/screen/mapscreen.dart';
import 'package:estate_app/src/screen/news_screen.dart';
import 'package:estate_app/src/screen/onboard_screen/onboardingscreen.dart';
import 'package:estate_app/src/screen/optionscreen.dart';
import 'package:estate_app/src/screen/register_screen/registerscreen.dart';
import 'package:estate_app/src/router/router_path.dart';
import 'package:estate_app/src/screen/replycommentscreen.dart';
import 'package:estate_app/src/screen/resutl_search_screen.dart';
import 'package:estate_app/src/screen/splashscreen/splashscreen.dart';
import 'package:estate_app/src/screen/forgot_pass_screen/verifyemailscreen.dart';
import 'package:estate_app/src/screen/suportscreen.dart';
import 'package:estate_app/src/screen/verify_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routerr{
  static RouteFactory onGenerateRouter = (RouteSettings settings){
    switch(settings.name){
      case SplashScreens:
        return _generateMaterialRoute(SplashScreen());
      case OnboadingScreens:
        return _generateMaterialRoute(OnBoardingScreen());
      case LoginScreens:
        return _generateMaterialRoute(LoginScreen());
      case RegisterScreens:
        return _generateMaterialRoute(RegisterScreen());
      case ForgotPasswordScreens:
        return _generateMaterialRoute(ForgotPassScreen());
      case VerifyEmailScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(VerifyEmailScreen(email:arg,));
      case NewPassScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(NewPassScreen(email: arg,));
      case DashBoardScreens:
        return _generateMaterialRoute(Dashboard());
      case DetailInforScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(DetailInformationScreen(idUser: arg,));
      case DetailProductScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(DetailProduct(idProject: arg,));
      case AddPostScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(AddPostScreen(user: arg,));
      case ContractScreens:
        return _generateMaterialRoute(ContractScreen());
      case ChangeInfoScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(ChangeInfoScreen(user: arg,));
      case OptionScreens:
        return _generateMaterialRoute(OptionScreen());
      case ChangePasswordScreens:
        return _generateMaterialRoute(ChangePasswordScreen());
      case AddProjectScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(AddProjectScreen(project: arg,));
      case GetAllScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(GetAllScreen(keyWord: arg,));
      case NewsScreens:
        return _generateMaterialRoute(NewsScreen());
      case ListLikeProjectScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(ListLikeProjectScreen(idProject: arg,));
      case DetailNewsScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(DetailNewsScreen(news: arg,));
      case ListLikeCommentPostScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(ListLikeCommentPostScreen(idComment: arg,));
      case ReplyCommentScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(ReplyCommentScreen(comment: arg,));
      case DetailPostScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(DetailPostScreen(post: arg,));
      case CommentPostScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(CommentPostScreen(idPost: arg,));
      case ListLikePostScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(ListLikePostScreen(idPost: arg,));
      case FavoriteScreens:
        return _generateMaterialRoute(FavoriteScreen());
      case SupportScreens:
        return _generateMaterialRoute(SupportScreen());
      case MapScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(MapScreen(address: arg,));
      case ChatScreens:
        return _generateMaterialRoute(ChatScreen());
      case VerifyCodeScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(VerifyCodeScreen(users: arg,));
      case GetProjectByTypeScreens:
        final arg = settings.arguments;
        return _generateMaterialRoute(GetProjectByTypeScreen(type: arg,));
      case BuyScreens:
        return _generateMaterialRoute(BuyScreen());

      case AddBuyScreens:
        return _generateMaterialRoute(AddBuyScreen());

      case ResultProjectScreens:
        Map arg = settings.arguments;
        return _generateMaterialRoute(ResultSearchScreen(minPrice: arg['minPrice'], maxPrice: arg['maxPrice'],title: arg['title'], provincials: arg['provincials'],categories: arg['categories'],));
      default:
        return _generateMaterialRoute(Center(child: Text("On Unknown Router",style: TextStyle(
          color: Colors.red,
          fontSize: 25,
        ),),));
    }
  };
}

PageTransition _generateMaterialRoute(Widget screen) {
  return PageTransition(child: screen,type: PageTransitionType.fade);
}
