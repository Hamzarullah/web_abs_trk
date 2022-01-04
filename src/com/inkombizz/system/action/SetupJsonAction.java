package com.inkombizz.system.action;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;

import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.system.bll.SetupBLL;
import com.inkombizz.system.model.Setup;
import com.opensymphony.xwork2.ActionSupport;

@Result(type = "json")
public class SetupJsonAction extends ActionSupport {
    private static final long serialVersionUID = 1L;
    
    protected HBMSession hbmSession = new HBMSession();
    
    private Setup setup;
    private Setup searchSetup;
    private List<Setup> listSetup;

    @Override
    //@SuppressWarnings("CallToThreadDumpStack")
    public String execute() {
        try {
            return populateData();
        }
        catch(Exception ex) {
            //do nothing dulu
            //ex.printStackTrace();
            return SUCCESS;
        }
    }
    
    @Action("setup-data")
    //@SuppressWarnings("CallToThreadDumpStack")
    public String populateData() {
        try {
            SetupBLL setupBLL = new SetupBLL(hbmSession);
            //ListPaging<Setup> listPaging = setupBLL.getList(paging);

            //listSetup = listPaging.getList();

            return SUCCESS;
        }
        catch(Exception ex) {
            //do nothing dulu
            System.out.println("ADA ERROR : " + ex.getMessage());
            return SUCCESS;
        }
    }    
    

    @Action("setup-get")
    //@SuppressWarnings("CallToThreadDumpStack")
    public String get() {
        try {
            SetupBLL setupBLL = new SetupBLL(hbmSession);
            this.setup = setupBLL.get("IKB");
            
            return SUCCESS;
        }
        catch(Exception ex) {
            //do nothing dulu
            //ex.printStackTrace();
            return SUCCESS;
        }
    }

    public Setup getSetup() {
        return setup;
    }
    public void setSetup(Setup setup) {
        this.setup = setup;
    }

    public List<Setup> getListSetup() {
        return listSetup;
    }
    public void setListSetup(List<Setup> listSetup) {
        this.listSetup = listSetup;
    }

    public Setup getSearchSetup() {
        return searchSetup;
    }
    public void setSearchSetup(Setup searchSetup) {
        this.searchSetup = searchSetup;
    }
    
    Paging paging = new Paging();

    public int getRows() {
        return paging.getRows();
    }
    public void setRows(int rows) {
        paging.setRows(rows);
    }

    public int getPage() {
        return paging.getPage();
    }
    public void setPage(int page) {
        paging.setPage(page);
    }

    public int getTotal() {
        return paging.getTotal();
    }
    public void setTotal(int total) {
        paging.setTotal(total);
    }

    public int getRecords() {
        return paging.getRecords();
    }
    public void setRecords(int records) {
        paging.setRecords(records);
        
        if (paging.getRecords() > 0 && paging.getRows() > 0)
            paging.setTotal((int) Math.ceil((double) paging.getRecords() / (double) paging.getRows()));
        else
            paging.setTotal(0);
    }

    public String getSord() {
        return paging.getSord();
    }
    public void setSord(String sord) {
        paging.setSord(sord);
    }

    public String getSidx() {
        return paging.getSidx();
    }
    public void setSidx(String sidx) {
        paging.setSidx(sidx);
    }

    public void setSearchField(String searchField) {
       paging.setSearchField(searchField);
    }
    public void setSearchString(String searchString) {
        paging.setSearchString(searchString);
    }
    public void setSearchOper(String searchOper) {
        paging.setSearchOper(searchOper);
    }

    public HBMSession getHbmSession() {
        return hbmSession;
    }

    public void setHbmSession(HBMSession hbmSession) {
        this.hbmSession = hbmSession;
    }

    public Paging getPaging() {
        return paging;
    }

    public void setPaging(Paging paging) {
        this.paging = paging;
    }
    
}