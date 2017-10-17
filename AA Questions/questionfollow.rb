require_relative 'QuestionsDatabase'
require_relative 'User'
require_relative 'Question'
class QuestionFollow
  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.followers_for_question_id(question_id)
    options =
    QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.id, users.fname, users.lname
    FROM
      question_follows
    JOIN
      users ON users.id = question_follows.user_id
    WHERE
      question_follows.question_id = ?
    SQL
    options.map {|user_option| User.new(user_option)}
  end

  def self.followed_questions_for_user_id(user_id)
    options =
    QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      questions.id, questions.title, questions.body, questions.user_id
    FROM
      question_follows
    JOIN
      questions ON questions.id = question_follows.question_id
    WHERE
      question_follows.user_id = ?
    SQL
    options.map {|q_op| Question.new(q_op)}
  end

  def self.most_followed_questions(n)
    options =
    QuestionsDatabase.instance.execute(<<-SQL, n)
    SELECT
      questions.id, questions.title, questions.body, questions.user_id
    FROM
      question_follows
    JOIN
      questions ON question_follows.question_id = questions.id
    GROUP BY
      question_follows.question_id
    ORDER BY
      COUNT(question_follows.user_id) DESC
    LIMIT ?
    SQL
    options.map {|q_op| Question.new(q_op)}
  end
end
