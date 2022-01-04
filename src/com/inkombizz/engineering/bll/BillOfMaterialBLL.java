/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.engineering.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumActivity;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.engineering.dao.BillOfMaterialDAO;
import com.inkombizz.engineering.model.BillOfMaterial;
import com.inkombizz.engineering.model.BillOfMaterialField;
import com.inkombizz.engineering.model.BillOfMaterialPartDetail;
import com.inkombizz.engineering.model.BomTemp;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class BillOfMaterialBLL {
    public static final String MODULECODE = "011_ENG_BILL_OF_MATERIAL";
    public static final String MODULECODE_APPROVAL = "011_ENG_BILL_OF_MATERIAL_APPROVAL";
    
    private BillOfMaterialDAO billOfMaterialDAO;
    
    public BillOfMaterialBLL (HBMSession hbmSession) {
        this.billOfMaterialDAO = new BillOfMaterialDAO(hbmSession);
    }
    
    public ListPaging<BillOfMaterial> findData(Paging paging,BillOfMaterial billOfMaterial) throws Exception{
        try{

            paging.setRecords(billOfMaterialDAO.countData(billOfMaterial));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<BillOfMaterial> listBillOfMaterial = billOfMaterialDAO.findData(billOfMaterial,paging.getFromRow(), paging.getToRow());
            
            ListPaging<BillOfMaterial> listPaging = new ListPaging<BillOfMaterial>();
            listPaging.setList(listBillOfMaterial);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<BillOfMaterial> findDataApproval(Paging paging,BillOfMaterial billOfMaterialApproval) throws Exception{
        try{

            paging.setRecords(billOfMaterialDAO.countDataApproval(billOfMaterialApproval));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<BillOfMaterial> listBillOfMaterial = billOfMaterialDAO.findDataApproval(billOfMaterialApproval,paging.getFromRow(), paging.getToRow());
            
            ListPaging<BillOfMaterial> listPaging = new ListPaging<BillOfMaterial>();
            listPaging.setList(listBillOfMaterial);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<BillOfMaterial> findDataExisting(Paging paging,BillOfMaterial billOfMaterial) throws Exception{
        try{

            paging.setRecords(billOfMaterialDAO.countDataExisting(billOfMaterial));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<BillOfMaterial> listBillOfMaterial = billOfMaterialDAO.findDataExisting(billOfMaterial,paging.getFromRow(), paging.getToRow());
            
            ListPaging<BillOfMaterial> listPaging = new ListPaging<BillOfMaterial>();
            listPaging.setList(listBillOfMaterial);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public ListPaging<BillOfMaterialPartDetail> findDataComponentDetail(String headerCode) throws Exception {
        try {
            List<BillOfMaterialPartDetail> listBillOfMaterialPartDetail = billOfMaterialDAO.findDataComponentDetail(headerCode);
            ListPaging<BillOfMaterialPartDetail> listPaging = new ListPaging<BillOfMaterialPartDetail>();
            
            listPaging.setList(listBillOfMaterialPartDetail);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<BillOfMaterialPartDetail> findDataPartDetail(String headerCodeBom) throws Exception {
        try {
            List<BillOfMaterialPartDetail> listBillOfMaterialPartDetail = billOfMaterialDAO.findDataPartDetail(headerCodeBom);
            ListPaging<BillOfMaterialPartDetail> listPaging = new ListPaging<BillOfMaterialPartDetail>();
            
            listPaging.setList(listBillOfMaterialPartDetail);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<BillOfMaterialPartDetail> findBomArrayImr(String docDetailCode) throws Exception {
        try {
            
            List<BillOfMaterialPartDetail> listBillOfMaterialPartDetail = billOfMaterialDAO.findBomArrayImr(docDetailCode);
            
            return listBillOfMaterialPartDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public void save(EnumActivity.ENUM_Activity enumActivity,BillOfMaterial billOfMaterial, List<BillOfMaterialPartDetail> listBillOfMaterialPartDetail) throws Exception {
        try {
            billOfMaterialDAO.save(enumActivity,billOfMaterial, listBillOfMaterialPartDetail,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(BillOfMaterial billOfMaterial, List<BillOfMaterialPartDetail> listBillOfMaterialPartDetail) throws Exception {
        try {
            billOfMaterialDAO.update(billOfMaterial, listBillOfMaterialPartDetail,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void approval(BillOfMaterial billOfMaterial) throws Exception {
        try {
            billOfMaterialDAO.approval(billOfMaterial,MODULECODE_APPROVAL);
        } catch (Exception e) {
            throw e;
        }
    }
    
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(BillOfMaterial.class)
                            .add(Restrictions.eq(BillOfMaterialField.CODE, headerCode));
             
            if(billOfMaterialDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public String createCode(EnumActivity.ENUM_Activity enumActivity,BillOfMaterial billOfMaterial) throws Exception {
        try {
            return billOfMaterialDAO.createCode(enumActivity,billOfMaterial);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public BomTemp getData(String detailCode)throws Exception{
        try{
           return billOfMaterialDAO.getDataCode(detailCode);
        }catch (Exception e) {
            throw e;
        }
    }
    
}
