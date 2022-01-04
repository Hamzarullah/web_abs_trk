
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
        txtPartCode=$("#part\\.code"),
        txtPartName=$("#part\\.name"),
        txtPartOfMeasureCode=$("#part\\.unitOfMeasure\\.code"),
        txtPartOfMeasureName=$("#part\\.unitOfMeasure\\.name"),
        rdbPartActiveStatus=$("#part\\.activeStatus"),
        txtPartRemark=$("#part\\.remark"),
        txtPartInActiveBy = $("#part\\.inActiveBy"),
        dtpPartInActiveDate = $("#part\\.inActiveDate"),
        txtPartCreatedBy = $("#part\\.createdBy"),
        dtpPartCreatedDate = $("#part\\.createdDate"),
        
        allFieldsPart=$([])
            .add(txtPartCode)
            .add(txtPartName)
            .add(txtPartRemark)
            .add(txtPartInActiveBy)
            .add(txtPartCreatedBy);


    function reloadGridPart(){
        $("#part_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("part");
        
        $('#part\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#partSearchActiveStatusRadActive').prop('checked',true);
        $("#partSearchActiveStatus").val("true");
        
        $('input[name="partSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#partSearchActiveStatus").val(value);
        });
        
        $('input[name="partSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#partSearchActiveStatus").val(value);
        });
                
        $('input[name="partSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#partSearchActiveStatus").val(value);
        });
        
        //rdb active Status
        $('input[name="partActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#part\\.activeStatus").val(value);
            $("#part\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="partActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#part\\.activeStatus").val(value);
        });
        
        //rdb processed Status
        $('input[name="partProcessedStatusRad"][value="MACHINING"]').change(function(ev){
            var value="MACHINING";
            $("#part\\.processedStatus").val(value);
        });
                
        $('input[name="partProcessedStatusRad"][value="NON_MACHINING"]').change(function(ev){
            var value="NON_MACHINING";
            $("#part\\.processedStatus").val(value);
        });
        
        $("#btnPartNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/part-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_part();
                showInput("part");
                hideInput("partSearch");
                $('#partActiveStatusRadActive').prop('checked',true);
                $("#part\\.activeStatus").val("true");
                $('#partProcessedStatusRadMACHINING').prop('checked',true);
                $("#part\\.processedStatus").val("MACHINING");
                $("#part\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#part\\.createdDate").val("01/01/1900 00:00:00");
//                txtPartCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtPartCode.val("AUTO");
                txtPartCode.attr("readonly",true);
                
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnPartSave").click(function(ev) {
           if(!$("#frmPartInput").valid()) {
//               handlers_input_part();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           partFormatDate();
           if (updateRowId < 0){
               url = "master/part-save";
           } else{
               url = "master/part-update";
           }
           
           var params = $("#frmPartInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    partFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("part");
                showInput("partSearch");
                allFieldsPart.val('').siblings('label[class="error"]').hide();
                txtPartCode.val("AUTO");
                reloadGridPart();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnPartUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/part-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_part();
                updateRowId=$("#part_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var part=$("#part_grid").jqGrid('getRowData',updateRowId);
                var url="master/part-get-data";
                var params="part.code=" + part.code;

                txtPartCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtPartCode.val(data.partTemp.code);
                        txtPartName.val(data.partTemp.name);
                        rdbPartActiveStatus.val(data.partTemp.activeStatus);
                        txtPartRemark.val(data.partTemp.remark);
                        txtPartInActiveBy.val(data.partTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.partTemp.inActiveDate,true);
                        dtpPartInActiveDate.val(inActiveDate);
                        txtPartCreatedBy.val(data.partTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.partTemp.createdDate,true);
                        dtpPartCreatedDate.val(createdDate);

                        if(data.partTemp.activeStatus===true) {
                           $('#partActiveStatusRadActive').prop('checked',true);
                           $("#part\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#partActiveStatusRadInActive').prop('checked',true);              
                           $("#part\\.activeStatus").val("false");
                        }

                        showInput("part");
                        hideInput("partSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnPartDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/part-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#part_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var part=$("#part_grid").jqGrid('getRowData',deleteRowID);
                var url="master/part-delete";
                var params="part.code=" + part.code;
                var message="Are You Sure To Delete(Code : "+ part.code + ")?";
                alertMessageDelete("part",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ part.code+ ')?</div>');
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
//                                var url="master/part-delete";
//                                var params="part.code=" + part.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridPart();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + part.code+ ")")){
//                    var url="master/part-delete";
//                    var params="part.code=" + part.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridPart();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnPartCancel").click(function(ev) {
            hideInput("part");
            showInput("partSearch");
            allFieldsPart.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnPartRefresh').click(function(ev) {
            $('#partSearchActiveStatusRadActive').prop('checked',true);
            $("#partSearchActiveStatus").val("true");
            $("#part_grid").jqGrid("clearGridData");
            $("#part_grid").jqGrid("setGridParam",{url:"master/part-data?"});
            $("#part_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnPartPrint").click(function(ev) {
            
            var url = "reports/part-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'part','width=500,height=500');
        });
        
        $('#btnPart_search').click(function(ev) {
            $("#part_grid").jqGrid("clearGridData");
            $("#part_grid").jqGrid("setGridParam",{url:"master/part-data?" + $("#frmPartSearchInput").serialize()});
            $("#part_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_part(){
//        unHandlersInput(txtPartCode);
//        unHandlersInput(txtPartName);
//    }
//
//    function handlers_input_part(){
//        if(txtPartCode.val()===""){
//            handlersInput(txtPartCode);
//        }else{
//            unHandlersInput(txtPartCode);
//        }
//        if(txtPartName.val()===""){
//            handlersInput(txtPartName);
//        }else{
//            unHandlersInput(txtPartName);
//        }
//    }
    
    function partFormatDate(){
        var inActiveDate=formatDate(dtpPartInActiveDate.val(),true);
        dtpPartInActiveDate.val(inActiveDate);
        $("#partTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpPartCreatedDate.val(),true);
        dtpPartCreatedDate.val(createdDate);
        $("#partTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlPart" action="part-data" />
<b>PART</b>
<hr>
<br class="spacer"/>


<sj:div id="partButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnPartNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnPartUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnPartDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnPartRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnPartPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="partSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmPartSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="partSearchCode" name="partSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="partSearchName" name="partSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="partSearchActiveStatus" name="partSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="partSearchActiveStatusRad" name="partSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnPart_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="partGrid">
    <sjg:grid
        id="part_grid"
        dataType="json"
        href="%{remoteurlPart}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listPartTemp"
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
    
<div id="partInput" class="content ui-widget">
    <s:form id="frmPartInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="part.code" name="part.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="part.name" name="part.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Unit Of Measure *</B></td>
                <td>
                    <script type = "text/javascript">
                    $('#part_btnUnitOfMeasure').click(function(ev) {
                        window.open("./pages/search/search-unit-of-measure.jsp?iddoc=part&idsubdoc=unitOfMeasure","Search", "width=600, height=500");
                    });
                    txtPartOfMeasureCode.change(function(ev) {
//                        alert(txtPartOfMeasureCode.val());
                        if(txtPartOfMeasureCode.val()===""){
                            txtPartOfMeasureName.val("");
                            return;
                        }

                        var url = "master/unit-of-measure-get";
                        var params = "unitOfMeasure.code=" + txtPartOfMeasureCode.val();
                            params += "&unitOfMeasure.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.unitOfMeasureTemp){
                                txtPartOfMeasureCode.val(data.unitOfMeasureTemp.code);
                                txtPartOfMeasureName.val(data.unitOfMeasureTemp.name);
                            }
                            else{
                                alertMessage("UOM Not Found!",txtPartOfMeasureCode);
                                txtPartOfMeasureCode.val("");
                                txtPartOfMeasureCode.val("");
                            }
                        });
                    });
                    </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="part.unitOfMeasure.code" name="part.unitOfMeasure.code" title=" " required="true" cssClass="required" size="25"></s:textfield>
                            <sj:a id="part_btnUnitOfMeasure" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                    <s:textfield id="part.unitOfMeasure.name" name="part.unitOfMeasure.name" size="50" readonly="true"></s:textfield> 
                </td>
            </tr>
            <tr>
                <td align="right"><B>Processed Status *</B></td>
                <td colspan="2">
                    <s:radio id="partProcessedStatusRad" name="partProcessedStatusRad" list="{'MACHINING','NON_MACHINING'}"></s:radio>
                    <s:textfield id="part.processedStatus" name="part.processedStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="partActiveStatusRad" name="partActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="part.activeStatus" name="part.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="part.remark" name="part.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="part.inActiveBy"  name="part.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="part.inActiveDate" name="part.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="part.createdBy"  name="part.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="part.createdDate" name="part.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="partTemp.inActiveDateTemp" name="partTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="partTemp.createdDateTemp" name="partTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnPartSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnPartCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>