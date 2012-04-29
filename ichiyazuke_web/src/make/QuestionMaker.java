package make;

import java.sql.Connection;
import java.util.ArrayList;

import dao.PersonalsDAO;
import dao.QuestionsDAO;

public class QuestionMaker {

    private final String PERSONALS_DB_NAME = "ichiyazuke_db";
    private final String QUESTIONS_DB_NAME = "ichiyazuke_db";

    private int grade;
    private int level;
    private int personalId;
    private String category;
    
    private int questionId;
    

    public QuestionMaker(int grade, int level, int personalId, String category) {
        this.grade = grade;
        this.level = level;
        this.personalId = personalId;
        this.category = category;
    }

    public QuestionMaker(int questionId) {
		this.questionId = questionId;
	}

	public ArrayList<Integer> getQuestionNumbers() {
        PersonalsDAO personalsDao = new PersonalsDAO();
        Connection personalsCon = personalsDao.getConection(PERSONALS_DB_NAME);
        ArrayList<Integer> notList = personalsDao.selectQuestionIds(personalsCon , personalId);
//    	ArrayList<Integer> notList = new ArrayList<Integer>();
//    	notList.add(new Integer(2));
        personalsDao.closeConnection(personalsCon);
//
        QuestionsDAO questionsDao = new QuestionsDAO();
        Connection questionsCon = questionsDao.getConection(QUESTIONS_DB_NAME);
        ArrayList<Integer> idList = questionsDao.selectQuestionIds(questionsCon, grade, level, notList, category);
        questionsDao.closeConnection(questionsCon);
    	
        return idList;
    }

	public ArrayList<String> getQuestionById() {
		
        QuestionsDAO questionsDao = new QuestionsDAO();
        Connection questionsCon = questionsDao.getConection(QUESTIONS_DB_NAME);
        ArrayList<String> qList = questionsDao.selectQuestionById(questionsCon, questionId);
        questionsDao.closeConnection(questionsCon);
		
		

		return qList;
	}
    
//    public ArrayList<String> getQestion() {
//
//
//    }
}
