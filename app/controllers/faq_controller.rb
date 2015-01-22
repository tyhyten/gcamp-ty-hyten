class FaqController < ApplicationController
  def show
    @questions = Faq.new
    @questions.question_text = ["What is gCamp?","How do I join gCamp?","When will gCamp be finished?"]
    @questions.slug = ["#what-is-gcamp","#how-do-i-join-gcamp","#when-will-gcamp-be-finished"]
    @answers = Faq.new
    @answers.answer_text = ["gCamp is an awesome tool that is going to change your life.  gCamp is your one stop shop to organize all your tasks.  You'll also be able to track comments that you and others make.  gCamp may eventually replace all need for paper and pens in the entire world.  Well, maybe not, but it's going to be pretty cool.",
      "As soon as it's ready for the public, you'll see a signup link in the upper right. Once that's there, just click it and fill in the form!",
       "gCamp is a work in progress.  That being said, it should be fully functional in the next few weeks.  Functional.  Check in daily for new features and awesome functionality.  It's going to blow your mind.  Organization is just a click away.  Amazing!"
       ]
  end
end
