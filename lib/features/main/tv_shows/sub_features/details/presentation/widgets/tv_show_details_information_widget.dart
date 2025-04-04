import 'package:flutter/material.dart';

import '../../../../../../../core/entities/common/production_company_entity.dart';
import '../../../../../../../core/entities/tv_show/creator_entity.dart';
import '../../../../../../../core/entities/tv_show/network_entity.dart';
import '../../../../../../../core/ui/widgets/details/details_divider_widget.dart';

class TvShowDetailsInformationWidget extends StatelessWidget {
  final List<CreatorEntity> createdBy;
  final String? firstAirDate;
  final String? language;
  final List<String> countryOrigin;
  final List<NetworkEntity>? networks;
  final List<ProductionCompanyEntity> productionCompanies;

  const TvShowDetailsInformationWidget(
      {super.key,
      required this.createdBy,
      required this.firstAirDate,
      required this.language,
      required this.countryOrigin,
      required this.networks,
      required this.productionCompanies});

  Widget _getSizedBoxHeight(int length) {
    double factor = 0;
    if (length == 1) {
      return SizedBox(
        height: 0,
      );
    } else {
      for (int i = 1; i <= length; i++) {
        if (i % 2 == 0) {
          factor = 2;
        } else {
          factor = 1.5;
        }
      }
    }

    double height = (length.toDouble() / factor) * 15;

    return SizedBox(
      height: height,
    );
  }

  Widget _buildNetworksWidget(List<NetworkEntity> networks) {
    List<Text> items = networks.map((network) {
      return Text(
        network.name,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: items,
      ),
    );
  }

  Widget _buildCountryOfOriginWidget(List<String> countryOfOrigin) {
    List<Text> items = countryOfOrigin.map((country) {
      return Text(
        country,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: items,
      ),
    );
  }

  Widget _buildCreatedByWidget(List<CreatorEntity> creators) {
    List<Text> items = creators.map((creator) {
      return Text(
        creator.name,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: items,
      ),
    );
  }

  Widget _buildInformationWidgetItemTitle(String category) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Text(
        category,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[300]),
      ),
    );
  }

  Widget _buildInformationWidgetItemData(String data) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2),
      child: Text(
        data,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey),
      ),
    );
  }

  Widget _buildProductionCompaniesItems(
      List<ProductionCompanyEntity> productionCompanies) {
    List<Text> items = productionCompanies.map((productionCompany) {
      return Text(
        productionCompany.name,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>? informationTitles;
    List<Widget>? informationData;

    if (createdBy.isNotEmpty) {
      informationTitles = [
        _buildInformationWidgetItemTitle('Created by'),
        _getSizedBoxHeight(createdBy.length)
      ];
      informationData = [_buildCreatedByWidget(createdBy)];
    }

    if (firstAirDate != null && firstAirDate!.isNotEmpty) {
      if (informationTitles == null ||
          informationTitles.isEmpty && informationData == null ||
          informationData!.isEmpty) {
        informationTitles = [
          _buildInformationWidgetItemTitle('First Air Date')
        ];
        informationData = [_buildInformationWidgetItemData(firstAirDate!)];
      } else {
        informationTitles
            .add(_buildInformationWidgetItemTitle('First Air Date'));
        informationData.add(_buildInformationWidgetItemData(firstAirDate!));
      }
    }

    if (language != null && language!.isNotEmpty) {
      if (informationTitles == null ||
          informationTitles.isEmpty && informationData == null ||
          informationData!.isEmpty) {
        informationTitles = [_buildInformationWidgetItemTitle('Language')];
        informationData = [_buildInformationWidgetItemData(language!)];
      } else {
        informationTitles.add(_buildInformationWidgetItemTitle('Language'));
        informationData.add(_buildInformationWidgetItemData(language!));
      }
    }

    if (countryOrigin.isNotEmpty) {
      if (informationTitles == null ||
          informationTitles.isEmpty && informationData == null ||
          informationData!.isEmpty) {
        informationTitles = [
          _buildInformationWidgetItemTitle('Country of Origin'),
          _getSizedBoxHeight(countryOrigin.length)
        ];
        informationData = [_buildCountryOfOriginWidget(countryOrigin)];
      } else {
        informationTitles.addAll([
          _buildInformationWidgetItemTitle('Country of Origin'),
          _getSizedBoxHeight(countryOrigin.length)
        ]);

        informationData.add(_buildCountryOfOriginWidget(countryOrigin));
      }
    }

    if (networks != null && networks!.isNotEmpty) {
      if (informationTitles == null ||
          informationTitles.isEmpty && informationData == null ||
          informationData!.isEmpty) {
        informationTitles = [
          _buildInformationWidgetItemTitle('Networks'),
          _getSizedBoxHeight(networks!.length)
        ];
        informationData = [_buildNetworksWidget(networks!)];
      } else {
        informationTitles.addAll([
          _buildInformationWidgetItemTitle('Networks'),
          _getSizedBoxHeight(networks!.length)
        ]);

        informationData.add(_buildNetworksWidget(networks!));
      }
    }

    if (productionCompanies.isNotEmpty) {
      if (informationTitles == null ||
          informationTitles.isEmpty && informationData == null ||
          informationData!.isEmpty) {
        informationTitles = [
          _buildInformationWidgetItemTitle('Production Companies'),
          _getSizedBoxHeight(productionCompanies.length)
        ];
        informationData = [_buildProductionCompaniesItems(productionCompanies)];
      } else {
        informationTitles.addAll([
          _buildInformationWidgetItemTitle('Production Companies'),
          _getSizedBoxHeight(productionCompanies.length)
        ]);

        informationData
            .add(_buildProductionCompaniesItems(productionCompanies));
      }
    }

    if (informationTitles == null || informationTitles.isEmpty) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DetailsDividerWidget(topPadding: 15),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 13),
          child: Text('Information'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: informationTitles,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: informationData!,
              )
            ],
          ),
        ),
      ],
    );
  }
}
