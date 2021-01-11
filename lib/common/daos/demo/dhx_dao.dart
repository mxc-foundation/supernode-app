import 'package:flutter/foundation.dart';
import 'package:supernodeapp/common/daos/demo/demo_dao.dart';
import 'package:supernodeapp/common/daos/dhx_dao.dart';

class DemoDhxDao extends DemoDao implements DhxDao {
  Future<List<Council>> listCouncils() async {
    return [
      Council(chairOrgId: '123', name: 'Council', id: 'demo1'),
      Council(chairOrgId: '123', name: 'Council 2', id: 'demo1'),
    ];
  }

  Future<CreateCouncilResponse> createCouncil({
    @required String amount,
    @required String boost,
    @required String lockMonths,
    @required String name,
    @required String organizationId,
  }) async {
    return CreateCouncilResponse('demo-council', 'demo-stake');
  }

  Future<String> createStake({
    @required String amount,
    @required String boost,
    @required String councilId,
    @required String lockMonths,
    @required String organizationId,
  }) async {
    return 'demo-stake';
  }

  @override
  Future<LastMiningResponse> lastMining() async {
    return LastMiningResponse(DateTime.now(), '100000', '90000');
  }

  @override
  Future<List<StakeDHX>> listStakes({
    String chairOrgId = '0',
    String organizationId = '0',
  }) async {
    return [
      StakeDHX(
        amount: "123123",
        boost: "0.40",
        closed: false,
        councilId: "demo1",
        councilName: "Council 1",
        created: DateTime(2020, 12, 18, 15, 5),
        lockTill: DateTime(2021, 12, 18, 15, 5),
        currency: "ETH_MXC",
        dhxMined: "11111",
        lockMonths: "12",
        id: "demoStake",
        organizationId: "testOrgId",
      )
    ];
  }
}