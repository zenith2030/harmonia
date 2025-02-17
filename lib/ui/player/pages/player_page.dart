import 'package:flutter/material.dart';
import 'package:harmonia/app/dependencies.dart';
import 'package:harmonia/player/data/repositories/trilha_sonora_repository.dart';
import 'package:harmonia/ui/player/widgets/gradient_background.dart';
import 'package:harmonia/ui/player/widgets/trilha_sonora_list.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({
    super.key,
  });

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> with TickerProviderStateMixin {
  late Animation<Offset> playerPageAnimation;
  late AnimationController animateController;
  late Animation<Offset> listAnimation;
  final repository = injector.get<TrilhaSonoraRepository>();

  @override
  void initState() {
    super.initState();
    animateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    playerPageAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: animateController, curve: Curves.easeOut),
    );
    listAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animateController, curve: Curves.easeIn),
    );
  }

  bool listEnable = false;
  @override
  Widget build(BuildContext context) {
    double sizeMiddle = MediaQuery.sizeOf(context).shortestSide * 0.5;
    return Scaffold(
      body: GradientBackground(
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SlideTransition(
                position: playerPageAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: sizeMiddle,
                      width: sizeMiddle,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white70,
                          width: 5.0,
                        ),
                      ),
                      child: Icon(
                        Icons.music_note,
                        size: sizeMiddle * 0.5,
                        color: Colors.white70,
                      ),
                    ),
                    Row(
                      spacing: 22.0,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          color: listEnable ? Colors.red : Colors.white,
                          icon: listEnable
                              ? Icon(Icons.list_outlined, size: 36.0)
                              : Icon(Icons.list, size: 30.0),
                          onPressed: () {
                            listEnable = !listEnable;
                            setState(() {});
                            switch (animateController.status) {
                              case AnimationStatus.dismissed:
                                animateController.forward();
                                break;
                              case AnimationStatus.completed:
                                animateController.reverse();
                                break;
                              case AnimationStatus.forward:
                              case AnimationStatus.reverse:
                                break;
                            }
                          },
                        ),
                        IconButton(
                          color: Colors.white,
                          icon: const Icon(Icons.play_arrow, size: 30.0),
                          onPressed: () {},
                        ),
                        IconButton(
                          color: Colors.white,
                          icon: const Icon(Icons.volume_up, size: 30.0),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SlideTransition(
                position: listAnimation,
                child: TrilhasMusicais(repository: repository),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrilhasMusicais extends StatelessWidget {
  const TrilhasMusicais({
    super.key,
    required this.repository,
  });

  final TrilhaSonoraRepository repository;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      height: MediaQuery.sizeOf(context).height * 0.4,
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 30.0),
              Icon(Icons.list, size: 30.0),
              const SizedBox(width: 20.0),
              Text(
                'Trilhas Musicais',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(
            color: Colors.black54,
            indent: 20.0,
            endIndent: 20.0,
          ),
          TrilhaSonoraList(repository: repository),
        ],
      ),
    );
  }
}
