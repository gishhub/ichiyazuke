package servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.arnx.jsonic.JSON;
import net.arnx.jsonic.JSONException;
import net.sf.json.JSONArray;

//import net.sf.json.JSONArray;

import make.QuestionMaker;

/**
 * Servlet implementation class IchiyazukeServlet
 */
public class IchiyazukeServlet extends HttpServlet {

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

		out.println("<html>");
		out.println("<head>");
		out.println("<title>HelloWorld</title>");
		out.println("</head>");
		out.println("<body>");
		out.println("<h1>" + requestStr + "</h1>");

		if ("/select_question_id".equals(requestStr)) {
			
			try {
				out.println("<h1>HelloWorld</h1>");
				int grade = Integer.parseInt(request.getParameter("grade"));
				int level = Integer.parseInt(request.getParameter("level"));
				int personalId = Integer.parseInt(request
						.getParameter("personalId"));
				String category = request.getParameter("category");
				out.println("<h1>grade:" + grade + "</h1>");
				out.println("<h1>level:" + level + "</h1>");
				out.println("<h1>personalId:" + personalId + "</h1>");
				out.println("<h1>category:" + category + "</h1>");
				QuestionMaker questionMaker = new QuestionMaker(grade, level,
						personalId, category);
				ArrayList<Integer> idList = questionMaker.getQuestionNumbers();
				String tmp = JSON.encode(idList);
				out.println(tmp);
				//			for (Object obj : idList) {
				//				if (obj instanceof String) { // Stringå^ÇÃèÍçá
				//					out.println((String) obj);
				//				} else if (obj instanceof Integer) { // Integerå^ÇÃèÍçá
				//					out.println(((Integer) obj).intValue());
				//				}
				//			}
				out.println("</body>");
				out.println("</html>");
				idList.remove(0);
				out.close();
			} catch (Exception e) {
				// TODO: handle exception
				out.println("<h1>1430</h1>");
				out.println("</body>");
				out.println("</html>");
			}
			
		} else if ("/select_question_by_id".equals(requestStr)) {
			try {
				out.println("<h1>NeverHelloWorld</h1>");
				int questionId = Integer.parseInt(request.getParameter("questionId"));
				QuestionMaker questionMaker = new QuestionMaker(questionId);
				ArrayList<String> questionList = questionMaker.getQuestionById();

				String tmp = JSON.encode(questionList);
				out.println(tmp);
				
//			
//			for (Object obj : questionList) {
//				if (obj instanceof String) { // Stringå^ÇÃèÍçá
//					out.println((String) obj);
//				} else if (obj instanceof Integer) { // Integerå^ÇÃèÍçá
//					out.println(((Integer) obj).intValue());
//				}
//			}a
				questionList.remove(0);
				out.println("</body>");
				out.println("</html>");
				out.close();
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				out.println("<h1>1430</h1>");
				out.println("</body>");
				out.println("</html>");

//				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				out.println("<h1>1430</h1>");
				out.println("</body>");
				out.println("</html>");
//
//				e.printStackTrace();
			} catch (Exception e) {
				// TODO: handle exception
				out.println("<h1>1430</h1>");
				out.println("</body>");
				out.println("</html>");
			}
		} else {
			out.println("<h1>NotHelloWorld</h1>");
			out.close();
		}
	}

}
