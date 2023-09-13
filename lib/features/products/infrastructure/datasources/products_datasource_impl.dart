import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/infrastructure.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  late final Dio dio;
  final String accessToken;

  ProductsDatasourceImpl({required this.accessToken})
      : dio = Dio(
          BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {'Authorization': 'Bearer $accessToken'},
          ),
        );

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final response = await dio.get('/products/$id');

      final Product product = ProductMapper.jsonToEntity(response.data);

      return product;
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) throw ProductNotFound();
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, offset = 0}) async {
    try {
      final List<Product> products = [];

      final response =
          await dio.get<List>('/products?limit=$limit&offset=$offset');

      for (final product in response.data ?? []) {
        products.add(ProductMapper.jsonToEntity(product));
      }

      return products;
    } catch (e) {
      throw Exception(e);
    }
  }
}
