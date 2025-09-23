import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';
import '../loader/loading_animation.dart';

class StudentDashboard extends ConsumerWidget {
  const StudentDashboard({super.key});



  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final user=ref.watch(userProvider);
    final profilePic=user?.profilePic;
    final isLoading = ref.watch(authControllerProvider);


  
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body:isLoading?const refreshLoader(): SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.arrow_back_ios, color: Colors.grey),
                  const Text(
                    "My Dashboard",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  IconButton(onPressed:() {

                    ref.read(authControllerProvider.notifier)
                        .refreshUserData(context);



                  } , icon: const Icon(Icons.refresh)),
                ],
              ),
              const SizedBox(height: 16),

              // Profile Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 64,
                          backgroundImage:profilePic!=null?NetworkImage(profilePic): const NetworkImage(
                            "https://lh3.googleusercontent.com/aida-public/AB6AXuDJSUt0u44i4R-xMDHgfh07zDbRwyMiQIzJMa91-PlMhXTL1jH9soiqzD0oUeXjo3sXLuDH7tZYA9WwFYlXx9CFwyyKQBOU-_CBwI_cRZaPiL4lbO3hiJW50btccoTABUzjWZZQDwIJLI7XoLLHTa3Et5cSnKSwSAqq-jXC-L5A8GF90Xeiid1usHF-JpI_gkiDs-plFFtN7FZC68H81WlGDt3LBS-7CfligQSRiyhL23ttYa4AfJrr3IEsfchyIeU73CQOzleSvKnW",
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 12,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(user!.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                     Text(
                      user.rollNo,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.email, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(user.email,
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.school, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text("${user.year.toString()}th year",
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // CGPA Progress
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  user.cgpa.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF374151),
                                  ),
                                ),
                                Text(
                                  (user.cgpa / 10).toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                value: 0.85,
                                minHeight: 8,
                                color: Colors.blue,
                                backgroundColor: Colors.grey[300],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Fee Status
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Fee Status",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [
                  _feeCard(
                    icon: Icons.directions_bus,
                    iconColor: Colors.blue,
                    title: "Bus Fees",
                    amount: user.busFees.toString(),
                    amountColor: Colors.red,
                    status: "Overdue",
                  ),
                  _feeCard(
                    icon: Icons.hotel,
                    iconColor: Colors.green,
                    title: "Hostel Fees",
                    amount: "₹2,992",
                    amountColor: Colors.black,
                    status: "Paid",
                  ),


                ],
              ),

              const SizedBox(height: 20),

              _feeCards(
                icon: Icons.account_balance,
                iconColor: Colors.purple,
                title: "Tuition Fees",
                amount: user.tuitionFees.toString(),
                amountColor: Colors.black,
                status: "Due: 25th Oct",
              ),

              // Quick Actions

            ],
          ),
        ),
      ),


    );
  }

  // Fee Card
  static Widget _feeCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String amount,
    required Color amountColor,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [

          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: amountColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(status, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }


  static Widget _feeCards({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String amount,
    required Color amountColor,
    required String status,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: amountColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(status, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }


}
