class FaqController < ApplicationController
  def show

    @question1 = Faq.new
    @question1.question_text = "What is Waffle Iron"
    @question1.answer_text = "Waffle Iron is an awesome tool that is going to change your life.  It is your one stop shop to organize all your tasks.  You'll also be able to track comments that you and others make."
    @question1.slug = "what-is-gcamp"

    @question2 = Faq.new
    @question2.question_text = "How do I join Waffle Iron?"
    @question2.answer_text = "Signing up is free. Tell all of your friends."
    @question2.slug = "how-do-i-join-gcamp"

    @question3 = Faq.new
    @question3.question_text = "How do I add comments?"
    @question3.answer_text  = "Comments can only be made on tasks. You need to generate a task before adding a comment."
    @question3.slug = "when-will-gcamp-be-finished"

    @faqs = [@question1, @question2, @question3]

  end
end
