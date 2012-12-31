package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import bean.Answer;
import bean.Question;


import action.QuestionAction;
import action.PersonalAction;
import action.UserAction;

import net.arnx.jsonic.JSON;

public class IchiyazukeServlet extends HttpServlet {
	private static final long serialVersionUID = 2319188394791324751L;
	Logger log = Logger.getLogger(IchiyazukeServlet.class.getName());

	protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("application/json; charset=UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		String requestStr = request.getPathInfo();

		if ("/select_question_id".equals(requestStr)) {
			log.info("request : " + request.getRequestURL());

			try {
				int grade      = Integer.parseInt(request.getParameter("grade"));
				int category   = Integer.parseInt(request.getParameter("category"));
				int level      = Integer.parseInt(request.getParameter("level"));
				int personalId = Integer.parseInt(request.getParameter("personalId"));

				log.info("grade=" + grade);
				log.info("category=" + category);
				log.info("level=" + level);
				log.info("personalId=" + personalId);

				QuestionAction questionAction = new QuestionAction(grade, level, category, personalId);
				ArrayList<Question> questions = questionAction.getQuestionIds();

				String jsonData = JSON.encode(questions);
				out.println(jsonData);
				questions.remove(0);

			} catch (IndexOutOfBoundsException e){
				log.error("select_question_id: " + "",e);
				out.println("false");
			} catch (Exception e) {
				log.error("select_question_id: " + "",e);
				out.println("false");
			}
			log.info("response: " + request.getRequestURL());

		} else if ("/select_question_by_id".equals(requestStr)) {
			log.info("request : " + request.getRequestURL());
			try {
				int questionId = Integer.parseInt(request.getParameter("questionId"));
				log.info("questionId=" + questionId);

				QuestionAction questionAction = new QuestionAction(questionId);
				Question question = questionAction.getQuestionById();

				request.setAttribute("questionId", questionId);
				request.setAttribute("title",      question.getTitle());
				request.setAttribute("choice1",    question.getChoice1());
				request.setAttribute("choice2",    question.getChoice2());
				request.setAttribute("choice3",    question.getChoice3());
				request.setAttribute("choice4",    question.getChoice4());
				request.setAttribute("contents",   question.getContents());

				RequestDispatcher rd = request.getRequestDispatcher("/question");
				rd.forward(request, response);
			} catch (Exception e){
				log.error("select_question_by_id: " + "",e);
				out.println("false");
			}
			log.info("response: " + request.getRequestURL());

		}else if ("/answer_question".equals(requestStr)) {
			log.info("request : " + request.getRequestURL());
			try {
				int questionId = Integer.parseInt(request.getParameter("questionId"));
				int answer     = Integer.parseInt(request.getParameter("answer"));

				log.info("questionId=" + questionId);
				log.info("answer=" + answer);

				QuestionAction questionAction = new QuestionAction(questionId);
				Answer answerBean = questionAction.getAnswerById(answer);

				request.setAttribute("questionId",    questionId);
				request.setAttribute("title",         answerBean.getTitle());
				request.setAttribute("contents",      answerBean.getContents());
				request.setAttribute("choice",        answerBean.getCorrectChoice());
				request.setAttribute("correctAnswer", answerBean.getCorrectAnswer());
				request.setAttribute("judgment",      answerBean.getJudgement());
				request.setAttribute("explanation",   answerBean.getExplanation());

				RequestDispatcher rd = request.getRequestDispatcher("/answer");
				rd.forward(request, response);

			} catch (IndexOutOfBoundsException e){
				log.error("answer_question: " + "",e);
				out.println("false");
			} catch (Exception e) {
				log.error("answer_question: " + "",e);
				out.println("false");
			}
			log.info("response: " + request.getRequestURL());

		} else if ("/update_infomation".equals(requestStr)) {
			log.info("request : " + request.getRequestURL());

			try {
				int personalId = Integer.parseInt(request.getParameter("personalId"));
				int questionId = Integer.parseInt(request.getParameter("questionId"));
				int result     = Integer.parseInt(request.getParameter("result"));

				log.info("personalId=" + personalId);
				log.info("questionId=" + questionId);
				log.info("result=" + result);

				PersonalAction personalAction = new PersonalAction(personalId, questionId,result);
				out.println(personalAction.updatePersonalData());
			} catch (NumberFormatException e) {
				log.error("update_infomation: " + "",e);
				out.println("false");
			}
			log.info("response: " + request.getRequestURL());

		} else if ("/login".equals(requestStr)) {
			log.info("request : " + request.getRequestURL());
			try {
				String username = request.getParameter("username");
				String passward = request.getParameter("passward");

				log.info("username=" + username);
				log.info("passward=" + passward);

				UserAction userAction = new UserAction(username, passward);
				out.println(userAction.login());
			} catch (NumberFormatException e) {
				log.error("login: " + "",e);
				out.println("false");
			}
			log.info("response: " + request.getRequestURL());

		} else if ("/signup".equals(requestStr)) {
			log.info("request : " + request.getRequestURL());
			try {
				String username = request.getParameter("username");
				String passward = request.getParameter("passward");

				log.info("username=" + username);
				log.info("passward=" + passward);

				UserAction userAction = new UserAction(username, passward);
				out.println(userAction.signUp());
			} catch (NumberFormatException e) {
				log.error("signup: " + "",e);
				out.println("false");
			}
			log.info("response: " + request.getRequestURL());
		} else {
			log.error("予期せぬリクエストurl: " + request.getRequestURL());
			out.println("false");
		}
		out.close();
	}
}
