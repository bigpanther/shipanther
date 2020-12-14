part of 'container_bloc.dart';

@immutable
abstract class ContainerEvent {
  const ContainerEvent();
}

class GetContainer extends ContainerEvent {
  const GetContainer(this.id);
  final String id;
}

class UpdateContainer extends ContainerEvent {
  const UpdateContainer(this.id, this.container);
  final String id;
  final Container container;
}

class CreateContainer extends ContainerEvent {
  const CreateContainer(this.container);
  final Container container;
}

class DeleteContainer extends ContainerEvent {
  const DeleteContainer(this.id);
  final String id;
}

class GetContainers extends ContainerEvent {
  const GetContainers();
}
