abstract class Adapter<Type>{
  Map<String, dynamic> toMap(Type object);
  Type fromMap(Map<String, dynamic> map);
}