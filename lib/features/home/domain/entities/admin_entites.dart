class AdminEntities {
  final int totalRevenue;
  final Map<String, CourseState> course;

  AdminEntities({required this.totalRevenue, required this.course});
}

class CourseState {
  final String name;
  final int purchase;
  final int revenue;

  CourseState(
      {required this.name, required this.purchase, required this.revenue});
}
