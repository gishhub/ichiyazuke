package init;

import javax.servlet.http.HttpServlet;
import  util.ConfReader;

public class Initialize extends HttpServlet {

	public void init(){
		// TODO: ichiyazuke.properties�t�@�C���̒u��������߂�B�Ƃ肠�����A��΃p�X�Ŏw�肵�Ƃ��B
		ConfReader.getInstance().readConf("/Users/NaraTakahito/Documents/workspace_servlet/ichiyazuke_web/ichiyazuke_web/src/init/ichiyazuke.properties");
//		ConfReader.getInstance().readConf("/tmp/ichiyazuke.properties");

	}
}
