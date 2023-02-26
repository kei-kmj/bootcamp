# frozen_string_literal: true

Rails.configuration.to_prepare do
  Newspaper.subscribe(:event_create, EventOrganizerWatcher.new)
  Newspaper.subscribe(:answer_create, AnswerNotifier.new)
  Newspaper.subscribe(:answer_create, NotifierToWatchingUser.new)
  Newspaper.subscribe(:announcement_destroy, AnnouncementNotificationDestroyer.new)
  Newspaper.subscribe(:answer_create, AnswererWatcher.new)

  announcement_notifier = AnnouncementNotifier.new
  Newspaper.subscribe(:announcement_create, announcement_notifier)
  Newspaper.subscribe(:announcement_update, announcement_notifier)

  sad_streak_updater = SadStreakUpdater.new
  Newspaper.subscribe(:report_create, sad_streak_updater)
  Newspaper.subscribe(:report_update, sad_streak_updater)
  Newspaper.subscribe(:report_destroy, sad_streak_updater)

  learning_cache_destroyer = LearningCacheDestroyer.new
  Newspaper.subscribe(:learning_create, learning_cache_destroyer)
  Newspaper.subscribe(:learning_destroy, learning_cache_destroyer)

  answer_cache_destroyer = AnswerCacheDestroyer.new
  Newspaper.subscribe(:answer_save, answer_cache_destroyer)
  Newspaper.subscribe(:answer_destroy, answer_cache_destroyer)
  Newspaper.subscribe(:correct_answer_save, CorrectAnswerNotifier.new)

  Newspaper.subscribe(:user_create, SignUpNotifier.new)
  Newspaper.subscribe(:regular_event_update, RegularEventUpdateNotifier.new)

  Newspaper.subscribe(:graduation_update, GraduationNotifier.new)

  Newspaper.subscribe(:comeback_update, ComebackNotifier.new)

  Newspaper.subscribe(:check_create, ProductStatusUpdater.new)
  Newspaper.subscribe(:product_create, ProductAuthorWatcher.new)

  page_notifier = PageNotifier.new
  Newspaper.subscribe(:page_create, page_notifier)
  Newspaper.subscribe(:page_update, page_notifier)

<<<<<<< HEAD
  product_notifier = ProductNotifier.new
  Newspaper.subscribe(:product_create, product_notifier)
  Newspaper.subscribe(:product_update, product_notifier)

  Newspaper.subscribe(:question_create, CreatingMentorsWatchForQuestion.new)
=======
  creating_mentors_watch_for_question = CreatingMentorsWatchForQuestion.new
  Newspaper.subscribe(:question_create, creating_mentors_watch_for_question)
  Newspaper.subscribe(:question_update, creating_mentors_watch_for_question)
>>>>>>> 7792e7778 (createとupdateでnewspaperの呼び出しを分けた)
end
