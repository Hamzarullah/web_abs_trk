

package com.inkombizz.master.dao;


import com.inkombizz.action.BaseSession;
import java.util.List;
import java.util.Date;
import org.hibernate.HibernateException;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.model.ExchangeRate;
import com.inkombizz.master.model.ExchangeRateTemp;
import java.text.SimpleDateFormat;
import org.hibernate.Hibernate;
import org.hibernate.transform.Transformers;

public class ExchangeRateDAO {
    
    private HBMSession hbmSession;
    
    
    public ExchangeRateDAO(HBMSession session) {
        this.hbmSession = session;
    }
    
  
        
    
    public List<ExchangeRateTemp> findByCriteria(String curCode,Date StartDate,Date EndDate) {
        try {
            
            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
                
            String dateFirst = DATE_FORMAT.format(StartDate);
            String dateLast = DATE_FORMAT.format(EndDate);
            
            List<ExchangeRateTemp> list = (List<ExchangeRateTemp>)hbmSession.hSession.createSQLQuery(
                "SELECT mst_exchange_rate_bi.Transactiondate, "
                + "mst_exchange_rate_bi.ExchangeRate "
                + "FROM mst_exchange_rate_bi "
                + "INNER JOIN mst_currency mst_currency ON mst_exchange_rate_bi.CurrencyCode=mst_currency.Code "
                + "WHERE mst_exchange_rate_bi.CurrencyCode='" + curCode +"' "
                + "AND mst_exchange_rate_bi.Transactiondate BETWEEN '"+dateFirst+"' AND '"+dateLast+"'")
                 
                    .addScalar("transactionDate", Hibernate.DATE)
                    .addScalar("exchangeRate", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(ExchangeRateTemp.class))
                .list(); 
                 
                return list;
        }   
        catch (HibernateException e) {
            throw e;
        }
    }
    
    
        
    public List<ExchangeRate> getExchange(ExchangeRate exchangeRate){
        SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");        
        String transactionDate = DATE_FORMAT.format(exchangeRate.getTransactionDate());
        
        List<ExchangeRate> listExchangeRate = (List<ExchangeRate>)hbmSession.hSession.createSQLQuery(
                "SELECT mst_exchange_rate_bi.code, "
                + "mst_exchange_rate_bi.CurrencyCode, "
                + "mst_exchange_rate_bi.Transactiondate, "
                + "mst_exchange_rate_bi.ExchangeRate, "
                + "mst_exchange_rate_bi.createdBy, "
                + "mst_exchange_rate_bi.createdDate, "
                + "mst_exchange_rate_bi.ExchangeRate "
                + "FROM mst_exchange_rate_bi "
                + "WHERE mst_exchange_rate_bi.CurrencyCode='" + exchangeRate.getCurrency().getCode() +"' "
                + "AND TransactionDate='"+transactionDate+"'")
                 
                    .addScalar("exchangeRate", Hibernate.STRING)
                    .addScalar("createdBy", Hibernate.STRING)
                    .addScalar("createdDate", Hibernate.DATE)
                    .setResultTransformer(Transformers.aliasToBean(ExchangeRate.class))
                .list(); 
        return listExchangeRate;
    }
    
    
        
    public ExchangeRateTemp getExchangeByDate(String currCode,Date exchangeDate){
        SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");        
        String transactionDate = DATE_FORMAT.format(exchangeDate);
        
        ExchangeRateTemp exchangeRateTemp = (ExchangeRateTemp)hbmSession.hSession.createSQLQuery(
                "SELECT  "
                + "mst_exchange_rate_bi.exchangeRate "
                + "FROM mst_exchange_rate_bi "
                + "WHERE mst_exchange_rate_bi.CurrencyCode='" +currCode+"' "
                + "AND TransactionDate='"+transactionDate+"'")
                 
                    .addScalar("exchangeRate", Hibernate.STRING)
                    .setResultTransformer(Transformers.aliasToBean(ExchangeRateTemp.class))
                    .uniqueResult();
        
        return exchangeRateTemp;
    }
    
    
    public void save_update(List<ExchangeRate> list, String moduleCode) throws Exception {
        try {
            hbmSession.hSession.beginTransaction();
            for(ExchangeRate exchangeRateBi:list){
                List<ExchangeRate> lstexchangeRateBi=getExchange(exchangeRateBi);  
                if(lstexchangeRateBi.isEmpty()){
                    exchangeRateBi.setCreatedBy(BaseSession.loadProgramSession().getUserName());
                    exchangeRateBi.setCreatedDate(new Date()); 
                    exchangeRateBi.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                    exchangeRateBi.setUpdatedDate(new Date());
                    hbmSession.hSession.save(exchangeRateBi);
                    
//                    TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
//                    transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
//                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
//                                                                    feeReceiver.getCode(), ""));
                }
                else{
                    exchangeRateBi.setCreatedBy(lstexchangeRateBi.get(0).getCreatedBy());
                    exchangeRateBi.setCreatedDate(lstexchangeRateBi.get(0).getCreatedDate());
                    exchangeRateBi.setUpdatedBy(BaseSession.loadProgramSession().getUserName());
                    exchangeRateBi.setUpdatedDate(new Date()); 
                    hbmSession.hSession.update(exchangeRateBi);
                    
//                    TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
//                    transactionLogDAO.save(TransactionLogCommon.newInstance(moduleCode, 
//                                                                    EnumTransactionAction.toString(ENUM_TransactionAction.UPDATE), 
//                                                                    feeReceiver.getCode(), ""));
                }
                 
            }

            hbmSession.hTransaction.commit();
        }
        catch (HibernateException e) {
            e.printStackTrace();
            hbmSession.hTransaction.rollback();
            throw e;
        }
    }
    

    
}