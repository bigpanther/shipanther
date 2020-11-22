part of 'container_bloc.dart';

@immutable
abstract class ContainerState {
  const ContainerState();
}

class ContainerInitial extends ContainerState {}

class ContainerLoading extends ContainerState {}

class ContainerLoaded extends ContainerState {
  final Container container;
  const ContainerLoaded(this.container);
}

class ContainersLoaded extends ContainerState {
  final List<Container> containers;
  const ContainersLoaded(this.containers);
}

class ContainerFailure extends ContainerState {
  final String message;
  const ContainerFailure(this.message);
}
