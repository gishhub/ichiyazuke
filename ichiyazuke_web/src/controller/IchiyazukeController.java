package controller;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.QuestionDAO;
import dm.ConnectionManager;
import dto.Question;

public class IchiyazukeController {

	private IchiyazukeController(){
		
	}

	public static String perform(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		
		// where to send question informatio.
		String nextPage = "/ichiyazuke/HelloWorld";
		
		// question id をキーにして、データを取得
		String questionIdString = request.getParameter("questionId");
		int questionId = Integer.parseInt(questionIdString);
		
		Connection con = null;
		
		try{
			con = ConnectionManager.getConnection();
			QuestionDAO dao = new QuestionDAO(con);
			Question question = dao.selectById(questionId);
			
		} catch(SQLException e){
			e.printStackTrace();
			request.setAttribute("error", "ERROR in DB");
			
		}

		return nextPage;
	}
}
