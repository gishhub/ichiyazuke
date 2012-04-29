package controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.Out;

import make.QuestionMaker;

//import net.sf.json.JSONArray;

/**
 * Servlet implementation class ControllerServlet
 */
public class ControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGET(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
//		HttpSession session = request.getSession(false);
//		nextPage = IchiyazukeController.perform(request, response);

		response.setContentType("text/html; charset=Windows-31J");
        PrintWriter out = response.getWriter();

		
		
//		
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("application/json; charset=UTF-8");
//
        String requestStr = request.getServletPath();
        OutputStream os = response.getOutputStream();
//

        if ("tbl_questions_get9".equals(requestStr)) {
            try {
                int grade = Integer.parseInt(request.getParameter("grade"));
                int level = Integer.parseInt(request.getParameter("level"));
                int personalId = Integer.parseInt(request.getParameter("personal_id"));
                String category = request.getParameter("category");

                QuestionMaker questionMaker = new QuestionMaker(grade, level, personalId, category);
//                ArrayList<Integer> idList = questionMaker.getQuestionNumbers();

//                JSONArray jsonArray = JSONArray.fromObject(idList);
//                os.write(jsonArray.toString().getBytes("UTF-8"));

                out.println("<html>");
                out.println("<head>");
                out.println("<title>HelloWorld</title>");
                out.println("</head>");
                out.println("<body>");
//                out.println(idList);
                out.println("<h1>HelloWorld</h1>");
                out.println("</body>");
                out.println("</html>");
                out.close();
            
            
            } catch (NumberFormatException e) {
                e.printStackTrace();
//            } catch (IOException e) {
//                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
//
		
//		request.getRequestDispatcher(nextPage).forward(request, response);			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
