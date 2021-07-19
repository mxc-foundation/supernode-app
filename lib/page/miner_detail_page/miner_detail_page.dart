import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/miner_detail_page/tabs/miner_health_tab.dart';
import 'package:supernodeapp/page/miner_detail_page/tabs/miner_revenue_tab.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'tabs/miner_data_tab.dart';

class MinerDetailPage extends StatefulWidget {
  final GatewayItem item;

  const MinerDetailPage({Key key, this.item}) : super(key: key);

  @override
  _MinerDetailPageState createState() => _MinerDetailPageState();
}

class _MinerDetailPageState extends State<MinerDetailPage> {
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    context.read<GatewayCubit>().initMinerDetails(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: PageNavBar(
                text: widget.item.name,
                centerTitle: true,
                actionWidget: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl(
                  groupValue: selectedTab,
                  onValueChanged: (tabIndex) =>
                      setState(() => selectedTab = tabIndex),
                  thumbColor: ColorsTheme.of(context).mxcBlue,
                  children: <int, Widget>{
                    0: Text(
                      FlutterI18n.translate(context, 'health'),
                      style: TextStyle(
                        color: (selectedTab == 0)
                            ? ColorsTheme.of(context).buttonIconTextColor
                            : ColorsTheme.of(context).textLabel,
                      ),
                    ),
                    1: Text(
                      FlutterI18n.translate(context, 'revenue'),
                      style: TextStyle(
                        color: (selectedTab == 1)
                            ? ColorsTheme.of(context).buttonIconTextColor
                            : ColorsTheme.of(context).textLabel,
                      ),
                    ),
                    2: Text(
                      FlutterI18n.translate(context, 'data'),
                      style: TextStyle(
                        color: (selectedTab == 2)
                            ? ColorsTheme.of(context).buttonIconTextColor
                            : ColorsTheme.of(context).textLabel,
                      ),
                    ),
                  },
                ),
              ),
            ),
            Visibility(
              visible: selectedTab == 0,
              child: BlocBuilder<GatewayCubit, GatewayState>(
                buildWhen: (a, b) => (a.selectedGateway != b.selectedGateway ||
                    a.statsLast7days != b.statsLast7days ||
                    a.sumSecondsOnlineLast7days !=
                        b.sumSecondsOnlineLast7days ||
                    a.secondsLast7days != b.secondsLast7days),
                builder: (context, state) {
                  return MinerHealthTab(
                    item: state.selectedGateway,
                    healthStatisticsData: state.statsLast7days,
                    sumSecondsOnlineLast7days: state.sumSecondsOnlineLast7days,
                    secondsLast7days: state.secondsLast7days,
                    onRefresh:
                        context.read<GatewayCubit>().refreshSelectedGateway,
                  );
                },
              ),
            ),
            Visibility(
              visible: selectedTab == 1,
              child: BlocBuilder<GatewayCubit, GatewayState>(
                buildWhen: (a, b) => (a.statsLast7days != b.statsLast7days ||
                    a.sumMiningRevenueLast7days != b.sumMiningRevenueLast7days),
                builder: (context, state) {
                  return MinerRevenueTab(
                    item: widget.item,
                    revenueData: state.statsLast7days,
                    sumRevenueLast7days: state.sumMiningRevenueLast7days,
                  );
                },
              ),
            ),
            Visibility(
              visible: selectedTab == 2,
              child: BlocBuilder<GatewayCubit, GatewayState>(
                buildWhen: (a, b) => (a.framesLast7days != b.framesLast7days ||
                    a.downlinkPrice != b.downlinkPrice),
                builder: (context, state) {
                  return MinerDataTab(
                    item: widget.item,
                    framesData: state.framesLast7days,
                    downlinkPrice: state.downlinkPrice,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
