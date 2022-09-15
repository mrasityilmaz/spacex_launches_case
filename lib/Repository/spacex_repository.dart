import '../DataProvider/spacex_data_provider.dart';

class SpaceXRepository {
  final SpaceXDataProvider dataProvider;
  SpaceXRepository(this.dataProvider);

  Future<Object> getLastLaunch() async {
    return await dataProvider.getLastLaunch();
  }

  Future<Object> getAllLaunchs() async {
    return await dataProvider.getAllLaunchs();
  }
}
