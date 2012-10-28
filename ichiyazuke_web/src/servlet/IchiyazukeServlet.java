package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import action.QuestionAction;
import action.PersonalAction;
import action.UserAction;

import net.arnx.jsonic.JSON;

/**
 * Servlet implementation class IchiyazukeServlet
 */
public class IchiyazukeServlet extends HttpServlet {
	
	//Loggerを作成する。
	// static protected Logger logger = Logger.getLogger(IchiyazukeServlet.class);

	
	private static final long serialVersionUID = 2319188394791324751L;

	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("application/json; charset=UTF-8");

		String requestStr = request.getPathInfo();

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		/*
		logger.debug("It's debug log");
		logger.info("It's info log");
		logger.warn("It's warn log");
		logger.error("It's error log");
		logger.fatal("It's fatal log");
		*/

		if ("/select_question_id".equals(requestStr)) {
			try {
				int grade      = Integer.parseInt(request.getParameter("grade"));
				int category   = Integer.parseInt(request.getParameter("category"));
				int level      = Integer.parseInt(request.getParameter("level"));
				int personalId = Integer.parseInt(request.getParameter("personalId"));

				QuestionAction questionAction = new QuestionAction(grade, level, category, personalId);

				ArrayList<Integer> idList = questionAction.getQuestionNumbers();

		        if (idList.size() < 9){
		        	throw new Exception();
		        }

		        String tmp = JSON.encode(idList);
				out.println(tmp);
		        idList.remove(0);

			} catch (IndexOutOfBoundsException e){
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
				out.println("false");
			}
		} else if ("/select_question_by_id".equals(requestStr)) {
			try {
				int questionId = Integer.parseInt(request.getParameter("questionId"));
				QuestionAction questionAction = new QuestionAction(questionId);
				HashMap<String,HashMap<String, HashMap<String, String>>> questionHashMap = questionAction.getQuestionById();

				String tmp = JSON.encode(questionHashMap);
				out.println(tmp);

				questionHashMap.remove(0);
			} catch (Exception e){
				e.printStackTrace();
				out.println("false");
			}
		} else if ("/update_infomation".equals(requestStr)) {
			try {
				int personalId = Integer.parseInt(request.getParameter("personalId"));
				int questionId = Integer.parseInt(request.getParameter("questionId"));
				int result     = Integer.parseInt(request.getParameter("result"));

				PersonalAction personalAction = new PersonalAction(personalId, questionId,result);
				out.println(personalAction.updatePersonalData());
			} catch (NumberFormatException e) {
				e.printStackTrace();
				out.println("false");
			}
		} else if ("/login".equals(requestStr)) {
			try {
				String username = request.getParameter("username");
				String passward = request.getParameter("passward");

				UserAction userAction = new UserAction(username, passward);
				out.println(userAction.login());
			} catch (NumberFormatException e) {
				e.printStackTrace();
				out.println("false");
			}
		} else if ("/signup".equals(requestStr)) {
			try {
				String username = request.getParameter("username");
				String passward = request.getParameter("passward");

				UserAction userAction = new UserAction(username, passward);
				out.println(userAction.signUp());
			} catch (NumberFormatException e) {
				e.printStackTrace();
				out.println("false");
			}
		} else {
			out.println("false");
		}
		out.close();
	}
}
