
package com.inkombizz.engineering.model;

import com.inkombizz.action.BaseSession;
import com.inkombizz.common.BaseEntity;
import com.inkombizz.master.model.ItemFinishGoods;
import com.inkombizz.master.model.Reason;
import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.Transient;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;



@Entity
@Table(name = "eng_bill_of_material")
public class BillOfMaterial implements Serializable{
    
    @Id
    @Column(name = "Code")
    private String code = "";
    
    @Column(name = "BOMNo")
    private String bomNo = "";
    
    @Column(name = "TransactionDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date transactionDate= DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "Revision")
    private String revision = "00";
    
    @Column(name = "RefBOMCode")
    private String refBomCode = "";
    
    @Column(name = "ValidStatus")
    private boolean validStatus=true;
    
    @ManyToOne(cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemFinishGoodsCode", referencedColumnName = "code", unique = false, nullable = false, insertable = true, updatable = true)
    private ItemFinishGoods itemFinishGoods=null;
    
    @Column(name = "DocumentDetailCode")
    private String documentDetailCode = "";
    
    @Column(name = "DocumentType")
    private String documentType = "";
    
//    @Column(name = "HeaderCode")
//    private String HeaderCode = ""; 
    
    @Column(name = "DrawingCode")
    private String DrawingCode = "";
    
    @Column(name = "CopyFrom")
    private String copyFrom = "";
    
    @Column(name = "Template")
    private String template = "";
    
    @Column(name = "ExistingBOMCode")
    private String existingBomCode = "";
    
    @Column(name = "Remark")
    private String remark = "";
    
    @Column(name = "InternalNote")
    private String internalNote = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ApprovalReasonCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    @NotFound(action=NotFoundAction.IGNORE)
    private Reason approvalReason = null;
    
    @Column(name = "ApprovalStatus")
    private String approvalStatus = "";
    
    @Column(name = "ApprovalDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date approvalDate = DateUtils.newDate(1990, 01, 01);
    
    @Column(name = "ApprovalBy")
    private String approvalBy = "";
    
    @Column(name = "ApprovalRemark")
    private String approvalRemark = "";
    
    @Column(name = "CreatedBy", length = 50)
    private String createdBy = "";
    
    @Column(name = "CreatedDate", length = 50)
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    
    @Column(name = "UpdatedBy", length = 50)
    private String updatedBy = "";
    
    @Column(name = "UpdatedDate", length = 50)
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    
    //transient
    private @Transient String documentOrderType= "";
    private @Transient String documentOrderDetailCode= "";
    private @Transient String bomStatusNew= "";
    private @Transient String documentOrderCode= "";
    private @Transient String itemFinishGoodsCode= "";
    private @Transient String itemFinishGoodsRemark= "";
    private @Transient Date transactionFirstDate= DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private @Transient Date transactionLastDate= DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
    private @Transient Date transactionDateDoc = DateUtils.newDate(1900, 1, 1);
    private @Transient String customerCode = "";
    private @Transient String customerName = "";
    private @Transient String refNo = "";
    private @Transient String remarkDoc = "";
    private @Transient String codeTemp = "";
    
    
    //Default Set Get

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getBomNo() {
        return bomNo;
    }

    public void setBomNo(String bomNo) {
        this.bomNo = bomNo;
    }

    public String getRevision() {
        return revision;
    }

    public void setRevision(String revision) {
        this.revision = revision;
    }

    public boolean isValidStatus() {
        return validStatus;
    }

    public void setValidStatus(boolean validStatus) {
        this.validStatus = validStatus;
    }

    public ItemFinishGoods getItemFinishGoods() {
        return itemFinishGoods;
    }

    public void setItemFinishGoods(ItemFinishGoods itemFinishGoods) {
        this.itemFinishGoods = itemFinishGoods;
    }

    public String getDrawingCode() {
        return DrawingCode;
    }

    public void setDrawingCode(String DrawingCode) {
        this.DrawingCode = DrawingCode;
    }

    public String getTemplate() {
        return template;
    }

    public void setTemplate(String template) {
        this.template = template;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getInternalNote() {
        return internalNote;
    }

    public void setInternalNote(String internalNote) {
        this.internalNote = internalNote;
    }

    public Reason getApprovalReason() {
        return approvalReason;
    }

    public void setApprovalReason(Reason approvalReason) {
        this.approvalReason = approvalReason;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public Date getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
    }

    public String getApprovalBy() {
        return approvalBy;
    }

    public void setApprovalBy(String approvalBy) {
        this.approvalBy = approvalBy;
    }

    public String getApprovalRemark() {
        return approvalRemark;
    }

    public void setApprovalRemark(String approvalRemark) {
        this.approvalRemark = approvalRemark;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getDocumentType() {
        return documentType;
    }

    public void setDocumentType(String documentType) {
        this.documentType = documentType;
    }

    public String getDocumentOrderCode() {
        return documentOrderCode;
    }

    public void setDocumentOrderCode(String documentOrderCode) {
        this.documentOrderCode = documentOrderCode;
    }

    public String getItemFinishGoodsCode() {
        return itemFinishGoodsCode;
    }

    public void setItemFinishGoodsCode(String itemFinishGoodsCode) {
        this.itemFinishGoodsCode = itemFinishGoodsCode;
    }

    public Date getTransactionFirstDate() {
        return transactionFirstDate;
    }

    public void setTransactionFirstDate(Date transactionFirstDate) {
        this.transactionFirstDate = transactionFirstDate;
    }

    public Date getTransactionLastDate() {
        return transactionLastDate;
    }

    public void setTransactionLastDate(Date transactionLastDate) {
        this.transactionLastDate = transactionLastDate;
    }

    public String getDocumentOrderType() {
        return documentOrderType;
    }

    public void setDocumentOrderType(String documentOrderType) {
        this.documentOrderType = documentOrderType;
    }

    public String getBomStatusNew() {
        return bomStatusNew;
    }

    public void setBomStatusNew(String bomStatusNew) {
        this.bomStatusNew = bomStatusNew;
    }

    public String getRefBomCode() {
        return refBomCode;
    }

    public void setRefBomCode(String refBomCode) {
        this.refBomCode = refBomCode;
    }

    public String getDocumentDetailCode() {
        return documentDetailCode;
    }

    public void setDocumentDetailCode(String documentDetailCode) {
        this.documentDetailCode = documentDetailCode;
    }

    public String getCopyFrom() {
        return copyFrom;
    }

    public void setCopyFrom(String copyFrom) {
        this.copyFrom = copyFrom;
    }

    public String getExistingBomCode() {
        return existingBomCode;
    }

    public void setExistingBomCode(String existingBomCode) {
        this.existingBomCode = existingBomCode;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }

    public String getRemarkDoc() {
        return remarkDoc;
    }

    public void setRemarkDoc(String remarkDoc) {
        this.remarkDoc = remarkDoc;
    }

    public Date getTransactionDateDoc() {
        return transactionDateDoc;
    }

    public void setTransactionDateDoc(Date transactionDateDoc) {
        this.transactionDateDoc = transactionDateDoc;
    }

    public String getItemFinishGoodsRemark() {
        return itemFinishGoodsRemark;
    }

    public void setItemFinishGoodsRemark(String itemFinishGoodsRemark) {
        this.itemFinishGoodsRemark = itemFinishGoodsRemark;
    }

    public String getCodeTemp() {
        return codeTemp;
    }

    public void setCodeTemp(String codeTemp) {
        this.codeTemp = codeTemp;
    }

    public String getDocumentOrderDetailCode() {
        return documentOrderDetailCode;
    }

    public void setDocumentOrderDetailCode(String documentOrderDetailCode) {
        this.documentOrderDetailCode = documentOrderDetailCode;
    }
    
    
}

   

