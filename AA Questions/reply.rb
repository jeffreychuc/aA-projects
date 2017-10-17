require_relative 'QuestionsDatabase'
require_relative 'Question'

class Reply
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @body = options['body']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    options =
    QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.id = ?
    SQL
    Reply.new(options.first)
  end

  def self.find_by_question_id(question_id)
    options =
    QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.question_id = ?
    SQL
    Reply.new(options.first)
  end

  def author
    @user_id
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    self.find_by_id(@parent_id)
  end

  def child_replies
    options =
    QuestionsDatabase.instance.execute(<<-SQL, @id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.parent_id = ?
    SQL
    Reply.new(options.first)
  end
end
