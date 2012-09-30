package action;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

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
        this.grade      = grade;
        this.level      = level;
        this.category   = category;
        this.personalId = personalId;
    }

    public QuestionAction(int questionId) {
		this.questionId = questionId;
	}

	public ArrayList<Integer> getQuestionNumbers() {
        PersonalsDAO personalsDao = new PersonalsDAO();
        Connection personalsCon = personalsDao.getConection(PERSONALS_DB_NAME);
        ArrayList<Integer> notList = personalsDao.selectQuestionIds(personalsCon , personalId);
        personalsDao.closeConnection(personalsCon);

        QuestionsDAO questionsDao = new QuestionsDAO();
        Connection questionsCon = questionsDao.getConection(QUESTIONS_DB_NAME);
        ArrayList<Integer> idList = questionsDao.selectQuestionIds(questionsCon, grade, level, category, notList);
        questionsDao.closeConnection(questionsCon);

        return idList;
    }

	public HashMap<String,HashMap<String, HashMap<String, String>>> getQuestionById() {
		
        QuestionsDAO questionsDao = new QuestionsDAO();
        Connection questionsCon = questionsDao.getConection(QUESTIONS_DB_NAME);
        HashMap<String,HashMap<String, HashMap<String, String>>> qHashMap = questionsDao.selectQuestionById(questionsCon, questionId);
        questionsDao.closeConnection(questionsCon);

		return qHashMap;
	}
}
