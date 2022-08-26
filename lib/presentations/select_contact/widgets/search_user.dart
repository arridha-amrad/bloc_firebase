import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/select_contact_bloc.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectContactBloc, SelectContactState>(
      buildWhen: (previous, current) => previous.search != current.search,
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) =>
              context.read<SelectContactBloc>().add(SearchChanged(value)),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            hintText: "Search...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        );
      },
    );
  }
}
