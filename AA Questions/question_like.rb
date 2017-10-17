require_relative 'QuestionsDatabase'
require_relative 'User'
require_relative 'Question'

class QuestionLike
  def initialize
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.likers_for_question_id(question_id)
    options =
    QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.id, users.fname, users.lname
    FROM
      question_likes
    JOIN
      users ON question_likes.user_id = users.id
    WHERE
      question_likes.question_id = ?
    SQL
    options.map { |user_option| User.new(user_option) }
  end

  def self.num_likes_for_question_id(question_id)
    options =
    QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      COUNT(*) as num
    FROM
      question_likes
    WHERE
      question_likes.question_id = ?
    SQL
    options.first['num']
  end
end
