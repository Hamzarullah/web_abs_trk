
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<style>
    .searchbox{
        border-radius: 3px;
    }
    
    input{border-radius: 3px;height:18px}
    input[readonly="readonly"] { background:#FFF1A0 }
    textarea[readonly="readonly"] { background:#FFF1A0 }
</style>

<script type="text/javascript">
    var 
        txtJournalTypeCode = $("#journalType\\.code"),
        txtJournalTypeName = $("#journalType\\.name"),
        rdbJournalTypeActiveStatus = $("#journalType\\.activeStatus"),
        txtJournalTypeCreatedBy = $("#journalType\\.createdBy"),
        txtJournalTypeCreatedDate = $("#journalType\\.createdDate"),
        
        
        allFields=$([])
            .add(txtJournalTypeCode)
            .add(txtJournalTypeName)
            .add(rdbJournalTypeActiveStatus)
            .add(txtJournalTypeCreatedBy)
            .add(txtJournalTypeCreatedDate);  
            
            
    function reloadGrid() {
        $("#journalType_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function(){
        hoverButton();
        var updateRowId = -1;
        hideInput("journalType");
        $('#journalType\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        $('input[name="journalType\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#journalType\\.activeStatus").val(value);
            
        });
                
        $('input[name="journalType\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#journalType\\.activeStatus").val(value);
        });
        
        $("#btnJournalTypeNew").click(function(ev){
            showInput("journalType");
            hideInput("journalTypeSearch");
            $('#journalType\\.activeStatusActive').prop('checked',true);
            $("#journalType\\.activeStatus").val("true");
            updateRowId = -1;
            txtJournalTypeCode.attr("readonly",false);
            ev.preventDefault();
        });


        $("#btnJournalTypeSave").click(function(ev) {
           if(!$("#frmJournalTypeInput").valid()) {
               ev.preventDefault();
               return;
           };

           var url = "";

           if (updateRowId < 0)
                
               url = "master/journal-type-save";
           else
               url = "master/journal-type-update";
                      
           var params = $("#frmJournalTypeInput").serialize();
       
           $.post(url, params, function(data) {
                if (data.error) {
                    alert(data.errorMessage);
                    return;
                }
                
                alert(data.message);
                hideInput("journalType");
                showInput("journalTypeSearch");
                allFields.val('').removeClass('ui-state-error');
                reloadGrid();           
           });
           ev.preventDefault();
        });
        
        $("#btnJournalTypePrint").click(function(ev) {
            
            var url = "reports/journal-type-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'journalType','width=500,height=500');
        });
        
        $("#btnJournalTypeUpdate").click(function(ev){
            updateRowId = $("#journalType_grid").jqGrid("getGridParam","selrow");
            
            if(updateRowId === null){
                alert("Please Select Row");
                showInput("journalTypeSearch");
            }
            else{
                var journalType = $("#journalType_grid").jqGrid('getRowData', updateRowId);
                var url = "master/journal-type-get";
                var params = "journalTypeTemp.code=" + journalType.code;
                
               
                txtJournalTypeCode.attr("readonly",true);

                $.post(url, params, function(result) {
                    
                    var data = (result);
                    
                        txtJournalTypeCode.val(data.journalTypeTemp.code);
                        txtJournalTypeName.val(data.journalTypeTemp.name);
                        rdbJournalTypeActiveStatus.val(data.journalTypeTemp.activeStatus);
                        txtJournalTypeCreatedBy.val(data.journalTypeTemp.createdBy);
                        txtJournalTypeCreatedDate.val(data.journalTypeTemp.createdDate);
                     
                        if(data.journalTypeTemp.activeStatus===true) {
                           $('#journalType\\.activeStatusActive').prop('checked',true);
                           $("#journalType\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#journalType\\.activeStatusInActive').prop('checked',true);              
                           $("#journalType\\.activeStatus").val("false");
                        }

                    showInput("journalType");
                    hideInput("journalTypeSearch");
                });      
                
            }
            ev.preventDefault();
        });
        
        $('#btnJournalTypeDelete').click(function(ev) {
            var deleteRowId = $("#journalType_grid").jqGrid('getGridParam','selrow');
            
            if (deleteRowId === null) {
                alert("Please Select Row");
            }
            else {
                var journalType = $("#journalType_grid").jqGrid('getRowData', deleteRowId);
                
                if (confirm("Are You Sure To Delete (Code : " + journalType.code + ")")) {
                    var url = "master/journal-type-delete";
                    var params = "journalType.code=" + journalType.code;
                    
                    $.post(url, params, function(data) {
                        if (data.error) {
                            alert(data.errorMessage);
                            return;
                        }

                        alert(data.message);
                        reloadGrid();
                    });
                }
            }
            ev.preventDefault();
        });
        
        
        
       
       $("#btnJournalTypeCancel").click(function(ev) {
            hideInput("journalType");
            showInput("journalTypeSearch");
            allFields.val('').removeClass('ui-state-error');
            ev.preventDefault();
        });
        
        $('#btnJournalTypeRefresh').click(function(ev) {
            $("#journalType_grid").jqGrid("clearGridData");
            $("#journalType_grid").jqGrid("setGridParam",{url:"master/journal-type-data-query?"});
            $("#journalType_grid").trigger("reloadGrid");
            ev.preventDefault();    
        });
        
        $('#btnJournalType_search').click(function(ev) {
            $("#journalType_grid").jqGrid("clearGridData");
            $("#journalType_grid").jqGrid("setGridParam",{url:"master/journal-type-data-query?" + $("#frmJournalTypeSearchInput").serialize()});
            $("#journalType_grid").trigger("reloadGrid");
            ev.preventDefault();
       });
       

       
    });
    
    
</script>

<s:url id="remoteurlJournalType" action="journal-type-data-query" />
<b>JOURNAL TYPE</b>
<hr>
<br class="spacer" />

    <sj:div id="journalTypeButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnJournalTypeNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" /></a>
        <a href="#" id="btnJournalTypeUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" /></a>
        <a href="#" id="btnJournalTypeDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" /></a>
        <a href="#" id="btnJournalTypeRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" /></a>
        <a href="#" id="btnJournalTypePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" /></a>    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="journalTypeSearchInput" class="content ui-widget">
        <s:form id="frmJournalTypeSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right" valign="centre"><b>Code</b></td>
                    <td>
                        <s:textfield id="journalTypeSearchCode" name="journalTypeSearchCode" size="30"></s:textfield>
                    </td>
                    <td align="right" valign="centre"><b>Name</b></td>
                    <td>
                        <s:textfield id="JournalTypeSearchName" name="journalTypeSearchName" size="50"></s:textfield>
                    <td>
                </tr>  
            </table>
            <br />
            <sj:a href="#" id="btnJournalType_search" button="true">Search</sj:a>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
        </s:form>
    </div>
    <br /><br />
    
    <div id="journalTypeGrid">
        <sjg:grid
            id="journalType_grid"
            dataType="json"
            href="%{remoteurlJournalType}"
            pager="true"
            navigator="true"
            navigatorView="true"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listJournalTypeTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="name" index="name" title="Name" width="400" sortable="true"
            />     
        </sjg:grid >
    </div>
    
    <div id="journalTypeInput" class="content ui-widget">
        <s:form id="frmJournalTypeInput">
            <table cellpadding="2" cellspacing="2" >
                <tr>
                    <td align="right"><B>Code *</B></td>
                    <td><s:textfield id="journalType.code" name="journalType.code" title="Please Enter Code!" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Name *</B></td>
                    <td><s:textfield id="journalType.name" name="journalType.name" size="50" title="Please Enter Name!" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Active Status *</B>
                    <s:textfield id="journalType.activeStatus" name="journalType.activeStatus" readonly="false" size="5" hidden="true"></s:textfield></td>
                    <td><s:radio id="journalType.activeStatus" name="journalType.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
                </tr>
                
                <td><s:textfield id="journalType.createdBy"  name="journalType.createdBy" size="20" style="display:none"></s:textfield></td>
                <td><s:textfield id="journalType.createdDate" name="journalType.createdDate" size="20" style="display:none"></s:textfield></td>
            </table>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
            <br />
            <sj:a href="#" id="btnJournalTypeSave" button="true">Save</sj:a>
            <sj:a href="#" id="btnJournalTypeCancel" button="true">Cancel</sj:a>
            <br /><br />
        </s:form>
    </div>