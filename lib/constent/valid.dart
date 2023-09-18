validInput(String val, String text1,String text2) {
  if (val.length !=  text1.length) {
    return "$messageInputMax";
  }
  // if (val.isEmpty) {
  //   return "$messageInputEmpty";
  // }
  // if (val.length < min) {
  //   return "$essageInputMin $min";
  // }
}


const String messageInputEmpty = "Password Error ..!";

const String messageInputMin = "this Field cannot be less than!";

const String messageInputMax = "this Field cannot be greater than!";