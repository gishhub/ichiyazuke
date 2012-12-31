package action;

import java.sql.Connection;
import java.util.ArrayList;

import bean.Answer;
import bean.Question;

import dao.PersonalsDAO;
import dao.QuestionsDAO;

public class QuestionAction {
	private final String PERSONALS_DB_NAME = "onenight";
	private final String QUESTIONS_DB_NAME = "onenight";

	private int grade;
	private int level;
	private int category;
	private int personalId;
	private int questionId;

	public QuestionAction(int grade, int level, int category, int personalId) {
		this.grade = grade;
		this.level = level;
		this.category = category;
		this.personalId = personalId;
	}

	public QuestionAction(int questionId) {
		this.questionId = questionId;
	}

	public ArrayList<Question> getQuestionIds() {
		PersonalsDAO personalsDao = new PersonalsDAO();
		Connection personalsCon = personalsDao.getConection(PERSONALS_DB_NAME);
		ArrayList<Integer> notList = personalsDao.selectQuestionIds(personalsCon, personalId);
		personalsDao.closeConnection(personalsCon);

		QuestionsDAO questionsDao = new QuestionsDAO();
		Connection questionsCon = questionsDao.getConection(QUESTIONS_DB_NAME);
		ArrayList<Question> questions = questionsDao.selectQuestionIds(questionsCon, grade, level, category, notList);
		questionsDao.closeConnection(questionsCon);

		return questions;
	}

	public Question getQuestionById() {
		QuestionsDAO questionsDao = new QuestionsDAO();
		Connection questionsCon = questionsDao.getConection(QUESTIONS_DB_NAME);
		Question question = questionsDao.selectQuestionById(questionsCon, questionId);
		questionsDao.closeConnection(questionsCon);

		return question;
	}

	public Answer getAnswerById(int answer) {
		QuestionsDAO questionsDao = new QuestionsDAO();
		Connection questionsCon = questionsDao.getConection(QUESTIONS_DB_NAME);
		Question question = questionsDao.selectQuestionById(questionsCon, questionId);
		Answer answerBean = new Answer();

		answerBean.setCorrectAnswer(question.getAnswer());
		answerBean.setTitle(question.getTitle());
		answerBean.setContents(question.getContents());
		answerBean.setExplanation(question.getExplanation());
		switch (Integer.parseInt(question.getAnswer())) {
		case 1:
			answerBean.setCorrectChoice(question.getChoice1());
			break;
		case 2:
			answerBean.setCorrectChoice(question.getChoice2());
			break;
		case 3:
			answerBean.setCorrectChoice(question.getChoice3());
			break;
		case 4:
			answerBean.setCorrectChoice(question.getChoice4());
			break;
		default:
			break;
		}
		String judgment = "不正解";

		if (answer == Integer.parseInt(answerBean.getCorrectAnswer())) {
			judgment = "正解";
		}
		answerBean.setJudgement(judgment);
		questionsDao.closeConnection(questionsCon);

		return answerBean;
	}
}
