import 'package:flutter/material.dart';
import 'package:wheelmap/common/constants/app_colors.dart';
import 'package:wheelmap/common/constants/app_strings.dart';
import 'package:wheelmap/presentation/common_widgets/text_widgets.dart';
import 'package:wheelmap/presentation/plan/plan_cubit.dart';
import 'package:wheelmap/domain/entities/instruction.dart';

// Class to create card showing current user location
class InstructionsPanel extends StatelessWidget {
  final PlanCubit cubit;
  final bool instructionExpanded;
  final Function(bool) updateInstructionExpanded;
  final List<Instruction> instructions;

  const InstructionsPanel({
    Key? key,
    required this.instructionExpanded,
    required this.updateInstructionExpanded,
    required this.instructions,
    required this.cubit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
          elevation: 0,
          expansionCallback: (panelIndex, isExpanded) => cubit
              .updateInstructionExpanded(!instructionExpanded),
          children: [
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  contentPadding: EdgeInsets.all(0),
                  horizontalTitleGap: 0,
                  title: Text(
                    AppStrings.accessibilityInstructionsText,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  onTap: () {
                    cubit.updateInstructionExpanded(
                        !instructionExpanded);
                  },
                );
              },
              body: Column(
                  children: instructions.map<Widget>((e) {
                    return Column(
                      children: [
                        ListTile(
                          titleTextStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.bodyTextColorDark),
                          subtitleTextStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.bodyTextColorDark),
                          title: Text("On ${e.name}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.instruction),
                              Text(
                                  "Distance: ${double.parse((e.distance / 1000).toStringAsFixed(2))} km"),
                              Text(
                                  "Duration: ${cubit.secondsToMinutes(time: e.duration.toInt())}")
                            ],
                          ),
                          leading: Icon(
                            e.icon,
                          ),
                        ),
                        Divider()
                      ],
                    );
                  }).toList()),
              isExpanded: instructionExpanded,
            ),
          ],
    );
  }
}
