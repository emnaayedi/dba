import 'package:demo/forms/step_list.dart';
import 'package:demo/forms/details_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/database_helper.dart';
import '../dialogs/single_choice_dialog.dart';

class FailuresList extends StatefulWidget {
  final List<Map<String, dynamic>> data;

  FailuresList({required this.data});
  @override
  FailuresListState createState() => FailuresListState(failuresList: data);
}

class FailuresListState extends State<FailuresList> {
  List<Map<String, dynamic>> failuresList = [];
  List<String> sortOptions = [
    'By Oldest',
    'By Newest',
    'By DR number',
    'By Title'
  ];

  late DateTime startDate = DateTime(1900);
  late DateTime endDate = DateTime(2100);
  bool _isLoading = true;
  String filter = '';
  bool sortAscending = true;
  bool isFiltered = false;
  late Map<String, DateTime> filterResult;
  late Map<String, String> sortResult;
  late String sortOptionValue;

  late List<Map<String, dynamic>> filteredItems = [];

  FailuresListState({required this.failuresList});

  void _refreshData() async {
    final data = await DatabaseHelper.getRigs();
    setState(() {
      failuresList = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData(); // Loading the data when the app starts
  }

  Future<void> addRig() async {
    _refreshData();
  }

  Future<void> updateRig(int id) async {
    await DatabaseHelper.updateRig(id, '', '');
    _refreshData();
  }

  // Delete an Rig
  void deleteRig(int id) async {
    await DatabaseHelper.deleteRig(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully deleted!'), backgroundColor: Colors.green));
    _refreshData();
  }

  Future<void> showFilter(BuildContext context) async {
    filterResult = (await showDialog<Map<String, DateTime>>(
      context: context,
      builder: (BuildContext context) {
        return const FilterDialog();
      },
    ))!;

    startDate = filterResult['startDate']!;
    endDate = filterResult['endDate']!;

    filterItems(startDate, endDate);
  }

  Future<void> showSorter(BuildContext context) async {
    sortResult = (await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return SingleChoiceDialog(
          data: sortOptions,
          title: 'Sort',
        );
      },
    ))!;
    setState(() {
      sortOptionValue = sortResult['option']!;
    });
    sortItems(sortOptionValue);
  }

  void filterItems(DateTime startDate, DateTime endDate) {
    // Apply filter

    filteredItems = failuresList.where((item) {
      String dateString = item['failureDate'];
      DateTime itemDate = DateTime.parse(dateString);
      return itemDate.isAfter(startDate) &&
          itemDate.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
    setState(() {
      isFiltered = true;
    });
    // Sort items
  }

  void sortItems(String sortOption) {
    // Apply filter
    switch (sortOption) {
      case 'By Oldest':
        setState(() {
          filteredItems = List.from(failuresList);
          ascendingSortedFailures(filteredItems);
          filteredItems = filteredItems.reversed.toList();

          isFiltered = true;
        });
        // Perform specific actions for apple
        break;

      case 'By Newest':
        setState(() {
          filteredItems = List.from(failuresList);
          ascendingSortedFailures(filteredItems);
          isFiltered = true;
        });

        break;

      case 'By DR number':
        break;
      case 'By Title':
        filteredItems = List.from(failuresList);
        sortedFailuresByTitle(filteredItems);
        isFiltered = true;
        break;
      default:
        break;
    }

    // Sort items
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayedFailures =
        isFiltered ? filteredItems : failuresList;
    isFiltered = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Failure Report List'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          await showFilter(context);
                        },
                        icon: const Icon(Icons.filter_list),
                        label: const Text('Filter'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await showSorter(context);
                        },
                        icon: const Icon(Icons.sort),
                        label: const Text('Sort'),
                      ),
                    ],
                  ),

                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: TextField(
                  //     onChanged: (value) {
                  //       setState(() {
                  //         filter = value;
                  //       });
                  //     },
                  //     decoration: InputDecoration(
                  //       labelText: 'Filter',
                  //     ),
                  //   ),
                  // ),
                  // ListTile(
                  //   title: Text('Sort Ascending'),
                  //   trailing: Checkbox(
                  //     value: sortAscending,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         sortAscending = value ?? true;
                  //       });
                  //     },
                  //   ),
                  // ),

                  Expanded(
                    // If you don't have the height you can expanded with flex
                    flex: 1,
                    child: ListView.builder(
                      itemCount: displayedFailures.length,
                      itemBuilder: (context, index) => Card(
                          color:
                              index % 2 == 0 ? Colors.white10 : Colors.white60,
                          margin: const EdgeInsets.all(15),
                          child: ListTile(
                            title:
                                Text(displayedFailures[index]['failureTitle']),
                            subtitle:
                                Text(displayedFailures[index]['failureDate']),

                            onTap: () => setState(() {
                              Map<String, Map<String, String>> data = {
                                'basicInformation': {
                                  'failureTitle': displayedFailures[index]
                                      ['failureTitle'],
                                  'rigName': displayedFailures[index]
                                      ['rigName'],
                                  'preparedBy': '',
                                  'equipment': '',
                                  'failureType': '',
                                  'operator': '',
                                  'failureDate': displayedFailures[index]
                                      ['failureDate'],
                                  'bopSurface': '',
                                  'eventName': '',
                                  'pod': ''
                                },
                                'projectStatus': {
                                  'partDescription': '',
                                  'eventDescription': '',
                                  'indicationSymptoms': '',
                                  'impactedFunctions': '',
                                  'failureSeverity': ''
                                },
                                'failureComponentData': {
                                  'failedItemPartNo': '',
                                  'failedItemSerialNo': '',
                                  'originalInstallationDate': '',
                                  'cycleCountsUponFailure': '',
                                  'failureMode': '',
                                  'failureCause': '',
                                  'failureMechanism': '',
                                  'vendorOEM': '',
                                  'repairLocation': '',
                                  'discoveryMethod': '',
                                  'failureStatus': '',
                                  'dateOfRepair': ''
                                },
                                'correctiveActions': {
                                  'newItemPartNo': '',
                                  'newItemSerialNo': '',
                                  'RepairKitPartNo': '',
                                  'correctiveActionsSummary': ''
                                },
                                'attachments': {'attachments': ''}
                              };
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FailureDetailsPage(data: data)));
                            }),
                            trailing: PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) {
                                return [
                                  const PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ];
                              },
                              onSelected: (String value) {
                                // Handle item selection here
                                if (value == 'edit') {
                                  // Perform edit action
                                } else if (value == 'delete') {
                                  deleteRig(displayedFailures[index]['id']);
                                }
                              },
                            ),
                            // trailing: SizedBox(
                            //   width: 100,
                            //   child: Row(
                            //     children: [
                            //       IconButton(
                            //         icon: const Icon(Icons.edit),
                            //         onPressed: () =>
                            //             Navigator.push(
                            //                 context,
                            //                 MaterialPageRoute(
                            //                     builder: (context) => PreviewPage(
                            //                         data: {}))),
                            //       ),
                            //       IconButton(
                            //         icon: const Icon(Icons.delete),
                            //         onPressed: () =>
                            //             deleteRig(failuresList[index]['id']),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          )),
                    ),
                  ),
                ]),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const StepList())),
      ),
    );
  }

  void ascendingSortedFailures(List<Map<String, dynamic>> list) {
    list.sort((a, b) => b['failureDate'].compareTo(a['failureDate']));
  }

  void sortedFailuresByTitle(List<Map<String, dynamic>> list) {
    list.sort((a, b) => b['failureTitle'].compareTo(a['failureTitle']));
  }
}

