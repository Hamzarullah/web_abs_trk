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
import com.inkombizz.inventory.dao.AssemblyJobOrderDAO;
import com.inkombizz.inventory.model.AssemblyJobOrder;
import com.inkombizz.inventory.model.AssemblyJobOrderItemDetail;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class AssemblyJobOrderBLL {
    
    public static final String MODULECODE_JOB_ORDER = "003_IVT_ASSEMBLY_JOB_ORDER";
    
    private AssemblyJobOrderDAO assemblyJobOrderDAO;
    
    public AssemblyJobOrderBLL (HBMSession hbmSession) {
        this.assemblyJobOrderDAO = new AssemblyJobOrderDAO(hbmSession);
    }
    
    public ListPaging<AssemblyJobOrder> findData(Paging paging,Date firstDate, Date lastDate,String code, 
            String finishGoodsCode,String finishGoodsName,String refNo,String remark) throws Exception{
        try{

            paging.setRecords(assemblyJobOrderDAO.countData(firstDate,lastDate,code,finishGoodsCode,finishGoodsName,refNo,remark));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<AssemblyJobOrder> listAssemblyJobOrder = assemblyJobOrderDAO.findData(firstDate,lastDate,code,finishGoodsCode,finishGoodsName,refNo,remark,paging.getFromRow(), paging.getToRow());
            
            ListPaging<AssemblyJobOrder> listPaging = new ListPaging<AssemblyJobOrder>();
            listPaging.setList(listAssemblyJobOrder);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<AssemblyJobOrder> searchData(Paging paging,Date firstDate, Date lastDate,String code, 
            String finishGoodsCode,String finishGoodsName,String refNo,String remark) throws Exception{
        try{

            paging.setRecords(assemblyJobOrderDAO.countSearchData(firstDate,lastDate,code,finishGoodsCode,finishGoodsName,refNo,remark));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<AssemblyJobOrder> listAssemblyJobOrder = assemblyJobOrderDAO.searchData(firstDate,lastDate,code,finishGoodsCode,finishGoodsName,refNo,remark,paging.getFromRow(), paging.getToRow());
            
            ListPaging<AssemblyJobOrder> listPaging = new ListPaging<AssemblyJobOrder>();
            listPaging.setList(listAssemblyJobOrder);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<AssemblyJobOrderItemDetail> findDataItemDetail(String headerCode) throws Exception{
       try{
            
            List<AssemblyJobOrderItemDetail> listProductionJobOrderDetail = assemblyJobOrderDAO.findDataItemDetail(headerCode);
                        
            return listProductionJobOrderDetail;
        }catch(Exception e){
            throw e;
        }
    }
    
    public void save(AssemblyJobOrder assemblyJobOrder,List<AssemblyJobOrderItemDetail> listAssemblyJobOrderItemDetail) throws Exception {
        try {
            assemblyJobOrderDAO.save(assemblyJobOrder, listAssemblyJobOrderItemDetail,MODULECODE_JOB_ORDER);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(AssemblyJobOrder assemblyJobOrder,List<AssemblyJobOrderItemDetail> listAssemblyJobOrderItemDetail) throws Exception {
        try {
            assemblyJobOrderDAO.update(assemblyJobOrder, listAssemblyJobOrderItemDetail,MODULECODE_JOB_ORDER);
        }
        catch (Exception e) {
            throw e;
        }
    }
    public boolean isUsed(String code) throws Exception{
        try{            
            boolean used=false;
            if (assemblyJobOrderDAO.countDataAssemblyJobOrder(code)>0){
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
            
            DetachedCriteria criteria = DetachedCriteria.forClass(AssemblyJobOrder.class)
                            .add(Restrictions.eq("code", headerCode));
             
            if(assemblyJobOrderDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }

    public void delete(String code) throws Exception{
        try{
            assemblyJobOrderDAO.delete(code, MODULECODE_JOB_ORDER);
        }catch(Exception e){
            throw e;
        }
    }
}
