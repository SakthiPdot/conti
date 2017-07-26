package com.conti.settings.price;

import java.util.List;

/**
 * @Project_Name conti
 * @Package_Name com.conti.settings.price  com.conti.settings.price
 * @File_name PriceSettingDetailDao.java com.conti.settings.price
 * @author Monu.C
 * @Created_date_time Jul 26, 2017 12:28:23 PM
 */
public interface PriceSettingDetailDao {

	public List<PriceSettingDetail> getPriceSettingDetailBypsId(int priceSettingId);
}
