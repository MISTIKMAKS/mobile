import 'package:flutter/material.dart';

class Lab4 extends StatefulWidget {
  const Lab4({super.key});

  @override
  State<Lab4> createState() => _Lab4State();
}

class Vacancy {
  final String name;
  final bool gender;
  final int salary;

  Vacancy({required this.name, required this.gender, required this.salary});
}

class _Lab4State extends State<Lab4> {
  final List<Vacancy> _vacancies = [];
  late TextEditingController _searchController;
  List<Vacancy> _filteredVacancies = [];
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _vacancies.addAll([
      Vacancy(name: 'Software Engineer', gender: true, salary: 100000),
      Vacancy(name: 'Data Scientist', gender: false, salary: 120000),
      Vacancy(name: 'Product Manager', gender: true, salary: 150000),
      Vacancy(name: 'UI/UX Designer', gender: false, salary: 90000),
      Vacancy(name: 'Backend Developer', gender: true, salary: 110000),
      Vacancy(name: 'Frontend Developer', gender: false, salary: 105000),
      Vacancy(name: 'Marketing Specialist', gender: true, salary: 95000),
      Vacancy(name: 'HR Manager', gender: false, salary: 130000),
      Vacancy(name: 'Accountant', gender: true, salary: 85000),
      Vacancy(name: 'Customer Support', gender: false, salary: 80000),
    ]);
    _filteredVacancies.addAll(_vacancies);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterVacancies(String query) {
    setState(() {
      _filteredVacancies = _vacancies
          .where((vacancy) =>
              vacancy.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _filterVacanciesByGender(int gender) {
    setState(() {
      if (gender == 2) {
        _filteredVacancies = _vacancies.toList();
      } else {
        bool filter = gender == 0 ? false : true;
        _filteredVacancies =
            _vacancies.where((vacancy) => vacancy.gender == filter).toList();
      }
    });
  }

  void _sortVacancies(int sort) {
    setState(() {
      if (sort == 2) {
        _filteredVacancies = _vacancies.toList();
      } else {
        _filteredVacancies.sort((a, b) {
          if (sort == 0) {
            return a.name
                .compareTo(b.name); // Sort alphabetically in ascending order
          } else {
            return b.name
                .compareTo(a.name); // Sort alphabetically in descending order
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Lab 4'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterVacancies,
              decoration: const InputDecoration(
                hintText: 'Search by Vacancy name',
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _searchController.clear();
              _filterVacancies('');
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _filteredVacancies.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_filteredVacancies[index].name),
            onDismissed: (direction) {
              setState(() {
                _vacancies.removeWhere((vacancy) =>
                    vacancy.name == _filteredVacancies[index].name);
                _filteredVacancies.removeAt(index);
              });
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20.0),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: ListTile(
              title: Text(_filteredVacancies[index].name),
              subtitle: Text(
                  'Gender: ${_filteredVacancies[index].gender ? 'Female' : 'Male'}, Salary: ${_filteredVacancies[index].salary} USD'),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddDialog(
                      key: UniqueKey(),
                      onVacancyAdded: (Vacancy vacancy) {
                        setState(() {
                          _vacancies.add(vacancy);
                          _filteredVacancies.add(vacancy);
                        });
                      },
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FilterDialog(
                      key: UniqueKey(),
                      onVacancyFilter: (int filter) {
                        _filterVacanciesByGender(filter);
                      },
                    );
                  },
                );
              },
              child: const Icon(Icons.filter_alt),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SortDialog(
                      key: UniqueKey(),
                      onVacancySort: (int sort) {
                        _sortVacancies(sort);
                      },
                    );
                  },
                );
              },
              child: const Icon(Icons.sort_by_alpha),
            ),
          ),
        ],
      ),
    );
  }
}

class SortDialog extends StatefulWidget {
  final void Function(int) onVacancySort;

  const SortDialog({required this.onVacancySort, super.key});

  @override
  State<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  int sort = 2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sort by alphabet'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text('Order:'),
              const SizedBox(width: 10),
              Row(
                children: [
                  Radio<int>(
                    value: 0,
                    groupValue: sort,
                    onChanged: (value) {
                      setState(() {
                        sort = value!;
                      });
                    },
                  ),
                  const Text('ASC '),
                ],
              ),
              Row(
                children: [
                  Radio<int>(
                    value: 1,
                    groupValue: sort,
                    onChanged: (value) {
                      setState(() {
                        sort = value!;
                      });
                    },
                  ),
                  const Text('DESC'),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            widget.onVacancySort(sort);

            Navigator.of(context).pop();
          },
          child: const Text('Sort'),
        ),
      ],
    );
  }
}

class FilterDialog extends StatefulWidget {
  final void Function(int) onVacancyFilter;

  const FilterDialog({required this.onVacancyFilter, super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  int gender = 2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter by gender'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text('Gender:'),
              const SizedBox(width: 10),
              Row(
                children: [
                  Radio<int>(
                    value: 0,
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  const Text('Male'),
                ],
              ),
              Row(
                children: [
                  Radio<int>(
                    value: 1,
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            widget.onVacancyFilter(gender);

            Navigator.of(context).pop();
          },
          child: const Text('Filter'),
        ),
      ],
    );
  }
}

class AddDialog extends StatefulWidget {
  final void Function(Vacancy) onVacancyAdded;

  const AddDialog({required this.onVacancyAdded, super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  String name = '';
  bool gender = false;
  int salary = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Vacancy'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) {
              name = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter vacancy name',
            ),
          ),
          Row(
            children: [
              const Text('Gender:'),
              const SizedBox(width: 10),
              Row(
                children: [
                  Radio<bool>(
                    value: false,
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  const Text('Male'),
                ],
              ),
              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  const Text('Female'),
                ],
              ),
            ],
          ),
          TextField(
            onChanged: (value) {
              salary = int.tryParse(value) ?? 0;
            },
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter salary',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (name.isNotEmpty && salary > 0) {
              widget.onVacancyAdded(
                  Vacancy(name: name, gender: gender, salary: salary));
            }
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
