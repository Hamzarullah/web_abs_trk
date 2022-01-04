

package com.inkombizz.master.bll;

import java.util.List;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.ExchangeRateDAO;
import com.inkombizz.master.model.ExchangeRate;
import com.inkombizz.master.model.ExchangeRateTemp;
import java.util.Date;

public class ExchangeRateBLL {
    
       
    public static final String MODULECODE = "006_MST_EXCHANGE_RATE";
    
    private ExchangeRateDAO exchangeRateDAO;
    
    public ExchangeRateBLL(HBMSession hbmSession) {
        this.exchangeRateDAO = new ExchangeRateDAO(hbmSession);
    }

   
    public List<ExchangeRateTemp> listExchangeRateToConfirm(String curCode,Date startDate,Date EndDate) throws Exception {
        try {
           
            List<ExchangeRateTemp> listExchangeRateTemp = exchangeRateDAO.findByCriteria(curCode, startDate, EndDate);
            
            
            return listExchangeRateTemp;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
   
    public void save_update(List<ExchangeRate> list, String moduleCode) throws Exception{
        exchangeRateDAO.save_update(list, moduleCode);
    }
   
    public List<ExchangeRate> getExchange(ExchangeRate exchangeRate) throws Exception {
        try {
            List<ExchangeRate> list=exchangeRateDAO.getExchange(exchangeRate);
            return list;
        }
        catch (Exception e) {
            throw e;
        }
    }
   
    public ExchangeRateTemp getExchangeByDate(String currCode,Date exchangeDate) throws Exception {
        try {
           return (ExchangeRateTemp)  exchangeRateDAO.getExchangeByDate(currCode,exchangeDate);
           
        }
        catch (Exception e) {
            throw e;
        }
    }
}