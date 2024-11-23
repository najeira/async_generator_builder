import 'package:flutter/widgets.dart';

class FutureGeneratorBuilder<T> extends StatelessWidget {
  const FutureGeneratorBuilder({
    super.key,
    required this.generator,
    required this.waiting,
    required this.done,
    required this.error,
  });

  final Future<T> Function() generator;

  final Widget Function(BuildContext) waiting;

  final Widget Function(BuildContext, T) done;

  final Widget Function(BuildContext, Object, StackTrace) error;

  @override
  Widget build(BuildContext context) {
    return _InitBuilder(
      generator: generator,
      builder: (context, value) {
        return FutureBuilder(
          future: value,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return error(context, snapshot.error!, snapshot.stackTrace!);
            } else if (snapshot.hasData) {
                return done(context, snapshot.requireData);
            }
            return waiting(context);
          },
        );
      },
    );
  }
}

class StreamGeneratorBuilder<T> extends StatelessWidget {
  const StreamGeneratorBuilder({
    super.key,
    required this.generator,
    required this.waiting,
    required this.active,
    required this.done,
    required this.error,
  });

  final Stream<T> Function() generator;

  final Widget Function(BuildContext) waiting;

  final Widget Function(BuildContext, T) active;

  final Widget Function(BuildContext, T?) done;

  final Widget Function(BuildContext, Object, StackTrace) error;

  @override
  Widget build(BuildContext context) {
    return _InitBuilder(
      generator: generator,
      builder: (context, value) {
        return StreamBuilder(
          stream: value,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return error(context, snapshot.error!, snapshot.stackTrace!);
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return waiting(context);
              case ConnectionState.waiting:
                return waiting(context);
              case ConnectionState.active:
                return active(context, snapshot.requireData);
              case ConnectionState.done:
                return done(context, snapshot.data);
            }
          },
        );
      },
    );
  }
}

class _InitBuilder<T> extends StatefulWidget {
  const _InitBuilder({
    super.key,
    required this.generator,
    required this.builder,
  });

  final T Function() generator;

  final Widget Function(BuildContext, T) builder;

  @override
  State<_InitBuilder<T>> createState() => _InitBuilderState();
}

class _InitBuilderState<T> extends State<_InitBuilder<T>> {
  late T value;

  @override
  void initState() {
    super.initState();
    value = widget.generator();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value);
  }
}
