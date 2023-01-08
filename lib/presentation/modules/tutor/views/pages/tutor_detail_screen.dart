part of '../tutor_screen.dart';

extension TutorInfoPage on _TutorScreenState {
  Widget _buildTutorInfoPage(TutorState state) {
    return SmartRefresherWrapper.build(
      controller: infoRefreshController,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 16),
            if (tutor?.video.isNotNullOrEmpty == true) _buildTutorVideo(),
            ..._buildTutorInfo(state),
            _buildGeneralInfo(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTutorInfo(TutorState state) {
    return [
      BoxColor(
        color: AppColor.white,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 16),
        borderRadius: BorderRadius.circular(16),
        child: Column(children: [
          Row(
            children: [
              const SizedBox(width: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImageWrapper.avatar(
                  url: tutor?.avatar ?? '',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      tutor?.name ?? '--',
                      style: textTheme.bodyText1?.copyWith(
                        fontSize: 14,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      tutor?.bio ?? '--',
                      style: textTheme.bodyText2?.copyWith(
                        fontSize: 12,
                        color: AppColor.grayAD,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 8,
              thickness: 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoButton(
                iconData: tutor?.isFavorite == true
                    ? Icons.favorite
                    : Icons.favorite_outline,
                title: trans.favorite,
                onTap: _onTapFavorite,
                color: AppColor.red,
              ),
              _buildInfoButton(
                iconData: Icons.report,
                title: trans.report,
                onTap: _onTapFavorite,
              ),
              _buildInfoButton(
                iconData: Icons.star_outline,
                title: trans.reviews,
                onTap: _onTapReviews,
              ),
            ],
          ),
        ]),
      )
    ];
  }

  Widget _buildInfoButton({
    required String title,
    required IconData iconData,
    required void Function() onTap,
    Color? color = AppColor.primaryColor,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(iconData, size: 20, color: color),
        ),
        Text(
          title,
          style: textTheme.bodyText1?.copyWith(
            fontSize: 12,
            color: color,
          ),
        )
      ],
    );
  }

  Widget _buildTutorVideo() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: vpController.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            VideoPlayer(vpController),
            ClosedCaption(text: vpController.value.caption.text),
            ControlsOverlay(controller: vpController),
            VideoProgressIndicator(vpController, allowScrubbing: true),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralInfo() {
    final infos = [
      {trans.languages: tutor?.language},
      {
        trans.specialty: tutor?.specialties
            ?.split(',')
            .map((e) => Specialty.jsonMap[e]?.localized(trans) ?? e)
            .join(', '),
      },
      {trans.interests: tutor?.interests},
      {trans.teachingExperience: tutor?.experience}
    ];
    return BoxColor(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => _buildGeneralInfoItem(
          title: infos.elementAt(index).keys.first,
          content: infos.elementAt(index).values.first,
        ),
        separatorBuilder: (context, index) => Divider(
          height: 32,
          thickness: 1,
        ),
        itemCount: infos.length,
      ),
    );
  }

  Widget _buildGeneralInfoItem({String? title, String? content}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title ?? '--',
            style: textTheme.bodyText1,
          ),
        ),
        Expanded(
            child: Text(
          content ?? '--',
          textAlign: TextAlign.right,
          style: textTheme.bodyText2?.copyWith(fontSize: 14),
        )),
      ],
    );
  }
}
