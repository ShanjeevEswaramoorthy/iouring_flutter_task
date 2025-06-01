import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iouring_flutter_task/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:iouring_flutter_task/features/watchlist/presentation/bloc/watchlist_event.dart';
import 'package:iouring_flutter_task/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:iouring_flutter_task/features/watchlist/presentation/views/search_screen.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, watchlistState) {
        if (watchlistState is WatchlistInitial) {
          context.read<WatchlistBloc>().add(LoadWatchlists());
        }
        if (watchlistState is WatchlistLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        }
        if (watchlistState is WatchlistLoaded) {
          return DefaultTabController(
            length: watchlistState.allGroups.length,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
                  'Watchlist',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                bottom: // TabBar
                    PreferredSize(
                  preferredSize: const Size.fromHeight(48),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      isScrollable: true,
                      labelColor: Colors.green[600],
                      unselectedLabelColor: Colors.black54,
                      indicatorColor: Colors.green[600],
                      indicatorWeight: 2,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      tabs:
                          watchlistState.allGroups
                              .map((group) => Tab(text: group.groupName))
                              .toList(),
                      onTap: (index) {
                        context.read<WatchlistBloc>().add(
                          SelectWatchlistGroup(index: index),
                        );
                      },
                    ),
                  ),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search bar
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SearchScreen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Search and Add Scrips',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Icon(Icons.grid_view, color: Colors.green[300]),
                            const SizedBox(width: 10),
                            Icon(Icons.tune, color: Colors.green[300]),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // TabBarView
                  Expanded(
                    child: TabBarView(
                      children:
                          watchlistState.allGroups.map((group) {
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              itemCount: group.symbols.length,
                              itemBuilder: (context, index) {
                                final symbol = group.symbols[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        symbol.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Text(
                                            'NSE 82 @ 193.71',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          const Text(
                                            '30 @ 193.74',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Spacer(),
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.arrow_drop_up,
                                                color: Colors.green,
                                              ),
                                              Text(
                                                '193.70',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      const Text(
                                        '+4.02 (2.11%)',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const Divider(height: 20),
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error Occurs ${watchlistState is WatchlistError ? watchlistState.message : ''}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<WatchlistBloc>().add(LoadWatchlists());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
