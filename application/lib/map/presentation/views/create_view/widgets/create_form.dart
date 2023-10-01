import 'package:application/map/presentation/cubits/create_form/task_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({super.key, required this.onCreate});

  final Function onCreate;

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {


  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();


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
            TextField(
              onChanged: (value) => context
                  .read<TaskFormCubit>()
                  .handleRadiusChange(
                      value != "" ? double.tryParse(value) ?? 0 : 0),
              decoration: const InputDecoration(
                  hintText: "Radius (in meters)",
                  prefixIcon: Icon(Icons.radar),
                  prefixIconColor: Colors.white),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) =>
                  context.read<TaskFormCubit>().handleMemoChange(value),
              minLines: 3,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Memo",
              ),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
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
                  context.read<TaskFormCubit>().handleFromTimeChange(t);
                  fromController.text = t.format(context);
                }
              },
              // enabled: false,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
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
                  context.read<TaskFormCubit>().handleToTimeChange(t);
                  toController.text = t.format(context);
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => widget.onCreate(),
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
                "Create",
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
