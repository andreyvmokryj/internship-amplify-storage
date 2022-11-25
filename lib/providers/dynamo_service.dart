import 'package:aws_dynamodb_api/dynamodb-2012-08-10.dart';

class DynamoService {
  static final instance = DynamoDB(
    region: 'us-east-2',
    // credentials: AwsClientCredentials(
    //   accessKey: "",
    //   secretKey: ""
    // )
  );

  Future<Map<String, AttributeValue>?> getByKey(
      {required String tableName, required Map<String, AttributeValue> keyData}) async {
    var result = await instance.getItem(key: keyData, tableName: tableName);
    return result.item;
  }

  Future<List<Map<String, AttributeValue>>?> getAll(
      {required String tableName}) async {
    var result = await instance.scan(tableName: tableName);
    return result.items;
  }

  Future saveItem(Map<String, AttributeValue> dbData, String tableName) async {
    await instance.putItem(item: dbData, tableName: tableName);
  }

  Future deleteItem(Map<String, AttributeValue> keyData, String tableName) async {
    await instance.deleteItem(key: keyData, tableName: tableName);
  }
}