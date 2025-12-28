import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_buddy/common/common_app_bar.dart';
import 'package:study_buddy/common/bottom_navigation.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String selectedCategory = 'All';
  final List<String> categories = ['All', 'Physics', 'Chemistry', 'Math'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CommonAppBar(
          title: 'Library',
          showBackButton: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category buttons
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: const Color(0xFF7e37f1),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF6b7280),
                        fontFamily: 'Lexend',
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Course cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildCourseCard(
                    'Physics 101',
                    'Intro to Classical Mechanics',
                    70,
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuALc6XsTKaeYeJJapkxnuo28cbWaX81GLE6kl2trc9CFN6tzThEEaqeD7icmp4ZQCnT-PdnWaDrapSiKs_Qe3TjTR8Qftjdkm-5OY6XVG8ECltCiACQET3RMIw0MQHaMS9c5GBGH6mfHgabG1Hsx7r3HCrecmf3jQqLPPXCcZqmxOkDM7Vygm5t0LBGLWvBB_f_rSioXnPPiXQ1nZj2Zqs3L8J06wh2BMRrh5or5e0hoD3fg6Kxnf71THTvWVhQkaDjckKTFAUkX5g',
                    onTap: () {
                      context.push('/lecture-detail');
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildCourseCard(
                    'Chemistry 201',
                    'Organic Chemistry Basics',
                    45,
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBYS_74ioIxz4FjS57OjriQy3BvJ30ZbrZhhwsSHqONCMoW6JK3J9RA1DokAkxENTatYaifMrJHfD5kvNgSiSMVYncdP4-wiEcwUWa2Xb0F3PiiKCUCwS3Oexg3CyZb1IracJPnTzkINQOBCYYTYoTFgTEOpxkmEmbjxmoBEPt5DGCPpRIOqdm_gTYZ8EWe6a0Kbcvi2hYeW6Qr10fFF9H-vMT3a2nTJ-Z_9ragoD-hvJnDR1Ek7nQLRWSrPYaWohfH5R26omm0aN4',
                    onTap: () {
                      context.push('/lecture-detail');
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildCourseCard(
                    'Math 301',
                    'Calculus & Advanced Topics',
                    25,
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBIGivnaCpnr96UocDzEf8cQmZ0nH_BFhsk_QwpK7uTtUkwohBJsW0GpB57CMJhoIWcbkNSQMdIDuSJbs_SFS0oqvfuxPwsYtAPdKX6z1GT0_1xOxFpexYOncEsqTWt0ltnbthtqTTZOVm7UEYcmyW91A34c18nFSRxUQhc5Bp9NMvZ9aFrQ2lB8R-au502A5zfl4Vo74J_8xsGR67kfFTDgF_sYeRYrBTzHki6KuTrlWGO_1ZeweJRSVvLBHIuL_4vyxdCeDNzRcg',
                    isNew: true,
                    onTap: () {
                      context.push('/lecture-detail');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }

  Widget _buildCourseCard(
    String title,
    String subtitle,
    int progress,
    String imageUrl, {
    bool isNew = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF7e37f1).withOpacity(0.1),
                          child: const Icon(Icons.image_not_supported),
                        );
                      },
                    ),
                    if (isNew)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'New',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lexend',
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF130e1b),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF6b7280),
                        fontSize: 14,
                        fontFamily: 'Lexend',
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress / 100,
                        minHeight: 6,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF7e37f1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$progress% completed',
                      style: const TextStyle(
                        color: Color(0xFF6b7280),
                        fontSize: 12,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
