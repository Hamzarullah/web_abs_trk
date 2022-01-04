
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
    #valveTypeComponentDetail_grid_pager_center{
        display: none;
    }    
</style>

<script type="text/javascript">
    var valveTypeComponent_lastRowId = 0, valveTypeComponent_lastSel = -1,valveTypeComponent_selectedLastSel=-1;
    var 
        txtValveTypeCode=$("#valveTypeComponent\\.code"),
        txtValveTypeName=$("#valveTypeComponent\\.name")
        
        allFieldsValveType=$([])
            .add(txtValveTypeCode)
            .add(txtValveTypeName);


    function reloadGridValveTypeComponent(){
        $("#valveTypeComponent_grid").trigger("reloadGrid");
        $("#valveTypeOfComponent_grid").trigger("reloadGrid");
        $("#valveTypeComponent_grid").jqGrid('clearGridData');
        $("#valveTypeOfComponent_grid").jqGrid('clearGridData');
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("valveTypeComponent");
        
        $('#valveTypeComponent\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#valveTypeComponentSearchActiveStatusRadActive').prop('checked',true);
        $("#valveTypeComponentSearchActiveStatus").val("true");
        
        $('input[name="valveTypeComponentSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#valveTypeComponentSearchActiveStatus").val(value);
        });
        
        $('input[name="valveTypeComponentSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#valveTypeComponentSearchActiveStatus").val(value);
        });
                
        $('input[name="valveTypeComponentSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#valveTypeComponentSearchActiveStatus").val(value);
        });
        
        $('input[name="valveTypeComponentActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#valveTypeComponent\\.activeStatus").val(value);
            $("#valveTypeComponent\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="valveTypeComponentActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#valveTypeComponent\\.activeStatus").val(value);
        });
        
        $.subscribe("valveTypeComponentInput_grid_onSelect", function() {
            var selectedRowID = $("#valveTypeComponentInput_grid").jqGrid("getGridParam", "selrow");
            valveTypeComponent_selectedLastSel=selectedRowID;
            if(selectedRowID!==valveTypeComponent_lastSel) {
                $('#valveTypeComponentInput_grid').jqGrid("saveRow",valveTypeComponent_lastSel); 
                $('#valveTypeComponentInput_grid').jqGrid("editRow",selectedRowID,true);            
                valveTypeComponent_lastSel=selectedRowID;
            }
            else{
                $('#valveTypeComponentInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
         $.subscribe("valveTypeOfComponent_grid_onSelect", function(event, data){
            var selectedRowID = $("#valveTypeOfComponent_grid").jqGrid("getGridParam", "selrow"); 
            var valveType = $("#valveTypeOfComponent_grid").jqGrid("getRowData", selectedRowID);
            
            $("#valveTypeComponent_grid").jqGrid("setGridParam",{url:"master/valve-type-component-detail-data?valveType.code="+ valveType.code});
            $("#valveTypeComponent_grid").jqGrid("setCaption", "VALVE TYPE - COMPONENT : " + valveType.code);
            $("#valveTypeComponent_grid").trigger("reloadGrid");
        });    
        
        $("#btnValveTypeComponentSave").click(function(ev) {
           if(!$("#frmValveTypeComponentInput").valid()) {
               ev.preventDefault();
               return;
           };
           
//           var url = "";
//           valveTypeComponentFormatDate();
           
           // Data valveTypecomponent From Grid to Save Database
            if(valveTypeComponent_lastSel !== -1) {
                $('#valveTypeComponentInput_grid').jqGrid("saveRow",valveTypeComponent_lastSel);
            }
            
            var listValveTypeComponentDetail = new Array();
            var ids = jQuery("#valveTypeComponentInput_grid").jqGrid('getDataIDs');
            
            if(ids.length===0){
                alertMessage("Data Valve Type Component Can't Empty!");
                return;
            }
            
            for(var i=0;i < ids.length;i++){
                var data = $("#valveTypeComponentInput_grid").jqGrid('getRowData',ids[i]);

                if(data.userBranchBranchCode === ""){
                    alertMessage("Valve Type Component Can't Empty! ");
                    return;
                }
                
                var valveTypeComponent = {
                    valveTypeComponent       : { code : data.valveTypeComponentCode }
                };
                listValveTypeComponentDetail[i] = valveTypeComponent;
            }
           
           var url = "master/valve-type-component-save";
           var params = $("#frmValveTypeComponentInput").serialize();
           params += "&listValveTypeComponentDetailJSON=" + $.toJSON(listValveTypeComponentDetail);
//           alert(params);
//           return;
            
           $.post(url, params, function(data) {
                if (data.error) {
//                    valveTypeComponentFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("valveTypeComponent");
                showInput("valveTypeComponentSearch");
                allFieldsValveType.val('').siblings('label[class="error"]').hide();
                txtValveTypeCode.val("AUTO");
                reloadGridValveTypeComponent();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnValveTypeComponentUpdate").click(function(ev){
            var selectRowId = $("#valveTypeOfComponent_grid").jqGrid('getGridParam','selrow');
            var valveType = $("#valveTypeOfComponent_grid").jqGrid("getRowData", selectRowId);
            
            var url = "master/valve-type-component-check";
            var params = "valveType.code=" + valveType.code;
            
            $.post(url, params, function(result) {
                var data = (result);
                    if (data.valveTypeComponentDetailTemp !== null){
                        var ValveType = data.valveTypeComponentDetailTemp.valveTypeCode;
                        alertMessage("Cannot update " + " (" + ValveType + ") " + "because it has been used on Item FinishGoods !!!");
                    }
            else{
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";
            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/valve-type-component-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                $("#valveTypeComponent_grid").jqGrid("clearGridData");
//                unHandlers_input_valveTypeComponent();
                updateRowId=$("#valveTypeOfComponent_grid").jqGrid("getGridParam","selrow");
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var valveTypeComponent=$("#valveTypeOfComponent_grid").jqGrid('getRowData',updateRowId);
                var url="master/valve-type-get-data";
                var params="valveType.code=" + valveTypeComponent.code;
                

                txtValveTypeCode.attr("readonly",true);
                txtValveTypeName.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtValveTypeCode.val(data.valveTypeTemp.code);
                        txtValveTypeName.val(data.valveTypeTemp.name);
                    });   
                showInput("valveTypeComponent");
                hideInput("valveTypeComponentSearch");
                valveTypeComponent_lastRowId=0;
                $("#valveTypeComponentInput_grid").jqGrid("clearGridData");
                valveTypeComponentLoadDetail(); 
            });
            });
           } 
//            ev.preventDefault();
        });
      });
      
        $("#btnValveTypeComponentCancel").click(function(ev) {
            hideInput("valveTypeComponent");
            showInput("valveTypeComponentSearch");
            $("#valveTypeComponentInput_grid").jqGrid("clearGridData");
            allFieldsValveType.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnValveTypeComponentRefresh').click(function(ev) {
            reloadGridValveTypeComponent();
        });
        
        $("#btnValveTypeComponentPrint").click(function(ev) {
            
            var url = "reports/valve-type-component-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'valveTypeComponent','width=500,height=500');
        });
        
        $('#btnValveTypeComponent_search').click(function(ev) {
            $("#valveTypeOfComponent_grid").jqGrid("clearGridData");
            $("#valveTypeOfComponent_grid").jqGrid("setGridParam",{url:"master/valve-type-data?" + $("#frmValveTypeComponentSearchInput").serialize()});
            $("#valveTypeOfComponent_grid").trigger("reloadGrid");
            $("#valveTypeComponent_grid").jqGrid("clearGridData");
            $("#valveTypeComponent_grid").jqGrid("setCaption", "VALVE TYPE - COMPONENT");
            ev.preventDefault();
        });
        
         $('#rack_btnvalveTypeComponent').click(function (ev) {
           window.open("./pages/search/search-valve-type-component-select.jsp?iddoc=valveTypeComponent&idsubdoc=valveTypeComponent&type=multi","Search", "width=600, height=500");
        });
    }); //EOF READY
    
    function valveTypeComponentInput_grid_Delete_OnClick(){
        var selectDetailRowId = $("#valveTypeComponentInput_grid").jqGrid('getGridParam','selrow');
        if (selectDetailRowId === null) {
            alertMessage("Please Select Row!");
            return;
        }
        $("#valveTypeComponentInput_grid").jqGrid('delRowData',selectDetailRowId);
    }
    
    
    function valveTypeComponentInput_grid_Code_OnChange(){
            var selectedRowID = $("#valveTypeComponentInput_grid").jqGrid("getGridParam", "selrow");
            var valveTypeComponentCode = $("#" + selectedRowID + "_valveTypeComponentCode").val();
            
            var url = "master/valve-type-component-get";
            var params = "valveTypeComponent.code=" + valveTypeComponentCode;
            params+="&valveTypeComponent.activeStatus=TRUE";
            
            if(valveTypeComponentCode===""){
                clearRowSelected(selectedRowID);
                return;
            }
           
            var idx = jQuery("#valveTypeComponentInput_grid").jqGrid('getDataIDs');
            for(var i=0;i<idx.length;i++){
                    for(var j=0;j<idx.length;j++){
                        if(i!==j){
                            var dataGridComponentCode = $("#valveTypeComponentInput_grid").jqGrid('getRowData',idx[j]);
                            if(valveTypeComponentCode===dataGridComponentCode.valveTypeComponentCode){                            
                                    alertMessage("Valve Type "+ valveTypeComponentCode +" has been exists in Grid!",$("#" + selectedRowID + "_valveTypeComponentCode"));
                                    $("#" + selectedRowID + "_valveTypeComponentCode").val("");
                                    clearRowSelected(selectedRowID);
                                    return;
                            }
                        }
                    }
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.valveTypeComponentTemp){
                    
                    if(data.valveTypeComponentTemp.code===txtValveTypeCode){
                        alertMessage("Valve Type Component Must be Different!",$("#" + selectedRowID + "_valveTypeComponentCode"));
                        clearRowSelected(selectedRowID);
                        return;
                    }
                    $("#valveTypeComponentInput_grid").jqGrid("setCell", selectedRowID,"valveTypeComponentCode",data.valveTypeComponentTemp.code);
                    $("#valveTypeComponentInput_grid").jqGrid("setCell", selectedRowID,"valveTypeComponentName",data.valveTypeComponentTemp.name);
                }
                else{
                    alertMessage("Valve Type Component Not Found!",$("#" + selectedRowID + "_valveTypeComponentCode"));
                    clearRowSelected(selectedRowID);
                }
            });
        }
        
        function addRowDataMultiSelectedValveTypeComponent(data){
            var ids = jQuery("#valveTypeComponentInput_grid").jqGrid('getDataIDs');
            var msg = '';
            var no=0;
            for (var i=0; i<data.length; i++) {
                var is_same= true;
                for(var a=0;a<ids.length;a++){
                    var dataTemp= $("#valveTypeComponentInput_grid").jqGrid('getRowData',ids[a]);
                    if(data[i].code == dataTemp.valveTypeComponentCode){
                        if(no==0){
                            msg += '<b>Data Has Already Exist.</b><br>';
                            msg += '<b>This data not assign to grid detail.</b><br><br>';
                        }
                        is_same= false;
                        no++;
                        msg += '&emsp;&emsp;'+no+'. '+data[i].code+'<br>'; 
                    }
                }
                if(is_same){
                    valveTypeComponent_lastRowId++;
                    $("#valveTypeComponentInput_grid").jqGrid("addRowData", valveTypeComponent_lastRowId, data[i]);
                    $("#valveTypeComponentInput_grid").jqGrid('setRowData',valveTypeComponent_lastRowId,{
                        valveTypeComponentDelete              : "delete",
                        valveTypeComponentCode                : data[i].code,
                        valveTypeComponentName                : data[i].name
                    });

                }
            }
            if(msg){
                alertMessage(msg,$("#valveTypeComponentCode"));                
            }
        }
        
        function valveTypeComponentLoadDetail() {
            var selectRowId = $("#valveTypeOfComponent_grid").jqGrid('getGridParam','selrow');
            var valveType = $("#valveTypeOfComponent_grid").jqGrid("getRowData", selectRowId); 
            
            var url = "master/valve-type-component-detail";
            var params = "valveTypeComponent.code=" + valveType.code;
//        alert(params);
            
            $.getJSON(url, params, function(data) {
                valveTypeComponent_lastRowId = 0;
                for (var i=0; i<data.listValveTypeComponentTemp.length; i++) {
                    valveTypeComponent_lastRowId++;
                    $("#valveTypeComponentInput_grid").jqGrid("addRowData", valveTypeComponent_lastRowId, data.listValveTypeComponentTemp[i]);
                    $("#valveTypeComponentInput_grid").jqGrid('setRowData',valveTypeComponent_lastRowId,{
                        valveTypeComponentDelete              : "delete",
                        valveTypeComponentCode                : data.listValveTypeComponentTemp[i].code,
                        valveTypeComponentName                : data.listValveTypeComponentTemp[i].name
                        
                    });
                }
//                }  calculateSalesQuotationDetail();
            });
    }
    
