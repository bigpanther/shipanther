part of 'container_bloc.dart';

@immutable
abstract class ContainerEvent {
  const ContainerEvent();
}

class GetContainer extends ContainerEvent {
  final String id;
  const GetContainer(this.id);
}

class UpdateContainer extends ContainerEvent {
  final String id;
  final Container container;
  const UpdateContainer(this.id, this.container);
}

class CreateContainer extends ContainerEvent {
  final Container container;
  const CreateContainer(this.container);
}

class DeleteContainer extends ContainerEvent {
  final String id;
  const DeleteContainer(this.id);
}

class GetContainers extends ContainerEvent {
  final User user;
  const GetContainers(this.user);
}
