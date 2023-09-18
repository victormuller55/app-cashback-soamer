abstract class HomeEvent {}

class HomeLoadEvent extends HomeEvent {
  String email;
  HomeLoadEvent(this.email);
}