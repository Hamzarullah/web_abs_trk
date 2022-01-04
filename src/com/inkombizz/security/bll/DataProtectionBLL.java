
package com.inkombizz.security.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.security.dao.DataProtectionDAO;
import com.inkombizz.security.model.DataProtection;
import com.inkombizz.security.model.DataProtectionTemp;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;


public class DataProtectionBLL {
    public static final String MODULECODE="007_SYS_DATA_PROTECTION";
    
    private DataProtectionDAO dataProtectionDAO;
    
    public DataProtectionBLL(HBMSession hbmSession){
        this.dataProtectionDAO=new DataProtectionDAO(hbmSession);
    }
    
    public ListPaging<DataProtectionTemp> findData(Paging paging,String code) throws Exception{
        try{
            DetachedCriteria criteria=DetachedCriteria.forClass(DataProtection.class);
            paging.setRecords(dataProtectionDAO.countData(code));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            criteria=paging.addOrderCriteria(criteria);
            
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<DataProtectionTemp> listDataProtectionTemp=dataProtectionDAO.findData(code,paging.getFromRow(), paging.getToRow());
            ListPaging<DataProtectionTemp> listPaging=new ListPaging<DataProtectionTemp>();
            
            listPaging.setList(listDataProtectionTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public boolean isExist(BigDecimal monthPeriod,BigDecimal yearPeriod,Date salesOrderTransactionDate) throws Exception{
        try{
            boolean exist = false;

            if(dataProtectionDAO.countDataIsExist(monthPeriod,yearPeriod, salesOrderTransactionDate) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(BigDecimal monthPeriod, BigDecimal yearPeriod) throws Exception {
        try {
            dataProtectionDAO.save(monthPeriod, yearPeriod, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(BigDecimal monthPeriod, BigDecimal yearPeriod) throws Exception{
        dataProtectionDAO.delete(monthPeriod,yearPeriod, MODULECODE);
    }
    
    
    
}
