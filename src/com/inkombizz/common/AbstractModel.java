/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.common;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

/**
 *
 * @author Henda
 */
@MappedSuperclass
public class AbstractModel extends BaseEntity{
    
    public boolean activeStatus = true;
    
    @Column(name = "activeStatus")
    public boolean isActiveStatus() {
        return activeStatus;
    }
    public void setActiveStatus(boolean activeStatus) {
        this.activeStatus = activeStatus;
    }
}
