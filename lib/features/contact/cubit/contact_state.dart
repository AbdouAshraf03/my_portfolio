part of 'contact_cubit.dart';

sealed class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

final class ContactInitial extends ContactState {}

final class ContactLoading extends ContactState {}

final class ContactError extends ContactState {
  final String massage;

  const ContactError(this.massage);

  @override
  List<Object> get props => [massage];
}

final class ContactSucces extends ContactState {}
