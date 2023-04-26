import 'dart:math';

String OTPgenerator() {
  var rng = new Random();
  var rand = rng.nextInt(9000) + 999;
  return rand.toInt().toString();
}

bool otp_compare(String message, String messagecmpTo) {
  if (message == messagecmpTo)
    return true;
  else
    return false;
}