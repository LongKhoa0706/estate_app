
import 'package:intl/intl.dart';

class Format{
  String formatDate(String dateTime){
    final time = DateTime.parse(dateTime).toLocal();
    String date = DateFormat("dd-MM-yyyy hh:mm:ss").format(time);
    return date;
  }


  String formatMoney(int money){
    final formatter = NumberFormat.compactLong(locale: "vi_VN");
    String moneyy  = formatter.format(money);
    return moneyy;
  }

}