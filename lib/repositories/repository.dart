abstract class IRepository<T> {
  Future<void> add(T object);

  Future<T?> find();

  Future<void> update();

  Future<void> delete();
}
