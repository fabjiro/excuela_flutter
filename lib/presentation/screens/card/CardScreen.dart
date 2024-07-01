import 'package:excuela_flutter/presentation/blocs/card_screen/card_screen_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Screen'),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 7,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15.0),
                    ),
                    child: Image.network(
                      "https://www.latercera.com/resizer/5jZzk4l74Ts91ETN8bVr8U_JpBA=/900x600/smart/arc-anglerfish-arc2-prod-copesa.s3.amazonaws.com/public/OYHQHMGMHZA25PRC6GMCQLFCCY.jpg",
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Titulo de la tarjeta',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => null,
                                icon: const Icon(Icons.bookmark),
                              ),
                              IconButton(
                                onPressed: () => null,
                                icon: const Icon(Icons.share),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              BlocBuilder<CardScreenBloc, CardScreenState>(
                                builder: (context, state) {
                                  return Badge(
                                    label: state.countLike > 0 ? Text(state.countLike.toString()) : null,
                                    child: IconButton(
                                      onPressed: () {
                                        context.read<CardScreenBloc>().add(const AddLike());
                                      },
                                      icon: const Icon(Icons.thumb_up),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                onPressed: () => null,
                                icon: const Icon(Icons.comment),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