</script>
<s:url id="remoteurlValveTypeComponentInput" action="" />
<s:url id="remoteurlValveType" action="valve-type-data" />
<b>Valve Type Component</b>
<hr>
<br class="spacer"/>


<sj:div id="valveTypeComponentButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnValveTypeComponentUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td> <a href="#" id="btnValveTypeComponentRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnValveTypeComponentPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="valveTypeComponentSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmValveTypeComponentSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="valveTypeComponentSearchCode" name="valveTypeComponentSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="valveTypeComponentSearchName" name="valveTypeComponentSearchName" size="29"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="valveTypeComponentSearchActiveStatus" name="valveTypeComponentSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="valveTypeComponentSearchActiveStatusRad" name="valveTypeComponentSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnValveTypeComponent_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="valveTypeComponentGrid">
    
    <sjg:grid
        id="valveTypeOfComponent_grid"
        dataType="json"
        caption="Valve Type"
        href="%{remoteurlValveType}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listValveTypeTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="valveTypeOfComponent_grid_onSelect"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
        />
    </sjg:grid>
    
    <br class="spacer"/>
    
    <sjg:grid
        id="valveTypeComponent_grid"
        dataType="json"
        caption="Valve Type Component"
        href="%{remoteurlValveTypeComponent}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listValveTypeComponentDetailTemp"
        rowNum="10000"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        
    >
        <sjg:gridColumn
            name="valveTypeComponentCode" index="valveTypeComponentCode" key="valveTypeComponentCode" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="valveTypeName" index="valveTypeName" title="Name" width="300" sortable="true"
        />
    </sjg:grid>
    <style>
        #valveTypeComponent_grid_pager_center {display: none;}
    </style>
    
