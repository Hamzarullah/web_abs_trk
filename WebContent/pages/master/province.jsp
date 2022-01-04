
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
        txtProvinceCode=$("#province\\.code"),
        txtProvinceName=$("#province\\.name"),
        txtProvinceIslandCode=$("#province\\.island\\.code"),
        txtProvinceIslandName=$("#province\\.island\\.name"),
        rdbProvinceActiveStatus=$("#province\\.activeStatus"),
        txtProvinceRemark=$("#province\\.remark"),
        txtProvinceInActiveBy = $("#province\\.inActiveBy"),
        dtpProvinceInActiveDate = $("#province\\.inActiveDate"),
        txtProvinceCreatedBy = $("#province\\.createdBy"),
        dtpProvinceCreatedDate = $("#province\\.createdDate"),
        
        allFieldsProvince=$([])
            .add(txtProvinceCode)
            .add(txtProvinceName)
            .add(txtProvinceIslandCode)
            .add(txtProvinceIslandName)
            .add(rdbProvinceActiveStatus)
            .add(txtProvinceRemark)
            .add(txtProvinceInActiveBy)
            .add(txtProvinceCreatedBy);


    function reloadGridProvince(){
        $("#province_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("province");
        
        $('#province\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#provinceSearchActiveStatusRadActive').prop('checked',true);
        $("#provinceSearchActiveStatus").val("true");
        
        $('input[name="provinceSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#provinceSearchActiveStatus").val(value);
        });
        
        $('input[name="provinceSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#provinceSearchActiveStatus").val(value);
        });
                
        $('input[name="provinceSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#provinceSearchActiveStatus").val(value);
        });
        
        $('input[name="provinceActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#province\\.activeStatus").val(value);
            $("#province\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="provinceActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#province\\.activeStatus").val(value);
        });
        
        $("#btnProvinceNew").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/province-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_province();
                showInput("province");
                hideInput("provinceSearch");
                $('#provinceActiveStatusRadActive').prop('checked',true);
                $("#province\\.activeStatus").val("true");
                $("#province\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#province\\.createdDate").val("01/01/1900 00:00:00");
                txtProvinceCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtProvinceCode.attr("readonly",false);

            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnProvinceSave").click(function(ev) {
           if(!$("#frmProvinceInput").valid()) {
//               handlers_input_province();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           provinceFormatDate();
           if (updateRowId < 0){
               url = "master/province-save";
           } else{
               url = "master/province-update";
           }
           
           var params = $("#frmProvinceInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    provinceFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("province");
                showInput("provinceSearch");
                allFieldsProvince.val('').siblings('label[class="error"]').hide();
                reloadGridProvince();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnProvinceUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/province-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_province();
                updateRowId=$("#province_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var province=$("#province_grid").jqGrid('getRowData',updateRowId);
                var url="master/province-get-data";
                var params="province.code=" + province.code;

                txtProvinceCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtProvinceCode.val(data.provinceTemp.code);
                        txtProvinceName.val(data.provinceTemp.name);
                        txtProvinceIslandCode.val(data.provinceTemp.islandCode);
                        txtProvinceIslandName.val(data.provinceTemp.islandName);
                        rdbProvinceActiveStatus.val(data.provinceTemp.activeStatus);
                        txtProvinceRemark.val(data.provinceTemp.remark);
                        txtProvinceInActiveBy.val(data.provinceTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.provinceTemp.inActiveDate,true);
                        dtpProvinceInActiveDate.val(inActiveDate);
                        txtProvinceCreatedBy.val(data.provinceTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.provinceTemp.createdDate,true);
                        dtpProvinceCreatedDate.val(createdDate);

                        if(data.provinceTemp.activeStatus===true) {
                           $('#provinceActiveStatusRadActive').prop('checked',true);
                           $("#province\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#provinceActiveStatusRadInActive').prop('checked',true);              
                           $("#province\\.activeStatus").val("false");
                        }

                        showInput("province");
                        hideInput("provinceSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnProvinceDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/province-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#province_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var province=$("#province_grid").jqGrid('getRowData',deleteRowID);
                var url="master/province-delete";
                var params="province.code=" + province.code;
                var message="Are You Sure To Delete(Code : "+ province.code + ")?";
                alertMessageDelete("province",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ province.code+ ')?</div>');
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
//                                var url="master/province-delete";
//                                var params="province.code=" + province.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridProvince();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + province.code+ ")")){
//                    var url="master/province-delete";
//                    var params="province.code=" + province.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridProvince();
//                    });
//                }
            });
            });
//            ev.preventDefault();
        });
        

        $("#btnProvinceCancel").click(function(ev) {
            hideInput("province");
            showInput("provinceSearch");
            allFieldsProvince.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnProvinceRefresh').click(function(ev) {
            $('#provinceSearchActiveStatusRadActive').prop('checked',true);
            $("#provinceSearchActiveStatus").val("true");
            $("#province_grid").jqGrid("clearGridData");
            $("#province_grid").jqGrid("setGridParam",{url:"master/province-data?"});
            $("#province_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnProvincePrint").click(function(ev) {
            
            var url = "reports/province-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'province','width=500,height=500');
        });
        
        $('#btnProvince_search').click(function(ev) {
            $("#province_grid").jqGrid("clearGridData");
            $("#province_grid").jqGrid("setGridParam",{url:"master/province-data?" + $("#frmProvinceSearchInput").serialize()});
            $("#province_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        $('#province_btnIsland').click(function(ev) {
            window.open("./pages/search/search-island.jsp?iddoc=province&idsubdoc=island","Search", "Scrollbars=1,width=600, height=500");
        });
    });
    
//    function unHandlers_input_province(){
//        unHandlersInput(txtProvinceCode);
//        unHandlersInput(txtProvinceName);
//    }
//
//    function handlers_input_province(){
//        if(txtProvinceCode.val()===""){
//            handlersInput(txtProvinceCode);
//        }else{
//            unHandlersInput(txtProvinceCode);
//        }
//        if(txtProvinceName.val()===""){
//            handlersInput(txtProvinceName);
//        }else{
//            unHandlersInput(txtProvinceName);
//        }
//    }
    
    function provinceFormatDate(){
        var inActiveDate=formatDate(dtpProvinceInActiveDate.val(),true);
        dtpProvinceInActiveDate.val(inActiveDate);
        $("#provinceTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpProvinceCreatedDate.val(),true);
        dtpProvinceCreatedDate.val(createdDate);
        $("#provinceTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlProvince" action="province-data" />
<b>PROVINCE</b>
<hr>
<br class="spacer"/>


<sj:div id="provinceButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnProvinceNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnProvinceUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnProvinceDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnProvinceRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnProvincePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>               
    
<div id="provinceSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmProvinceSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="provinceSearchCode" name="provinceSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="provinceSearchName" name="provinceSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="provinceSearchActiveStatus" name="provinceSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="provinceSearchActiveStatusRad" name="provinceSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnProvince_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="provinceGrid">
    <sjg:grid
        id="province_grid"
        dataType="json"
        href="%{remoteurlProvince}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listProvinceTemp"
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
    
<div id="provinceInput" class="content ui-widget">
    <s:form id="frmProvinceInput">
        <table cellpadding="2" cellspacing="2" width="100%">
            <tr>
                <td align="right" width="100px"><b>Code *</b></td>
                <td><s:textfield id="province.code" name="province.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="province.name" name="province.name" cssStyle="width:30%" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Island *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        txtProvinceIslandCode.change(function(ev) {
                            
                            if(txtProvinceIslandCode.val()===""){
                                txtProvinceIslandName.val("");
                                return;
                            }
                            var url = "master/island-get-data";
                            var params = "island.code=" + txtProvinceIslandCode.val();
                                params+= "&island.activeStatus=TRUE";
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.islandTemp){
                                    txtProvinceIslandCode.val(data.islandTemp.code);
                                    txtProvinceIslandName.val(data.islandTemp.name);
                                }
                                else{
                                    alertMessage("Island Not Found!",txtProvinceIslandCode);
                                    txtProvinceIslandCode.val("");
                                    txtProvinceIslandName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="province.island.code" name="province.island.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="province_btnIsland" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="province.island.name" name="province.island.name" cssStyle="width:30%" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="provinceActiveStatusRad" name="provinceActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="province.activeStatus" name="province.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="province.remark" name="province.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="province.inActiveBy"  name="province.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="province.inActiveDate" name="province.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="province.createdBy"  name="province.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="province.createdDate" name="province.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="provinceTemp.inActiveDateTemp" name="provinceTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="provinceTemp.createdDateTemp" name="provinceTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnProvinceSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnProvinceCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>