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
            height: 50,
            padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10
            ),
            color: Theme.of(context).primaryColor,
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
                  PAMBottomIcon(
                      icon: const Icon(Icons.notifications, color: Colors.white),
                      backgroundColor: Colors.black54.withOpacity(0.5)
                  ),
                  const SizedBox(width: 10),
                  PAMBottomIcon(
                    icon: const Icon(Icons.segment, color: Colors.white),
                    backgroundColor: Colors.black54.withOpacity(0.5),
                    onTab: handlingTabOptions,
                  )
                ],
              ),
            ),
          );
        })
    );
  }
}