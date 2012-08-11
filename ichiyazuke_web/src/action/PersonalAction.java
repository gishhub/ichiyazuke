package action;

import java.sql.Connection;

import dao.PersonalsDAO;

public class PersonalAction {

    private final String PERSONALS_DB_NAME = "onenight";

    private int questionId;
    private int personalId;

	public PersonalAction(int personalId, int questionId) {
		this.personalId = personalId;
		this.questionId = questionId;
	}

	public boolean updatePersonalData() {
		boolean updateResult;
        PersonalsDAO personalsDao = new PersonalsDAO();
        Connection personalsCon = personalsDao.getConection(PERSONALS_DB_NAME);
        updateResult = personalsDao.updateResultIds(personalsCon , personalId, questionId);
        personalsDao.closeConnection(personalsCon);

        return updateResult;
    }
}
