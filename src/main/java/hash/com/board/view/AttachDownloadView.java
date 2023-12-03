package hash.com.board.view;

import java.io.File;
import java.io.FileInputStream;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

@SuppressWarnings("unchecked")
public class AttachDownloadView extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, Object> fileMap = (Map<String, Object>) model.get("fileInfo");
		
		String filePath = (String)fileMap.get("bbsAttachLoc");
		String fileOriginName = new String(((String)fileMap.get("bbsAttachOriginNm")).getBytes("UTF-8"), "ISO-8859-1");
//		System.out.println("fileOriginName = "+fileOriginName);
		File file = new File(filePath);
		
		response.setContentType("application/octet-stream; charset=UTF-8");
		response.setHeader("Content-Disposition", "attachment; filename=" + fileOriginName + ";");
		
		FileInputStream fis = new FileInputStream(filePath);
		ServletOutputStream sos = response.getOutputStream();
		
		byte[] buffer = new byte[(int)file.length()];
		while(fis.read(buffer) != -1) {
			sos.write(buffer);
		}
		fis.close();
		sos.flush();
		sos.close();
	}

}
