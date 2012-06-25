package init;

import javax.servlet.http.HttpServlet;
import  util.ConfReader;

public class Initialize extends HttpServlet {

	public void init(){
		ConfReader.getInstance().readConf("/Users/NaraTakahito/Documents/workspace_servlet/ichiyazuke_web/ichiyazuke_web/src/init/ichiyazuke.properties");
//		ConfReader.getInstance().readConf("/tmp/ichiyazuke.properties");

	}
}
