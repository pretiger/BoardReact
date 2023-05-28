package com.board.exam.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {

	private static final Logger logger=LoggerFactory.getLogger(UploadFileUtils.class);
	
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
		UUID uuid=UUID.randomUUID();
		String savedName=uuid.toString()+"_"+originalName;
		String savedPath=calcPath(uploadPath);
		File target=new File(uploadPath+savedPath, savedName);
		FileCopyUtils.copy(fileData, target);
		String fileExtention=originalName.substring(originalName.lastIndexOf(".")+1);
		String uploadedFileName=null;
		if(MediaUtils.getMediaType(fileExtention) != null) {
			uploadedFileName=makeThumnail(uploadPath, savedPath, savedName);
		} else {
			uploadedFileName=makeFileName(uploadPath, savedPath, savedName);
		}
		return uploadedFileName;
	}
	
	private static String makeFileName(String uploadPath, String savedPath, String savedName) {
		String uploadedFileName=uploadPath+savedPath+File.separator+savedName;
		return uploadedFileName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	private static String makeThumnail(String uploadPath, String savedPath, String savedName) throws Exception {
		BufferedImage sourceImage=ImageIO.read(new File(uploadPath+savedPath, savedName));
		BufferedImage thumnailImage=Scalr.resize(sourceImage, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		String thumnailName=uploadPath+savedPath+File.separator+"s_"+savedName;
		File thumnailFile=new File(thumnailName);
		String fileExtention=savedName.substring(savedName.lastIndexOf(".")+1);
		ImageIO.write(thumnailImage, fileExtention.toUpperCase(), thumnailFile);
		return thumnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	private static String calcPath(String uploadPath) {
		Calendar calendar=Calendar.getInstance();
		String yearPath=File.separator+calendar.get(Calendar.YEAR);
		String monthPath=yearPath+File.separator+new DecimalFormat("00").format(calendar.get(Calendar.MONTH)+1);
		String datePath=monthPath+File.separator+new DecimalFormat("00").format(calendar.get(Calendar.DATE));
		makeDirectory(uploadPath, yearPath, monthPath, datePath);
		return datePath;
	}
	
	private static void makeDirectory(String uploadPath, String...paths) {
		if(new File(uploadPath+paths[paths.length - 1]).exists()) {
			return;
		}
		for(String path : paths) {
			File directoryPath=new File(uploadPath+path);
			if(!directoryPath.exists()) {
				directoryPath.mkdir();
			}
		}
	}
}
