package make;

import java.sql.Connection;

import dao.PersonalsDAO;

public class UpdateInfomation {

    private final String PERSONALS_DB_NAME = "onenight";

    private int questionId;
    private int personalId;

	public UpdateInfomation(int personalId, int questionId) {
		this.personalId = personalId;
		this.questionId = questionId;
		
	}

	public boolean resultUpdate() {
		boolean updateResult;
        PersonalsDAO personalsDao = new PersonalsDAO();
        Connection personalsCon = personalsDao.getConection(PERSONALS_DB_NAME);
        updateResult = personalsDao.updteResultIds(personalsCon , personalId, questionId);
        personalsDao.closeConnection(personalsCon);

        return updateResult;
    }
}
