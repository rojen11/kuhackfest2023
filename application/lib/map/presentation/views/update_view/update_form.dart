import 'package:application/map/presentation/cubits/update_form/update_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateForm extends StatefulWidget {
  const UpdateForm({super.key, required this.onUpdate});

  final Function onUpdate;

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController radiusController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            BlocBuilder<UpdateFormCubit, UpdateFormState>(
              builder: (context, state) {
                radiusController.text = state.radius.toString();
                return TextFormField(
                  controller: radiusController,
                  onChanged: (value) => context
                      .read<UpdateFormCubit>()
                      .handleRadiusChange(
                          value != "" ? double.tryParse(value) ?? 0 : 0),
                  decoration: const InputDecoration(
                      hintText: "Radius (in meters)",
                      prefixIcon: Icon(Icons.radar),
                      prefixIconColor: Colors.white),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<UpdateFormCubit, UpdateFormState>(
              builder: (context, state) {
                memoController.text = state.memo;

                return TextFormField(
                  controller:  memoController,
                  onChanged: (value) =>
                      context.read<UpdateFormCubit>().handleMemoChange(value),
                  minLines: 3,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "Memo",
                  ),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<UpdateFormCubit, UpdateFormState>(
              builder: (context, state) {
                fromController.text = state.from?.format(context) ?? "";
                return TextFormField(
                  decoration: const InputDecoration(
                      hintText: "From",
                      prefixIcon: Icon(Icons.timer),
                      prefixIconColor: Colors.white),
                  style: const TextStyle(color: Colors.white),
                  readOnly: true,
                  controller: fromController,
                  onTap: () async {
                    TimeOfDay? t = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (t != null && context.mounted) {
                      context.read<UpdateFormCubit>().handleFromTimeChange(t);
                      fromController.text = t.format(context);
                    }
                  },
                  // enabled: false,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<UpdateFormCubit, UpdateFormState>(
              builder: (context, state) {
                toController.text = state.to?.format(context) ?? "";
                return TextFormField(
                  decoration: const InputDecoration(
                      hintText: "To",
                      prefixIcon: Icon(Icons.alarm_off),
                      prefixIconColor: Colors.white),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.datetime,
                  readOnly: true,
                  controller: toController,
                  onTap: () async {
                    TimeOfDay? t = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (t != null && context.mounted) {
                      context.read<UpdateFormCubit>().handleToTimeChange(t);
                      toController.text = t.format(context);
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => widget.onUpdate(),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  )),
              child: const Text(
                "Update",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
