/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.inventory.bll;

/**
 *
 * @author Rayis
 */

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.inventory.dao.AssemblyRealizationDAO;
import com.inkombizz.inventory.model.AssemblyRealization;
import com.inkombizz.inventory.model.AssemblyRealizationCOGS;
import com.inkombizz.inventory.model.AssemblyRealizationItemDetail;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class AssemblyRealizationBLL {
    
    public static final String MODULECODE = "003_IVT_ASSEMBLY_REALIZATION";
    
    private AssemblyRealizationDAO assemblyRealizationDAO;
    
    public AssemblyRealizationBLL (HBMSession hbmSession) {
        this.assemblyRealizationDAO = new AssemblyRealizationDAO(hbmSession);
    }
    
    public ListPaging<AssemblyRealization> findData(Paging paging,Date firstDate, Date lastDate,String code, 
            String assemblyJobOrderCode,String finishGoodsCode,String finishGoodsName,String refNo,String remark) throws Exception{
        try{

            paging.setRecords(assemblyRealizationDAO.countData(firstDate,lastDate,code,assemblyJobOrderCode,finishGoodsCode,finishGoodsName,refNo,remark));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<AssemblyRealization> listAssemblyRealization = assemblyRealizationDAO.findData(firstDate,lastDate,code,assemblyJobOrderCode,finishGoodsCode,finishGoodsName,refNo,remark,paging.getFromRow(), paging.getToRow());
            
            ListPaging<AssemblyRealization> listPaging = new ListPaging<AssemblyRealization>();
            listPaging.setList(listAssemblyRealization);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<AssemblyRealization> searchData(Paging paging,Date firstDate, Date lastDate,String code, 
            String assemblyJobOrderCode,String finishGoodsCode,String finishGoodsName,String refNo,String remark) throws Exception{
        try{

            paging.setRecords(assemblyRealizationDAO.countSearchData(firstDate,lastDate,code,assemblyJobOrderCode,finishGoodsCode,finishGoodsName,refNo,remark));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<AssemblyRealization> listAssemblyRealization = assemblyRealizationDAO.searchData(firstDate,lastDate,code,assemblyJobOrderCode,finishGoodsCode,finishGoodsName,refNo,remark,paging.getFromRow(), paging.getToRow());
            
            ListPaging<AssemblyRealization> listPaging = new ListPaging<AssemblyRealization>();
            listPaging.setList(listAssemblyRealization);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<AssemblyRealizationItemDetail> findDataItemDetail(String headerCode) throws Exception{
       try{
            
            List<AssemblyRealizationItemDetail> listAssemblyRealizationDetail = assemblyRealizationDAO.findDataItemDetail(headerCode);
                        
            return listAssemblyRealizationDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<AssemblyRealizationCOGS> findDataCOGS(String headerCode) throws Exception{
       try{
            
            List<AssemblyRealizationCOGS> listAssemblyRealizationCOGS = assemblyRealizationDAO.findDataCOGS(headerCode);
                        
            return listAssemblyRealizationCOGS;
        }catch(Exception e){
            throw e;
        }
    }
    
    public void save(AssemblyRealization assemblyRealization,List<AssemblyRealizationItemDetail> listAssemblyRealizationItemDetail,
            List<AssemblyRealizationCOGS> listAssemblyRealizationCOGS) throws Exception {
        try {
            assemblyRealizationDAO.save(assemblyRealization, listAssemblyRealizationItemDetail,listAssemblyRealizationCOGS,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(AssemblyRealization assemblyRealization,List<AssemblyRealizationItemDetail> listAssemblyRealizationItemDetail,
            List<AssemblyRealizationCOGS> listAssemblyRealizationCOGS) throws Exception {
        try {
            assemblyRealizationDAO.update(assemblyRealization, listAssemblyRealizationItemDetail,listAssemblyRealizationCOGS,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    public boolean isUsed(String code) throws Exception{
        try{            
            boolean used=false;
            if (assemblyRealizationDAO.countDataAssemblyRealization(code)>0){
                used=true;
            }
            else {used=false;}
            return used;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(AssemblyRealization.class)
                            .add(Restrictions.eq("code", headerCode));
             
            if(assemblyRealizationDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public void delete(String code) throws Exception{
        try{
            assemblyRealizationDAO.delete(code, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }
    
}
