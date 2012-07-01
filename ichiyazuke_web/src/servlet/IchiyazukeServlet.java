package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.arnx.jsonic.JSON;

//import net.sf.json.JSONArray;

import make.QuestionMaker;
import make.UpdateInfomation;

/**
 * Servlet implementation class IchiyazukeServlet
 */
public class IchiyazukeServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2319188394791324751L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("application/json; charset=UTF-8");

		String requestStr = request.getPathInfo();

		response.setContentType("text/html; charset=Windows-31J");
		PrintWriter out = response.getWriter();

		if ("/select_question_id".equals(requestStr)) {
			
			try {
				int grade = Integer.parseInt(request.getParameter("grade"));
				int level = Integer.parseInt(request.getParameter("level"));
				int personalId = Integer.parseInt(request
						.getParameter("personalId"));

				String category = request.getParameter("category");
				
				QuestionMaker questionMaker = new QuestionMaker(grade, level,
						personalId, category);
				
				ArrayList<Integer> idList = questionMaker.getQuestionNumbers();
				String tmp = JSON.encode(idList);
				out.println(tmp);
				
				idList.remove(0);
			} catch (Exception e) {
				e.printStackTrace();
				out.println("false");
			}
		} else if ("/select_question_by_id".equals(requestStr)) {
			try {
				int questionId = Integer.parseInt(request.getParameter("questionId"));
				QuestionMaker questionMaker = new QuestionMaker(questionId);
				HashMap<String,String> questionHashMap = questionMaker.getQuestionById();

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
				
				UpdateInfomation resultUpdater = new UpdateInfomation(personalId, questionId);
				out.println(resultUpdater.resultUpdate());
			} catch (NumberFormatException e) {
				e.printStackTrace();
				out.println("false");
			}
		} else {
			out.println("NotHelloWorld!");
			out.println("false");
		}
		out.close();
	}
}
