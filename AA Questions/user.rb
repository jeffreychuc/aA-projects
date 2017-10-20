require_relative 'QuestionsDatabase'
require_relative 'Question'
require_relative 'QuestionFollow'
require_relative 'Reply'

class User
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_name(fname, lname)
    options =
    QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      users.fname = ? and users.lname = ?
    SQL
    User.new(options.first)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    options =
    QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
      questions.id, COUNT(DISTINCT question_likes.id)
    FROM
      questions
    LEFT OUTER JOIN
      question_likes ON questions.id = question_likes.question_id
    SQL
  end

end
