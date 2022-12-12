import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/widgets/moneyDistribution.dart';
part 'distribution_store.g.dart';

class DistributionStore = _DistributionStoreBase with _$DistributionStore;

abstract class _DistributionStoreBase with Store {
  int rib;
  Function distributionTime;
  _DistributionStoreBase(this.rib, this.distributionTime);
  displayDistributionScreen(context, PublicGoodsVariables variables,
      Function concludeDistribution, Function distributeRib) async {
    //calculateRib(variables);
    double dHeight =
        MediaQuery.of(context).size.height - Resize.getHeight(context);
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: new Dialog(
                insetPadding: EdgeInsets.symmetric(
                    horizontal: Resize.getWidth(context) * 0.05,
                    vertical: (dHeight > 0)
                        ? dHeight * 0.5
                        : Resize.getWidth(context) * 0.05),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Resize.getHeight(context) * 0.01),
                ),
                child: new MoneyDistribution(
                  rib,
                  variables.notRealPlayers,
                  variables.timeDistribution,
                  distributeRib,
                  distributionTime: distributionTime,
                )))).then((value) {
      concludeDistribution();
    });
  }
}
