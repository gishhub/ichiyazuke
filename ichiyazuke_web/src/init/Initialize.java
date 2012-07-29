package init;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import  util.ConfReader;

public class Initialize extends HttpServlet {

	private static final long serialVersionUID = -7235511085312831359L;

	public void init(){
		ServletContext application = getServletContext();
		ConfReader.getInstance().readConf(application.getRealPath("/WEB-INF/ichiyazuke.properties"));
	}
}
