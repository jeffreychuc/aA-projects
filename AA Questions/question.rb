require_relative 'QuestionsDatabase'
require_relative 'Reply'
require_relative 'QuestionFollow'
class Question
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    options =
    QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      questions.id = ?
    SQL
    Question.new(options.first)
  end

  def self.find_by_author_id(author_id)
    options =
    QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      questions.user_id = ?
    SQL
    Question.new(options.first)
  end

  def author
    @user_id
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end
end
