package action;

import java.sql.Connection;

import dao.PersonalsDAO;

public class PersonalAction {

	private final String PERSONALS_DB_NAME = "onenight";

	private int questionId;
	private int personalId;
	private int result;

	public PersonalAction(int personalId, int questionId, int result) {
		this.personalId = personalId;
		this.questionId = questionId;
		this.result = result;
	}

	public boolean updatePersonalData() {
		boolean updateResult;
		PersonalsDAO personalsDao = new PersonalsDAO();
		Connection personalsCon = personalsDao.getConection(PERSONALS_DB_NAME);
		updateResult = personalsDao.updateResultIds(personalsCon, personalId,
				questionId, result);
		personalsDao.closeConnection(personalsCon);

		return updateResult;
	}
}
