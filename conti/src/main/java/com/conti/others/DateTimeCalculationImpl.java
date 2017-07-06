package com.conti.others;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Service;

/**
 * @Project_Name conti
 * @Package_Name com.conti.others
 * @File_name DateTimeCalculationImpl.java
 * @author Sankar
 * @Created_date_time Jul 6, 2017 1:33:00 PM
 * @Updated_date_time Jul 6, 2017 1:33:00 PM
 */
@Service("datetimeCalculation")
public class DateTimeCalculationImpl implements DateTimeCalculation {

	/* (non-Javadoc)
	 * @see com.conti.others.DateTimeCalculation#calculateDateDiff(java.lang.String)
	 */
	@Override
	public String[] calculateDateDiff(String requestDate) throws ParseException {
		// TODO Auto-generated method stub
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date d1=new Date();		
		Date d2=(Date)dateFormat.parse(requestDate);
		//in milliSeconds
		long diffInDate = d1.getTime()-d2.getTime();
		//in Days
		String days=String.valueOf(diffInDate/(24*60*60*1000));
		String hour=String.valueOf(diffInDate/(60*60*1000));
		String minute=String.valueOf(diffInDate/(60*1000));
		String seconds=String.valueOf(diffInDate/(1000));
		
		String[] datetime_differ = {days, hour, minute, seconds}; 
		
		return datetime_differ;
	}


}
