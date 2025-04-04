import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/entities/common/credits/cast_entity.dart';
import 'package:tmdb/core/entities/common/credits/credits_entity.dart';
import 'package:tmdb/core/entities/common/credits/crew_entity.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/screen_utils.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/urls/urls.dart';
import 'package:tmdb/features/main/cast_crew/presentation/providers/see_all_cast_crew_scroll_controller_provider.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/pages/extra/celebrity_details_page_extra.dart';
import '../../../../../core/ui/utils.dart';

class SeeAllCastCrewPage extends StatefulWidget {
  final CreditsEntity credits;

  SeeAllCastCrewPage({required this.credits});

  @override
  _SeeAllCastCrewPageState createState() => _SeeAllCastCrewPageState();
}

class _SeeAllCastCrewPageState extends State<SeeAllCastCrewPage>
    with SingleTickerProviderStateMixin<SeeAllCastCrewPage> {
  late TabController _tabController;
  final _seeAllCastCrewControllerProvider =
      SeeAllCastCrewScrollControllerProvider();

  @override
  void initState() {
    int length = 0;
    if (widget.credits.cast.isNotEmpty && widget.credits.crew.isNotEmpty) {
      length = 2;
    } else {
      length = 1;
    }
    _tabController = TabController(length: length, vsync: this);
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _seeAllCastCrewControllerProvider.dispose();
    super.dispose();
  }

  List<Widget> get _buildPages {
    List<Widget> pages = [];

    if (widget.credits.cast.isNotEmpty) {
      pages.add(
        ChangeNotifierProvider.value(
          value: _seeAllCastCrewControllerProvider,
          child: _AllCredits(cast: widget.credits.cast),
        ),
      );
    }
    if (widget.credits.crew.isNotEmpty) {
      pages.add(
        ChangeNotifierProvider.value(
          value: _seeAllCastCrewControllerProvider,
          child: _AllCredits(crew: widget.credits.crew),
        ),
      );
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabController.length,
      child: Scaffold(
        body: NestedScrollView(
          controller: _seeAllCastCrewControllerProvider.parentScrollController,
          physics: ScrollPhysics(parent: PageScrollPhysics()),
          headerSliverBuilder: (context, _) {
            return [
              _tabController.length < 2
                  ? SliverAppBar(title: Text('Credits'), pinned: true)
                  : SliverAppBar(
                    title: Text('Credits'),
                    pinned: true,
                    floating: true,
                    snap: true,
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: <Tab>[Tab(text: 'Cast'), Tab(text: 'Crew')],
                    ),
                  ),
            ];
          },
          body: TabBarView(controller: _tabController, children: _buildPages),
        ),
      ),
    );
  }
}

class _AllCredits extends StatefulWidget {
  final List<CastEntity>? cast;
  final List<CrewEntity>? crew;

  _AllCredits({this.cast, this.crew});

  @override
  _AllCreditsState createState() => _AllCreditsState();
}

class _AllCreditsState extends State<_AllCredits>
    with AutomaticKeepAliveClientMixin<_AllCredits> {
  void _navigateToCelebritiesDetails(int id, String celebName) {
    appRouterConfig.push(
      context,
      location: AppRouterPaths.CELEBRITY_DETAILS,
      extra: CelebrityDetailsPageExtra(id: id, celebName: celebName),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final provider = context.read<SeeAllCastCrewScrollControllerProvider>();
    return NotificationListener<ScrollNotification>(
      onNotification: provider.onScrollNotification,
      child: ListView.separated(
        key: UniqueKey(),
        controller:
            widget.cast == null
                ? provider.scrollController1
                : provider.scrollController2,
        padding: EdgeInsets.only(
          left: PagePadding.leftPadding,
          bottom: PagePadding.bottomPadding,
          top: PagePadding.topPadding,
        ),
        itemBuilder: (context, index) {
          String? profilePath;
          String? job;
          if (widget.cast == null) {
            profilePath =
                widget.crew![index].profilePath != null
                    ? widget.crew![index].profilePath
                    : null;
            job =
                widget.crew![index].job != null ? widget.crew![index].job : '';
          } else {
            profilePath =
                widget.cast![index].profilePath != null
                    ? widget.cast![index].profilePath
                    : null;
            job = 'Acting';
          }
          if (profilePath != null) {
            profilePath = URLS.profileImageUrl(
              imageUrl: profilePath,
              size: ProfileSizes.w185,
            );
          }
          return GestureDetector(
            onTap: () {
              _navigateToCelebritiesDetails(
                widget.cast == null
                    ? widget.crew![index].id
                    : widget.cast![index].id,
                widget.cast == null
                    ? widget.crew![index].name
                    : widget.cast![index].name,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0, style: BorderStyle.none),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomNetworkImageWidget(
                    type: MediaImageType.Celebrity,
                    imageUrl: profilePath,
                    width: 70,
                    height: 105,
                    fit: BoxFit.fitHeight,
                    borderRadius: 0,
                    placeHolderSize: 60,
                  ),
                  Container(
                    width: 250,
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            widget.cast != null
                                ? widget.cast![index].name
                                : widget.crew![index].name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: Text(
                            job!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, right: 10),
                    child: Icon(
                      CupertinoIcons.forward,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 30, thickness: 0.2);
        },
        itemCount:
            widget.cast != null ? widget.cast!.length : widget.crew!.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
