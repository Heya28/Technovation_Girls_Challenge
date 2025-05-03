
// --- screens/community_screen.dart ---
// UI for the community forum/discussion board.

import 'package:flutter/material.dart';

// Simple model for a discussion post
class DiscussionPost {
  final String id;
  final String title;
  final String author; // Could be User object later
  final String initialMessage;
  final List<String> tags;
  final int replyCount;
  final DateTime timestamp;

  DiscussionPost({
    required this.id,
    required this.title,
    required this.author,
    required this.initialMessage,
    required this.tags,
    required this.replyCount,
    required this.timestamp,
  });
}

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  // --- Placeholder Data ---
  final List<DiscussionPost> _posts = [
    DiscussionPost(id: '1', title: 'Vibe check', author: 'User123', initialMessage: 'How is everyone feeling today?', tags: ['General', 'Check-in'], replyCount: 1, timestamp: DateTime.now().subtract(const Duration(hours: 2))),
    DiscussionPost(id: '2', title: 'Help for my son', author: 'WorriedParent', initialMessage: 'My son is struggling with textures, any advice for introducing new foods?', tags: ['Parents', 'Advice', 'Textures'], replyCount: 3, timestamp: DateTime.now().subtract(const Duration(hours: 5))),
    DiscussionPost(id: '3', title: 'Tried a new food!', author: 'RecoveryWarrior', initialMessage: 'I tried a bite of cooked carrot today! It was scary but I did it.', tags: ['RecoveryWins', 'Firsts', 'Milestone'], replyCount: 5, timestamp: DateTime.now().subtract(const Duration(days: 1))),
    DiscussionPost(id: '4', title: 'Dealing with anxiety at mealtimes', author: 'AnxiousEater', initialMessage: 'Mealtimes are so stressful. How do others cope?', tags: ['Anxiety', 'Coping'], replyCount: 8, timestamp: DateTime.now().subtract(const Duration(days: 2))),
  ];

  final List<String> _filterTags = ['All', 'Parents', 'RecoveryWins', 'Advice', 'Firsts', 'Anxiety'];
  String _selectedFilter = 'All'; // Currently selected filter tag

  // Filtered list based on the selected tag
  List<DiscussionPost> get _filteredPosts {
      if (_selectedFilter == 'All') {
          return _posts;
      }
      return _posts.where((post) => post.tags.contains(_selectedFilter)).toList();
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Filter Chips
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: SizedBox( // Constrain height of the filter bar
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _filterTags.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final tag = _filterTags[index];
                final bool isSelected = tag == _selectedFilter;
                return ChoiceChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedFilter = tag;
                      });
                    }
                  },
                  selectedColor: theme.colorScheme.primary.withOpacity(0.8),
                  labelStyle: TextStyle(
                      color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.primary),
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                  shape: StadiumBorder(side: BorderSide(color: theme.colorScheme.primary.withOpacity(0.3))), // Rounded shape
                );
              },
            ),
          ),
        ),

        // Discussion List
        Expanded(
          child: _filteredPosts.isEmpty
          ? Center(
              child: Text(
                'No discussions found for filter "$_selectedFilter".',
                 style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                 textAlign: TextAlign.center,
              )
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 80.0), // Padding to avoid overlap with FAB
              itemCount: _filteredPosts.length,
              itemBuilder: (context, index) {
                final post = _filteredPosts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                  child: ListTile(
                     leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.secondary.withOpacity(0.8),
                         child: Text(
                          post.author.substring(0,1).toUpperCase(), // Initial
                           style: TextStyle(color: theme.colorScheme.onSecondary, fontWeight: FontWeight.bold),
                        )
                     ),
                    title: Text(post.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      'By ${post.author} - ${post.replyCount} ${_pluralize(post.replyCount, 'reply', 'replies')}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
                    onTap: () {
                      // TODO: Navigate to discussion detail screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Navigate to details for "${post.title}" (not implemented).')),
                      );
                    },
                  ),
                );
              },
            ),
        ),

         // Floating Action Button to start new discussion
         // Note: This FAB is part of the CommunityScreen's Scaffold content,
         // but visually appears over the list. The main Scaffold in HomeScreen
         // doesn't have a FAB to avoid conflicts between tabs.
         Padding(
           padding: const EdgeInsets.all(16.0),
           child: Align(
             alignment: Alignment.bottomRight,
             child: FloatingActionButton.extended(
                onPressed: () {
                   // TODO: Implement navigation/modal for creating a new discussion
                   ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Start new discussion (not implemented).')),
                   );
                },
                label: const Text('New Discussion'),
                icon: const Icon(Icons.add_comment_outlined),
                backgroundColor: theme.colorScheme.secondary,
                foregroundColor: theme.colorScheme.onSecondary,
             ),
           ),
         ),
      ],
    );
  }

  // Helper function for pluralization
  String _pluralize(int count, String singular, String plural) {
    return count == 1 ? singular : plural;
  }
}