import '../entities/product.dart';

abstract class ProductsDatasource {
  Future<List<Product>> getProductsByPage({int limit = 10, offset = 0});
  Future<Product> getProductById(String id);
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike);
}