</div>
    
<div id="valveTypeComponentInput" class="content ui-widget">
    <s:form id="frmValveTypeComponentInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="valveTypeComponent.code" name="valveTypeComponent.code" title="*" required="true" cssClass="required" maxLength="45" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="valveTypeComponent.name" name="valveTypeComponent.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"></td>
                <td>
                    <sj:a href="#" id="rack_btnvalveTypeComponent" button="true" style="width: 90%">Search Valve Component</sj:a> 
                </td>
            </tr>
            
        </table>   
    </s:form>
    
    <br class="spacer"/>
    <table>
            <tr>
                <td>
                    <div id="valveTypeComponentInputGrid">
                        <sjg:grid
                            id="valveTypeComponentInput_grid"  
                            caption="VALVE TYPE - COMPONENT"
                            dataType="local"                    
                            pager="true"
                            navigator="false"
                            navigatorView="false"
                            navigatorRefresh="false"
                            navigatorDelete="false"
                            navigatorAdd="false"
                            navigatorEdit="false"
                            gridModel="listValveTypeComponent"
                            rowNum="10000"
                            viewrecords="true"
                            rownumbers="true"
                            shrinkToFit="false"
                            editinline="true"
                            editurl="%{remoteurlValveTypeComponentInput}"
                            onSelectRowTopics="valveTypeComponentInput_grid_onSelect"
                        >
                            <sjg:gridColumn
                                name="valveTypeCode" index="valveTypeCode" 
                                key="valveTypeCode" title="Code" editable="false" edittype="text" hidden="true"
                            />
                            <sjg:gridColumn
                                name="valveTypeComponentUserCode" index="valveTypeComponentUserCode" key="valveTypeComponentUserCode" hidden="true" title="UserCode" width="100"
                            />
                            <sjg:gridColumn
                                name="valveTypeComponentDelete" index="valveTypeComponentDelete" title="" width="50" align="centre"
                                editable="true"
                                edittype="button"
                                editoptions="{onClick:'valveTypeComponentInput_grid_Delete_OnClick()', value:'delete'}"
                            />
                            <sjg:gridColumn
                                name = "valveTypeComponentCode" index = "valveTypeComponentCode" key = "valveTypeComponentCode" title = "Code" width = "80"
                                editable="true"
                                editoptions="{onChange:'valveTypeComponentInput_grid_Code_OnChange()'}"
                            />
                            <sjg:gridColumn
                                name = "valveTypeComponentName" index = "valveTypeComponentName" key = "valveTypeComponentName" title = "Name" width = "250"
                            />
                        </sjg:grid >
                    </div>
                    <style>
                        #valveTypeComponentInput_grid_pager_center {display: none;}
                    </style>
                </td>
            </tr>
    </table>
    <table>
        <tr height="50">
            <td></td>
            <td>
                <sj:a href="#" id="btnValveTypeComponentSave" button="true">Save</sj:a>
                <sj:a href="#" id="btnValveTypeComponentCancel" button="true">Cancel</sj:a>
            </td>
        </tr> 
    </table>
           
</div>