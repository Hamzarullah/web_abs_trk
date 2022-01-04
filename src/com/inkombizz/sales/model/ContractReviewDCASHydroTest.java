
package com.inkombizz.sales.model;

import com.inkombizz.master.model.DcasHydroTest;
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

@Entity
@Table(name = "sal_contract_review_jn_dcas_hydro_test")
public class ContractReviewDCASHydroTest implements Serializable{
    @Id
    @Column (name="Code")
    private String code = "";
    
    @Column (name="Headercode")
    private String headerCode = "";
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "HydroTestCode", referencedColumnName = "Code", unique = false, nullable = true, insertable = true, updatable = true)
    private DcasHydroTest dcasHydroTest = null;
    
    @Column (name="CreatedBy")
    private String createdBy = "";
    
    @Column (name="CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    
    @Column (name="UpdatedBy")
    private String updatedBy = "";
    
    @Column (name="UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    private @Transient String dcasHydroTestCode="";
    private @Transient String dcasHydroTestName="";

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public DcasHydroTest getDcasHydroTest() {
        return dcasHydroTest;
    }

    public void setDcasHydroTest(DcasHydroTest dcasHydroTest) {
        this.dcasHydroTest = dcasHydroTest;
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

    public String getDcasHydroTestCode() {
        return dcasHydroTestCode;
    }

    public void setDcasHydroTestCode(String dcasHydroTestCode) {
        this.dcasHydroTestCode = dcasHydroTestCode;
    }

    public String getDcasHydroTestName() {
        return dcasHydroTestName;
    }

    public void setDcasHydroTestName(String dcasHydroTestName) {
        this.dcasHydroTestName = dcasHydroTestName;
    }
    
    
}
