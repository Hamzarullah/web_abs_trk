
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js"/>"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
     
    var 
        txtItemSeatDesignCode=$("#itemSeatDesign\\.code"),
        txtItemSeatDesignName=$("#itemSeatDesign\\.name"),
        rdbItemSeatDesignActiveStatus=$("#itemSeatDesign\\.activeStatus"),
        txtItemSeatDesignRemark=$("#itemSeatDesign\\.remark"),
        txtItemSeatDesignInActiveBy = $("#itemSeatDesign\\.inActiveBy"),
        dtpItemSeatDesignInActiveDate = $("#itemSeatDesign\\.inActiveDate"),
        txtItemSeatDesignCreatedBy = $("#itemSeatDesign\\.createdBy"),
        dtpItemSeatDesignCreatedDate = $("#itemSeatDesign\\.createdDate"),
        
        allFieldsItemSeatDesign=$([])
            .add(txtItemSeatDesignCode)
            .add(txtItemSeatDesignName)
            .add(txtItemSeatDesignRemark)
            .add(txtItemSeatDesignInActiveBy)
            .add(txtItemSeatDesignCreatedBy);


    function reloadGridItemSeatDesign(){
        $("#itemSeatDesign_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemSeatDesign");
        
        $('#itemSeatDesign\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemSeatDesignSearchActiveStatusRadActive').prop('checked',true);
        $("#itemSeatDesignSearchActiveStatus").val("true");
        
        $('input[name="itemSeatDesignSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemSeatDesignSearchActiveStatus").val(value);
        });
        
        $('input[name="itemSeatDesignSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSeatDesignSearchActiveStatus").val(value);
        });
                
        $('input[name="itemSeatDesignSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSeatDesignSearchActiveStatus").val(value);
        });
        
        $('input[name="itemSeatDesignActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSeatDesign\\.activeStatus").val(value);
            $("#itemSeatDesign\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemSeatDesignActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSeatDesign\\.activeStatus").val(value);
        });
        
        $("#btnItemSeatDesignNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-seat-design-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSeatDesign();
                showInput("itemSeatDesign");
                hideInput("itemSeatDesignSearch");
                $('#itemSeatDesignActiveStatusRadActive').prop('checked',true);
                $("#itemSeatDesign\\.activeStatus").val("true");
                $("#itemSeatDesign\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemSeatDesign\\.createdDate").val("01/01/1900 00:00:00");
                txtItemSeatDesignCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemSeatDesignCode.attr("readonly",true);
                txtItemSeatDesignCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSeatDesignSave").click(function(ev) {
           if(!$("#frmItemSeatDesignInput").valid()) {
//               handlers_input_itemSeatDesign();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemSeatDesignFormatDate();
           if (updateRowId < 0){
               url = "master/item-seat-design-save";
           } else{
               url = "master/item-seat-design-update";
           }
           
           var params = $("#frmItemSeatDesignInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemSeatDesignFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemSeatDesign");
                showInput("itemSeatDesignSearch");
                allFieldsItemSeatDesign.val('').siblings('label[class="error"]').hide();
                txtItemSeatDesignCode.val("AUTO");
                reloadGridItemSeatDesign();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemSeatDesignUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-seat-design-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSeatDesign();
                updateRowId=$("#itemSeatDesign_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemSeatDesign=$("#itemSeatDesign_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-seat-design-get-data";
                var params="itemSeatDesign.code=" + itemSeatDesign.code;

                txtItemSeatDesignCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemSeatDesignCode.val(data.itemSeatDesignTemp.code);
                        txtItemSeatDesignName.val(data.itemSeatDesignTemp.name);
                        rdbItemSeatDesignActiveStatus.val(data.itemSeatDesignTemp.activeStatus);
                        txtItemSeatDesignRemark.val(data.itemSeatDesignTemp.remark);
                        txtItemSeatDesignInActiveBy.val(data.itemSeatDesignTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemSeatDesignTemp.inActiveDate,true);
                        dtpItemSeatDesignInActiveDate.val(inActiveDate);
                        txtItemSeatDesignCreatedBy.val(data.itemSeatDesignTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemSeatDesignTemp.createdDate,true);
                        dtpItemSeatDesignCreatedDate.val(createdDate);

                        if(data.itemSeatDesignTemp.activeStatus===true) {
                           $('#itemSeatDesignActiveStatusRadActive').prop('checked',true);
                           $("#itemSeatDesign\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemSeatDesignActiveStatusRadInActive').prop('checked',true);              
                           $("#itemSeatDesign\\.activeStatus").val("false");
                        }

                        showInput("itemSeatDesign");
                        hideInput("itemSeatDesignSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSeatDesignDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-seat-design-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemSeatDesign_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemSeatDesign=$("#itemSeatDesign_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-seat-design-delete";
                var params="itemSeatDesign.code=" + itemSeatDesign.code;
                var message="Are You Sure To Delete(Code : "+ itemSeatDesign.code + ")?";
                alertMessageDelete("itemSeatDesign",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemSeatDesign.code+ ')?</div>');
//
//                dynamicDialog.dialog({
//                    title : "Confirmation:",
//                    closeOnEscape: false,
//                    modal : true,
//                    width: 500,
//                    resizable: false,
//                    buttons : 
//                        [{
//                            text : "Yes",
//                            click : function() {
//
//                                $(this).dialog("close");
//                                var url="master/item-seat-design-delete";
//                                var params="itemSeatDesign.code=" + itemSeatDesign.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemSeatDesign();
//                                });
//                            }
//                        },
//                        {
//                            text : "No",
//                            click : function() {
//
//                                $(this).dialog("close");
//                            }
//                        }]
//                });
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemSeatDesign.code+ ")")){
//                    var url="master/item-seat-design-delete";
//                    var params="itemSeatDesign.code=" + itemSeatDesign.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemSeatDesign();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemSeatDesignCancel").click(function(ev) {
            hideInput("itemSeatDesign");
            showInput("itemSeatDesignSearch");
            allFieldsItemSeatDesign.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemSeatDesignRefresh').click(function(ev) {
            $('#itemSeatDesignSearchActiveStatusRadActive').prop('checked',true);
            $("#itemSeatDesignSearchActiveStatus").val("true");
            $("#itemSeatDesign_grid").jqGrid("clearGridData");
            $("#itemSeatDesign_grid").jqGrid("setGridParam",{url:"master/item-seat-design-data?"});
            $("#itemSeatDesign_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemSeatDesignPrint").click(function(ev) {
            
            var url = "reports/item-seat-design-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemSeatDesign','width=500,height=500');
        });
        
        $('#btnItemSeatDesign_search').click(function(ev) {
            $("#itemSeatDesign_grid").jqGrid("clearGridData");
            $("#itemSeatDesign_grid").jqGrid("setGridParam",{url:"master/item-seat-design-data?" + $("#frmItemSeatDesignSearchInput").serialize()});
            $("#itemSeatDesign_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemSeatDesign(){
//        unHandlersInput(txtItemSeatDesignCode);
//        unHandlersInput(txtItemSeatDesignName);
//    }
//
//    function handlers_input_itemSeatDesign(){
//        if(txtItemSeatDesignCode.val()===""){
//            handlersInput(txtItemSeatDesignCode);
//        }else{
//            unHandlersInput(txtItemSeatDesignCode);
//        }
//        if(txtItemSeatDesignName.val()===""){
//            handlersInput(txtItemSeatDesignName);
//        }else{
//            unHandlersInput(txtItemSeatDesignName);
//        }
//    }
    
    function itemSeatDesignFormatDate(){
        var inActiveDate=formatDate(dtpItemSeatDesignInActiveDate.val(),true);
        dtpItemSeatDesignInActiveDate.val(inActiveDate);
        $("#itemSeatDesignTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemSeatDesignCreatedDate.val(),true);
        dtpItemSeatDesignCreatedDate.val(createdDate);
        $("#itemSeatDesignTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemSeatDesign" action="item-seat-design-data" />
<b>Item Seat Design</b>
<hr>
<br class="spacer"/>


<sj:div id="itemSeatDesignButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemSeatDesignNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemSeatDesignUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemSeatDesignDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemSeatDesignRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemSeatDesignPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemSeatDesignSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemSeatDesignSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemSeatDesignSearchCode" name="itemSeatDesignSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemSeatDesignSearchName" name="itemSeatDesignSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemSeatDesignSearchActiveStatus" name="itemSeatDesignSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemSeatDesignSearchActiveStatusRad" name="itemSeatDesignSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemSeatDesign_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemSeatDesignGrid">
    <sjg:grid
        id="itemSeatDesign_grid"
        dataType="json"
        href="%{remoteurlItemSeatDesign}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemSeatDesignTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="itemSeatDesignInput" class="content ui-widget">
    <s:form id="frmItemSeatDesignInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemSeatDesign.code" name="itemSeatDesign.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemSeatDesign.name" name="itemSeatDesign.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemSeatDesignActiveStatusRad" name="itemSeatDesignActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemSeatDesign.activeStatus" name="itemSeatDesign.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemSeatDesign.remark" name="itemSeatDesign.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemSeatDesign.inActiveBy"  name="itemSeatDesign.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="itemSeatDesign.inActiveDate" name="itemSeatDesign.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSeatDesign.createdBy"  name="itemSeatDesign.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemSeatDesign.createdDate" name="itemSeatDesign.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSeatDesignTemp.inActiveDateTemp" name="itemSeatDesignTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemSeatDesignTemp.createdDateTemp" name="itemSeatDesignTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemSeatDesignSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemSeatDesignCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>