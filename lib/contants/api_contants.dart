///WanAndroid 后台接口常量
class ApiConstants {
  ApiConstants._();

  static const String gankBaseUrl = "http://gank.io/api";

  static String getWelfarePictures(int page) => "/data/福利/30/$page";

  static String navigateByWanAndroid(String url) =>"wanandroid://browse/navigate?url=$url";

  static String gitRepositoryUrl = "https://github.com/anymao/Andkit";
}
