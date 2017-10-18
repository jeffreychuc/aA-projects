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

  def self.liked_questions_for_user_id(user_id)
    options =
    QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.id, questions.title, questions.body, questions.user_id
    FROM
      question_likes
    JOIN
      questions ON questions.id = question_likes.question_id
    WHERE
      question_likes.user_id = ?
    SQL
    options.map { |q_op| Question.new(q_op) }
  end

  def self.most_liked_questions(n)
    options =
    QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.id, questions.title, questions.body, questions.user_id
    FROM
      question_likes
    JOIN
      questions ON question_likes.question_id = questions.id
    GROUP BY
      question_likes.question_id
    ORDER BY
      COUNT(question_likes.user_id) DESC
    LIMIT ?
    SQL
    options.map {|q_op| Question.new(q_op)}
  end
end
