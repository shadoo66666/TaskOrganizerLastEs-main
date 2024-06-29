import 'package:flutter/material.dart';

class EditProjectViewBody extends StatelessWidget {
  const EditProjectViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey, // Set background color to grey
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tasks Details',
            style: TextStyle(color: Color.fromARGB(255, 175, 97, 180)),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Create a task title with date and time
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Web Development',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 223, 171, 235),
                ),
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Icon(
                    color: Color.fromARGB(255, 69, 12, 79),
                    Icons.date_range,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '28 March, at 11:30 am',
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Create a progress bar with label
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'In Progress',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '65%',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(
                value: 0.65,
                color: Color.fromARGB(255, 51, 16, 61),
                backgroundColor: Color.fromARGB(255, 237, 182, 244),
              ),
            ),
            const SizedBox(height: 16),
            // Create an overview section with read more option
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 252, 252),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'The project will incorporate several popular web development technologies. Much of the time, the tools and programming languages taught in a classroom setting are learned and practice in isolation from one another....',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                onPressed: () {
                  // Add your logic to expand the overview section
                },
                child: const Text(
                  'Read More',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 210, 125, 227),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Members',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Create a members section with circular avatars and a plus icon
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/tyler-nix-7ukf-r-Oh-k-unsplash.jpg'),
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/photo.png'),
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/istockphoto-483731108-612x612.jpg'),
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/istockphoto-1082922466-612x612.jpg'),
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/istockphoto-1188431958-612x612.jpg'),
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/istockphoto-1271072224-612x612.jpg'),
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/istockphoto-1492750197-612x612.jpg'),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.add),
                        // Add your logic to add more members
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tasks',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Create a tasks section with icons, titles, and checkmarks
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 239, 234, 244),
                      ),
                      padding: const EdgeInsets.all(2),
                      height: 60,
                      child: const Row(
                        children: [
                          Icon(Icons.play_arrow),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Introduction',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Jay Dhameliya',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.check,
                            color: Color.fromARGB(255, 235, 88, 208),
                            size: 36.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 239, 228, 240),
                      ),
                      padding: const EdgeInsets.all(2),
                      height: 60,
                      child: const Row(
                        children: [
                          Icon(Icons.description),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Project Description',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Kinjal Lathiya',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.check,
                            color: Color.fromARGB(255, 85, 56, 96),
                            size: 36.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
