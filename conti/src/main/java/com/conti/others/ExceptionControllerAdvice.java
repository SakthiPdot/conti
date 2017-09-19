package com.conti.others;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Project_Name conti
 * @Package_Name com.conti.others  com.conti.others
 * @File_name ExceptionControllerAdvice.java com.conti.others
 * @author Monu.C
 * @Created_date_time Sep 12, 2017 11:48:21 AM
 */

@ControllerAdvice
public class ExceptionControllerAdvice {

	
	@ExceptionHandler(Exception.class)
	public ModelAndView exception(Exception e,HttpServletRequest request){
	
		ModelAndView model=new ModelAndView("exception");
		
		model.addObject("name",e.getClass().getName());
		model.addObject("message",e.getMessage());
		model.addObject("homePage",request.getContextPath());
		
		return model;
	}

	
}
