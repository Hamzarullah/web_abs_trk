package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ChartOfAccountDAO;
import com.inkombizz.master.model.ChartOfAccount;
import com.inkombizz.master.model.ChartOfAccountField;
import com.inkombizz.master.model.ChartOfAccountTemp;


public class ChartOfAccountBLL {
    
    public static final String MODULECODE = "006_MST_CHART_OF_ACCOUNT";
    
    private ChartOfAccountDAO chartOfAccountDAO;

    public ChartOfAccountBLL(HBMSession hbmSession) {
        this.chartOfAccountDAO = new ChartOfAccountDAO(hbmSession);
    }
    
    public ListPaging<ChartOfAccountTemp> findData(String code, String name, String type,String active,Paging paging) throws Exception {
        try {
            paging.setRecords(chartOfAccountDAO.countData(code,name,type,active));

            // Calculate total Pages
            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<ChartOfAccountTemp> listChartOfAccountTemp = chartOfAccountDAO.findData(code, name,type,active, paging.getFromRow(), paging.getToRow());

            ListPaging<ChartOfAccountTemp> listPaging = new ListPaging<ChartOfAccountTemp>();

            listPaging.setList(listChartOfAccountTemp);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ChartOfAccountTemp findData(String code) throws Exception {
        try {
            return (ChartOfAccountTemp) chartOfAccountDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ChartOfAccountTemp findData(String code,String type,boolean active) throws Exception {
        try {
            return (ChartOfAccountTemp) chartOfAccountDAO.findData(code,type,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(ChartOfAccount chartOfAccount) throws Exception {
        try {
            chartOfAccountDAO.save(chartOfAccount, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public void update(ChartOfAccount chartOfAccount) throws Exception {
        try {
            chartOfAccountDAO.update(chartOfAccount, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            chartOfAccountDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }	
    
    
    public boolean isExist(String code) throws Exception{
        try{            
            boolean exist = false;

            DetachedCriteria criteria = DetachedCriteria.forClass(ChartOfAccount.class)
                            .add(Restrictions.eq(ChartOfAccountField.CODE, code));

            if(chartOfAccountDAO.countByCriteria(criteria) > 0)
                 exist = true;

            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
        
    
    public ChartOfAccountTemp min() throws Exception {
        try {
            return chartOfAccountDAO.min();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ChartOfAccountTemp max() throws Exception {
        try {
            return chartOfAccountDAO.max();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ChartOfAccountTemp minSub() throws Exception {
        try {
            return chartOfAccountDAO.minSub();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ChartOfAccountTemp maxSub() throws Exception {
        try {
            return chartOfAccountDAO.maxSub();
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ListPaging<ChartOfAccountTemp> DataLookUpHeader(String code, String name,String Type,String headerCode,Paging paging) throws Exception {
        try {
            paging.setRecords(chartOfAccountDAO.countDataHeaderCode(code,name,Type,headerCode));

            // Calculate total Pages
            paging.setTotal( (int) Math.ceil((double) paging.getRecords()  / (double) paging.getRows()) );

            List<ChartOfAccountTemp> listChartOfAccountTemp = chartOfAccountDAO.findDataLookUpHeader(code, name,Type,headerCode, paging.getFromRow(), paging.getToRow());

            ListPaging<ChartOfAccountTemp> listPaging = new ListPaging<ChartOfAccountTemp>();

            listPaging.setList(listChartOfAccountTemp);
            listPaging.setPaging(paging);

                return listPaging;
        }
        catch(Exception ex) {
            throw ex;
        }
    }
}
