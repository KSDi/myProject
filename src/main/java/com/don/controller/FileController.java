package com.don.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.don.service.FileService;


@Controller
public class FileController {
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private ServletContext application;
	
	@RequestMapping(value="/fileupload", 
					method=RequestMethod.POST,
					produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, String> fileUpload(
			@RequestParam MultipartFile upload){
		
		String path = 
				application.getRealPath("/WEB-INF/upload/qna");
		
		String filename = 
				fileService.saveFile(path, upload);
		Map<String, String> map = new HashMap<>();
		map.put("url", "/upload/qna/"+filename);
		
		return map;
	}
	
	@RequestMapping(value="/filedelete", 
			method=RequestMethod.POST)
	@ResponseBody
	public String fileDelete(@RequestParam String src) {
		String path = 
				application.getRealPath("/WEB-INF/upload/qna");
		if( fileService.deleteFile(path , src)) {
			return "success";
		}else {
			return "fail";
		}
	}
}





