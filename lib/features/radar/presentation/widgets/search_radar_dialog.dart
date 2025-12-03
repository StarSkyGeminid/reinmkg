import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/radar_entity.dart';
import '../cubit/radar_list/radar_list_cubit.dart';

class SearchRadarDialog extends StatefulWidget {
  const SearchRadarDialog({super.key});

  @override
  State<SearchRadarDialog> createState() => _SearchRadarDialogState();
}

class _SearchRadarDialogState extends State<SearchRadarDialog> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textField(context),
            _buildDivider(),
            _searchResult(context),
          ],
        ),
      ),
    );
  }

  Padding _textField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFFFFA500), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: searchController,
              autofocus: true,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              onChanged: (query) {
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: 'Cari lokasi...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return BlocBuilder<RadarListCubit, RadarListState>(
      builder: (context, state) {
        if (state is! RadarListLoaded) {
          return const SizedBox.shrink();
        }

        return const Divider(height: 1, color: Colors.grey);
      },
    );
  }

  AnimatedContainer _searchResult(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: BlocBuilder<RadarListCubit, RadarListState>(
        builder: (context, state) {
          switch (state) {
            case RadarListInitial():
            case RadarListLoading():
              return const Center(child: CircularProgressIndicator.adaptive());

            case RadarListLoaded():
              final allRadars = state.radars;
              final query = searchController.text.trim().toLowerCase();
              final filtered = query.isEmpty
                  ? allRadars
                  : allRadars
                        .where(
                          (r) => (r.city ?? '').toLowerCase().contains(query),
                        )
                        .toList();

              if (query.isNotEmpty && filtered.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      'Lokasi tidak ditemukan',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                );
              }

              return _buildSearchView(filtered);
            default:
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  state is RadarListFailure
                      ? state.message
                      : 'Gagal mendapatkan data radar',
                ),
              );
          }
        },
      ),
    );
  }

  ListView _buildSearchView(List<RadarEntity> radars) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: radars.length,
      itemBuilder: (context, index) {
        final radar = radars[index];
        return InkWell(
          onTap: () {
            Navigator.pop(context, radar);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFFFFA500),
                  size: 18,
                ),
                const SizedBox(width: 12),
                Text(
                  radar.city ?? '-',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
