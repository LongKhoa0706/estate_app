part of 'get_banner_bloc.dart';

@immutable
abstract class GetBannerState {}

class InitialGetBannerState extends GetBannerState {}

class GetBannerStateLoading extends GetBannerState{}

class GetBannerStateSuccess extends GetBannerState{
  final List<String> listImageBanner;

  GetBannerStateSuccess(this.listImageBanner);
}
class GetBannerStateFail extends GetBannerState{
  final dynamic error;

  GetBannerStateFail(this.error);

}