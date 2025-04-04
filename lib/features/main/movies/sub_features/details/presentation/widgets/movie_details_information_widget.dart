import 'package:flutter/material.dart';
import 'package:tmdb/core/entities/common/production_company_entity.dart';

import '../../../../../../../core/ui/widgets/details/details_divider_widget.dart';

class MovieDetailsInformationWidget extends StatelessWidget {
  final String? releaseDate;
  final String? language;
  final String budget;
  final String revenue;
  final List<ProductionCompanyEntity> productionCompanies;

  const MovieDetailsInformationWidget({
    super.key,
    required this.releaseDate,
    required this.language,
    required this.budget,
    required this.revenue,
    required this.productionCompanies,
  });

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

    return Container(
      width: 200,
      margin: const EdgeInsets.only(left: 8.0, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                children: <Widget>[
                  if (releaseDate != null)
                    _buildInformationWidgetItemTitle('Release Date'),
                  if (language != null)
                    _buildInformationWidgetItemTitle('Language'),
                  if (budget != '0') _buildInformationWidgetItemTitle('Budget'),
                  if (revenue != '0')
                    _buildInformationWidgetItemTitle('Revenue'),
                  if (productionCompanies.isNotEmpty)
                    _buildInformationWidgetItemTitle('Production Companies'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (releaseDate != null)
                    _buildInformationWidgetItemData(releaseDate!),
                  if (language != null)
                    _buildInformationWidgetItemData(language!),
                  if (budget != '0') _buildInformationWidgetItemData(budget),
                  if (revenue != '0') _buildInformationWidgetItemData(revenue),
                  if (productionCompanies.isNotEmpty)
                    _buildProductionCompaniesItems(productionCompanies),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
