import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:email_sender/src/emailsender_core.dart' show EmailSender;
import 'package:my_portfolio/core/app_const.dart';
part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

  void sendMail(String name, String email, String massage) =>
      _sendMessage(name, email, massage);

  Future<void> _sendMessage(String name, String email, String massage) async {
    if (name.isEmpty) {
      emit(ContactError("Name is missing"));
      return;
    } else if (email.isEmpty) {
      emit(ContactError("Email is missing"));
      return;
    } else if (massage.isEmpty) {
      emit(ContactError("Massage is missing"));
      return;
    }

    emit(ContactLoading());

    EmailSender emailsender = EmailSender();
    try {
      Map<String, dynamic> response = await emailsender.sendMessage(
        AppConstants.email,
        "FOR JOB FROM PORTFOLIO",
        "from : $name , my email : $email",
        massage,
      );
      if (response["message"] == "emailSendSuccess") {
        emit(ContactSucces());
      } else {
        emit(ContactError(response["message"]));
      }
    } catch (e) {
      emit(ContactError("ERROR : $e"));
    }
  }

  void rest() => emit(ContactInitial());
}
