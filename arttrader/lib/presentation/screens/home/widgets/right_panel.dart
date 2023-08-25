import 'package:arttrader/export.dart';
import 'package:intl/intl.dart';

class RightPanel extends StatefulWidget {
  final Art art;
  const RightPanel({
    Key? key,
    required this.art,
  }) : super(key: key);

  @override
  State<RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends State<RightPanel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LikeButtonWidget(
            size: 18,
            art: widget.art,
          ),
          const SizedBox(
            height: 10,
          ),
          SaveButtonWidget(
            art: widget.art,
            //size: 18,
          ),
          const SizedBox(
            height: 10,
          ),
          ShareWidgetButton(
            art: widget.art,
          ),
          Text(
            context.strings.shareText,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class LikeButtonWidget extends StatefulWidget {
  final Art art;
  const LikeButtonWidget({super.key, required double size, required this.art});

  @override
  State<LikeButtonWidget> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButtonWidget> {
  bool isLiked = false;
  int likeCount = 0;

  @override
  Widget build(BuildContext context) {
    const double size = 35;

    return LikeButton(
      postFrameCallback: (state) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> userList = prefs.getStringList('userLikes') ?? [];
        setState(() {
          if (userList.contains(widget.art.id)) {
            isLiked = true;
          } else {
            isLiked = false;
          }
          likeCount = widget.art.likes!;
        });
      },
      likeCountAnimationType: widget.art.likes! > 999
          ? LikeCountAnimationType.none
          : LikeCountAnimationType.part,
      size: size,
      isLiked: isLiked,
      likeCount: likeCount,
      likeBuilder: (isLiked) {
        final color = isLiked ? Colors.red : Colors.white;
        return Icon(
          Icons.favorite,
          color: color,
          size: size,
        );
      },
      countBuilder: (count, isLiked, text) {
        const color = Colors.white;

        return Text(
            NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
                .format(int.tryParse(text)),
            style: const TextStyle(
                color: color, fontSize: 15, fontWeight: FontWeight.bold));
      },
      countPostion: CountPostion.bottom,
      onTap: (isLiked) async {
        likeCount += isLiked ? -1 : 1;
        //server request
        context
            .read<ArtBloc>()
            .add(UpdateLikeCount(art: widget.art, newLikeCount: likeCount));
        return !isLiked;
      },
    );
  }
}

class SaveButtonWidget extends StatefulWidget {
  final Art art;

  const SaveButtonWidget({super.key, required this.art});

  @override
  State<SaveButtonWidget> createState() => _SaveButtonWidgetState();
}

class _SaveButtonWidgetState extends State<SaveButtonWidget> {
  bool isSaved = false;
  int savedCount = 17;

  @override
  Widget build(BuildContext context) {
    const double size = 35;

    return LikeButton(
      postFrameCallback: (state) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> userList = prefs.getStringList('userSavedList') ?? [];
        setState(() {
          if (userList.contains(widget.art.id)) {
            isSaved = true;
          } else {
            isSaved = false;
          }
          savedCount = widget.art.savedCount!;
        });
      },
      likeCountAnimationType: widget.art.savedCount! > 999
          ? LikeCountAnimationType.none
          : LikeCountAnimationType.part,

      size: size,
      isLiked: isSaved,
      likeCount: savedCount,
      likeBuilder: (isSaved) {
        final color = isSaved ? Colors.red : Colors.white;
        return Icon(
          isSaved ? Icons.bookmark_added_rounded : Icons.bookmark_add,
          color: color,
          size: size,
        );
      },
      countBuilder: (count, isSaved, text) {
        const color = Colors.white;

        return Text(
            NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
                .format(int.tryParse(text)),
            style: const TextStyle(
                color: color, fontSize: 15, fontWeight: FontWeight.bold));
      },
      countPostion: CountPostion.bottom,
      //likeCountPadding: const EdgeInsets.only(left: 12),
      onTap: (isSaved) async {
        savedCount += isSaved ? -1 : 1;
        //server request
        context
            .read<ArtBloc>()
            .add(UpdateSavedCount(art: widget.art, newSavedCount: savedCount));
        if (!isSaved) {
          SnackbarHelper.showSnackBar(context, context.strings.addedToSaved);
        }

        return !isSaved;
      },
    );
  }
}

class ShareWidgetButton extends StatefulWidget {
  final Art art;

  const ShareWidgetButton({super.key, required this.art});

  @override
  State<ShareWidgetButton> createState() => _ShareWidgetButtonState();
}

class _ShareWidgetButtonState extends State<ShareWidgetButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isimageError = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(
      curve: Curves.linear,
      parent: _animationController,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed) {}
      });
    _animationController.repeat(reverse: true);

    super.initState();
  }

  void canceLisetner() {
    // ignore: invalid_use_of_protected_member
    _animationController.clearListeners();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 37 + (_animation.value * 4),
        height: 37 + (_animation.value * 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: ElevatedButton(
          onPressed: () {
            ShareHelper.share(widget.art.name!, widget.art.imageUrl!);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
          ),
          child: const Icon(
            Icons.ios_share_outlined,
            color: Colors.black,
          ),
        ));
  }
}
