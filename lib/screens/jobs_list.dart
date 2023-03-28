import 'package:careergy_mobile/constants.dart';
import 'package:careergy_mobile/models/job.dart';
import 'package:careergy_mobile/providers/post_provider.dart';
import 'package:flutter/material.dart';

class JobsList extends StatefulWidget {
  final Job job;
  final Function refresh;
  JobsList({required this.job, required this.refresh});

  @override
  State<JobsList> createState() => _JobsListState();
}

class _JobsListState extends State<JobsList> {
  @override
  bool isHovering = false;
  int MAX_CHARS = 80;
  bool isLoading = false;
  bool deleteIsLoading = false;
  bool deleteIsHovering = false;

  Future<void> _deleteConfirm(String? id) async {
    bool isLoading = false;
    if (id == null) {
      return;
    }
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Warning!'),
        content: const Text('Confirm Delete?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red)),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await Post().deletePost(id);
              setState(() {
                isLoading = false;
                Navigator.of(ctx).pop();
              });
              widget.refresh();
            },
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: kBlue,
            ),
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.centerLeft,
        height: 100,
        width: 200,
        child: TextButton(
          onPressed: () {
            print("clicked..");
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  "${widget.job.dt!.toLocal()}".substring(0, 11) +
                      "\n${widget.job.dt!.toLocal().hour}:${widget.job.dt!.toLocal().minute}:${widget.job.dt!.toLocal().second}",
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(
                width: 100,
                child: Text(
                  widget.job.jobTitle,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  widget.job.yearsOfExperience,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  widget.job.major,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  widget.job.city != '' ? widget.job.city : "not specified",
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    widget.job.descreption.length > MAX_CHARS
                        ? widget.job.descreption.substring(0, 80) +
                            " ..show more"
                        : widget.job.descreption,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: widget.job.isActive
                              ? (isHovering
                                  ? Colors.green.shade400
                                  : Colors.green)
                              : (isHovering ? Colors.red : Colors.red.shade300),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : widget.job.isActive
                                ? const Text(
                                    "Deactivate",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : const Text(
                                    "Activate",
                                    style: TextStyle(color: Colors.white),
                                  ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await Post().toggleStatus(widget.job.id);
                          setState(() {
                            isLoading = false;
                            widget.job.isActive = !widget.job.isActive;
                          });
                        },
                        onHover: (value) {
                          setState(() {
                            isHovering = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        child: deleteIsLoading
                            ? const CircularProgressIndicator()
                            : const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                        onPressed: () async {
                          await _deleteConfirm(widget.job.id);
                        },
                        onHover: (value) {
                          setState(() {
                            deleteIsHovering = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
