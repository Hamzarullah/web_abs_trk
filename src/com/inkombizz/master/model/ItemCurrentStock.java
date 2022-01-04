package com.inkombizz.master.model;

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

@Entity
@Table(name = "mst_item_jn_current_stock")
public class ItemCurrentStock implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private String code = "";
    private String name = "";
    private Branch branch = null;
    private Warehouse warehouse = null;
    private ItemMaterial itemMaterial = null;
    private Rack rack = null;
    private boolean activeStatus=false;
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    
    
    @Id
    @Column(name = "Code")
    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }
    
    
    @Column(name = "Name")
    public String getName() {
        return name;
    }
    public void setName(String Name) {
        this.name = Name;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "BranchCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Branch getBranch() {
        return branch;
    }

    public void setBranch(Branch branch) {
        this.branch = branch;
    }
    
    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "WarehouseCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "ItemMaterialCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public ItemMaterial getItemMaterial() {
        return itemMaterial;
    }

    public void setItemMaterial(ItemMaterial itemMaterial) {
        this.itemMaterial = itemMaterial;
    }

    @ManyToOne (cascade = {}, fetch = FetchType.EAGER)
    @JoinColumn (name = "RackCode", referencedColumnName = "Code", unique = false, nullable = false, insertable = true, updatable = true)
    public Rack getRack() {
        return rack;
    }

    public void setRack(Rack rack) {
        this.rack = rack;
    }
  
    @Column (name = "ActiveStatus")
    public boolean isActiveStatus() {
        return activeStatus;
    }

    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }
    

    @Column (name = "CreatedBy")
    public String getCreatedBy(){
        return createdBy;
    }

    public void setCreatedBy(String createdby){
        this.createdBy = createdby;
    }
    
    
    @Column (name = "CreatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getCreatedDate(){
        return createdDate;
    }
    public void setCreatedDate(Date createdDate){
        this.createdDate = createdDate;
    }
    
    
    @Column (name = "UpdatedBy", length = 50)
    public String getUpdatedBy(){
        return updatedBy;
    }
    public void setUpdatedBy(String updatedby){
        this.updatedBy = updatedby;
    }
    
    
    @Column (name = "UpdatedDate")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    public Date getUpdatedDate(){
        return updatedDate;
    }
    public void setUpdatedDate(Date updatedDate){
        this.updatedDate = updatedDate;
    }
    
    
}