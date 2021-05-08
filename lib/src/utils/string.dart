class Strings {
//  static final appTitle = 'Ginkgo';
  static final common = _Common();
  static final button = _Button();
  static final error = _Error();
}

class _Common {
  final name = 'Họ tên';
  final email = 'Email';
  final phoneNumber = 'Số điện thoại';
  final password = 'Mật khẩu';
  final rePassword = 'Nhập lại mật khẩu';
  final developingFeature = 'Tính năng đang phát triển.';
}

class _Button {
  final login = 'Đăng nhập';
  final register = 'Đăng ký';
  final forgotPassword = 'Quên mật khẩu?';
  final logout = 'Đăng xuất';
  final reload = 'Tải lại';
  final takeAPicture = 'Chụp ảnh';
  final pickFromGallery = 'Chọn từ thư viện';
  final cancel = 'Hủy bỏ';
  final edit = 'Chỉnh sửa';
  final saveChanges = 'Lưu thay đổi';
  final viewAllImages = 'Xem tất cả hình ảnh';
  final viewAll = 'Xem tất cả';
  final takePartInNow = 'Tham gia ngay';
  final findFriendNow = 'Tìm bạn ngay';
  final nextStep = 'Sang bước tiếp theo';
  final backStep = 'Trở lại bước trước';
  final complete = 'Hoàn tất';
  final createTourNow = 'Tạo chuyến đi ngay';
}

class _Error {
  final passwordRequiredCharacter = 'Mật khẩu phải trên 6 ký tự';
  final userNameRequiredCharacter = "Username phải trên 6 ký tự";
  final emptyRequiredInput = 'Hãy điền thông tin vào trường bắt buộc.';
  final emailIncorrectForm = 'Email không đúng định dạng.';
  final phoneNumberIncorrectForm = 'Số điện thoại không đúng định dạng.';
  final rePasswordIsNotMatch = 'Re-password is not match with password.';
  final cannotRegisterWithFacebook = 'Không thể đăng ký bằng facebook';
  final errorClick = 'Đã xảy ra lỗi. Click để xem chi tiết.';
  final error = 'Đã xảy ra lỗi.';
  final updateProfile = 'Xảy ra lỗi trong khi cập nhật.';
  final updateBio = 'Xảy ra lỗi trong khi cập nhật tự giới thiệu.';
  final updateSolgan = 'Xảy ra lỗi trong khi cập nhật sologan.';
  final updateAvatar = 'Xảy ra lỗi trong khi cập nhật ảnh đại diện.';
  final unknowError = 'Lỗi không xác định';
}