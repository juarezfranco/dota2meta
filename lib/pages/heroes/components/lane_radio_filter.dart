import 'package:dota2meta/enums/lane_role.dart';
import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaneRadioFilter extends StatelessWidget {
  final LaneRole lane;

  const LaneRadioFilter(this.lane, {super.key});

  void _selected(BuildContext context) {
    BlocProvider.of<HeroesBloc>(context).add(HeroesLaneFiltered(lane));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeroesBloc, HeroesState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => _selected(context),
          child: Row(
            children: [
              SizedBox(
                width: 30,
                child: Radio<LaneRole>(
                  groupValue: state.selectedLane,
                  value: lane,
                  onChanged: (value) => _selected(context),
                ),
              ),
              Text(
                _laneDescription(lane).toUpperCase(),
                style: const TextStyle(
                  fontSize: 12
                ),
              )
            ],
          ),
        );
      },
    );
  }

  String _laneDescription(LaneRole lane) {
    return {
      LaneRole.safe: "Safe Lane",
      LaneRole.mid: "Mid Lane",
      LaneRole.off: "Offlane",
      LaneRole.jungle: "Jungle",
    }[lane]!;
  }
}
