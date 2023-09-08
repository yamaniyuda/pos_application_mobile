part of 'home_screen.dart';

/// This is custom header, header
/// automatic change color when scroll and
/// base this component use sliver
class _HeaderHome extends StatelessWidget {
  final controller = Get.find<HomeController>();
  _HeaderHome();

  @override
  Widget build(BuildContext context) {

    /// change theme and color status bar and bottom bar
    SystemUtils.changeStatusAndBottomBarColor(context,
        statusBarColor: Theme.of(context).primaryColor,
        statusBarIconBrightness: Brightness.light
    );

    void handlingTabOptions() {
      Get.toNamed(Routes.account);
    }

    return SafeArea(
        top: false,
        child: Obx(() {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 120,
            padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Color(0xffd43f8d)
                ]
              )
            ),
            child: SafeArea(
              child: Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 14.sp,
                      backgroundImage: const AssetImage(
                        "assets/images/account.png",
                      )
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${controller.authService.userEntity!.name}",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {}, 
                    icon: const Icon(Icons.notifications, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: handlingTabOptions, 
                    icon: const Icon(Icons.segment, color: Colors.white)
                  ),
                ],
              ),
            ),
          );
        })
    );
  }
}