class FilterDialog extends StatefulWidget {
  final Key? key;
  const FilterDialog({this.key}) : super(key: key);
  @override
  FilterDialogState createState() => FilterDialogState();
}

class FilterDialogState extends State<FilterDialog> {
  late DateTime startDate = DateTime(1900);
  late DateTime endDate = DateTime(2100);
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          startDate.isAfter(DateTime.now()) ? startDate : DateTime.now(),
      firstDate: startDate,
      lastDate: DateTime(2100),
      helpText: 'Select Failure Date', // Can be used as title
      cancelText: 'Cancel',
      confirmText: 'Save',
    );

    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate.isAfter(DateTime.now()) ? DateTime.now() : endDate,
      firstDate: DateTime(1900),
      lastDate: endDate,
      helpText: 'Select Start Date', // Can be used as title
      cancelText: 'Cancel',
      confirmText: 'Save',
    );

    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  void _resetFilter() {
    setState(() {
      startDate = DateTime(1900);
      endDate = DateTime(2100);
    });
  }

  void _cancelFilter() {
    Navigator.pop(context, null);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Filter'),
          ElevatedButton(
            onPressed: _resetFilter,
            child: const Text('Reset Filter'),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Divider(),
          Row(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    iconColor: MaterialStateProperty.all<Color>(
                        const Color(0xff020202)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xffFFFFFF)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(color: Color(0xff020202)),
                        // Set the desired border radius
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.all(10), // Set the desired padding
                    ),
                  ),
                  onPressed: () => _selectStartDate(context),
                  label: Text(
                    style: const TextStyle(color: Color(0xff020202)),
                    startDate != DateTime(1900)
                        ? ' ${DateFormat('yyyy-MM-dd').format(startDate)}'
                        : 'MM / DD / YYYY',
                  ),
                  icon: const Icon(Icons.date_range),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    iconColor: MaterialStateProperty.all<Color>(
                        const Color(0xff020202)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xffFFFFFF)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(color: Color(0xff020202)),
                        // Set the desired border radius
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.all(10), // Set the desired padding
                    ),
                  ),
                  onPressed: () => _selectEndDate(context),
                  label: Text(
                    style: const TextStyle(color: Color(0xff020202)),
                    endDate != DateTime(2100)
                        ? ' ${DateFormat('yyyy-MM-dd').format(endDate)}'
                        : 'MM / DD / YYYY',
                  ),
                  icon: const Icon(Icons.date_range),
                ),
              ),
            )
          ]),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: _cancelFilter,
                child: const Text('Cancel'),
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                      context, {'startDate': startDate, 'endDate': endDate});
                },
                child: const Text('Apply'),
              )),
            ],
          )
        ],
      ),
    );
  }
}
