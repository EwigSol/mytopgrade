enum APIPath {
  courses,
  courseCategory,
  lessons,
  review,
  finishCourse,
  submitReview,
  finishLesson,
  courseEnroll,
  retakeCourse,
  quiz,
  startQuiz,
  checkAnswers,
  finishQuiz,
  assignments,
  addFavorite,
  wishlist,
  assignmentById,
  login,
  register,

//

}

class APIPathHelper {
  static String getValue(APIPath path) {
    switch (path) {
      case APIPath.courses:
        return "/courses";

      case APIPath.courseCategory:
        return "/course_category";

      case APIPath.lessons:
        return "/lessons";

      case APIPath.review:
        return "/review/course/";

      case APIPath.finishCourse:
        return "/courses/finish";

      case APIPath.submitReview:
        return "/review/submit";

      case APIPath.finishLesson:
        return "/lessons/finish";

      case APIPath.courseEnroll:
        return "/courses/enroll";

      case APIPath.retakeCourse:
        return "/courses/retake";

      case APIPath.quiz:
        return "/quiz";

      case APIPath.startQuiz:
        return "/quiz/start";

      case APIPath.checkAnswers:
        return "/quiz/check_answer";

      case APIPath.finishQuiz:
        return "/quiz/finish";

      case APIPath.assignments:
        return "/assignments";

      case APIPath.addFavorite:
        return "/wishlist/toggle";

      case APIPath.wishlist:
        return "/wishlist";

      case APIPath.assignmentById:
        return "/assignments/";

      case APIPath.login:
        return "/token";

      case APIPath.register:
        return "/wc/v3/customers";

      default:
        return "";
    }
  }
}

//