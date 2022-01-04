package com.inkombizz.system.bll;

import java.util.List;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.system.dao.ModuleDAO;
import com.inkombizz.system.model.Module;
import com.inkombizz.system.model.ModuleTemp;

public class ModuleBLL {
    
    public static final String MODULECODE = "008_SYS_MODULE";
    
    private ModuleDAO moduleDAO;

    public ModuleBLL(HBMSession hbmSession) {
        this.moduleDAO = new ModuleDAO(hbmSession);
    }
    
    public ListPaging<ModuleTemp> findData(Paging paging,String name) throws Exception {
        try {
                     
            paging.setRecords(moduleDAO.countData(name));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ModuleTemp> listModuleTemp = moduleDAO.findData(name,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ModuleTemp> listPaging = new ListPaging<ModuleTemp>();
            
            listPaging.setList(listModuleTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }

    public List<ModuleTemp> findDataForUpdate() throws Exception{
        try{
            return moduleDAO.findDataForUpdate();
        }
        catch(Exception ex){
            throw ex;
        }
    }
        
    public void update(List<Module> listModule) throws Exception {
        try {
            moduleDAO.update(listModule);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
}