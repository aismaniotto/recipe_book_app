abstract class Adapter<T> {
  Map<String, dynamic> toMap(T object);
  T fromMap(Map<String, dynamic> map);
}