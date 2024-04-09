import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/injection.dart';
import 'package:task_manager/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/features/task_management/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/task_management/presentation/pages/task_detailes.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity taskEntity;
  TaskItem({Key? key, required this.taskEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Dismissible(
        key: Key(taskEntity.id.toString()),
        background: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(18),
          ),
          padding: EdgeInsets.only(right: 20.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          // _deleteTransaction(_transaction.id);
        },
        confirmDismiss: (DismissDirection direction) async {
          Widget dialog;

          if (direction == DismissDirection.startToEnd) {
            dialog = AlertDialog(
              title: Text("Confirm"),
              content: Text("Are you sure you wish to edit this transaction?"),
              actions: <Widget>[
                MaterialButton(
                    onPressed: () {
                      // Navigator.of(context).pop(false);

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DetailsPage(transaction: _transaction),
                      //   ),
                      // );
                    },
                    child: Text(
                      "EDIT",
                      style: TextStyle(color: Colors.green),
                    )),
                MaterialButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("CANCEL"),
                ),
              ],
            );
          } else {
            dialog = AlertDialog(
              title: Text("Confirm"),
              content: Text("Are you sure you wish to delete this transaction?"),
              actions: <Widget>[
                MaterialButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      "DELETE",
                      style: TextStyle(color: Colors.red),
                    )),
                MaterialButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("CANCEL"),
                ),
              ],
            );
          }

          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return dialog;
            },
          );
        },
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => serviceLocator<TaskBloc>(),
                  child: DetailsPage(taskEntity: taskEntity),
                ),
              ),
            );
          },
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  taskEntity.pantoneValue,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskEntity.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                    // Text(
                    //   DateFormat.yMMMd().format(_transaction.date),
                    //   style: TextStyle(
                    //     color: Colors.grey[600],
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
