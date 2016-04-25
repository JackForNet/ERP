<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Demo.aspx.cs" Inherits="Demo" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="ContentCPH" runat="server">
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager runat="server" ID="RadWindowManager">
    </telerik:RadWindowManager>
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Button1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="successLabel"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="failureLabel"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="formPane" LoadingPanelID="RadAjaxLoadingPanel"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="DataGrid" LoadingPanelID="RadAjaxLoadingPanel" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="DetailWindow">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="DetailWindow" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="DataGrid">
                <UpdatedControls>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <telerik:RadWindow runat="server" ID="DetailWindow" Modal="true" Behaviors="Close" Title="员工信息" Visible="false" VisibleOnPageLoad="true"
        ReloadOnShow="true" ShowContentDuringLoad="false" AutoSize="true" VisibleStatusbar="false">
    </telerik:RadWindow>

    <div class="row">
        <div class="col-lg-12">

            <%--bootstrap--%>
            <h1 class="page-header"><i class="fa fa-fw fa-tasks"></i>样式模本</h1>
        </div>

    </div>

    <div class="demo-container size-thin">
        <telerik:RadButton RenderMode="Lightweight" ID="Button1" runat="server" Text="Get Checked Items!" OnClick="Button1_Click" />
        <p>
            <strong>Checked Items:</strong><br />
            <asp:Literal ID="itemsClientSide" runat="server" />
        </p>

    </div>

    <%--    <div class="col-lg-12">
        <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="RadTextBox1"></telerik:RadTextBox>

        <%--<telerik:RadLabel runat="server" ID="RadLabel2" AssociatedControlID="RadTextBox2" Text="Email " RequiredMark="*" MarkDisplayMode="Required"></telerik:RadLabel>--%>

    <%--    <telerik:RadTextBox RenderMode="Lightweight" runat="server" ID="RadTextBox2"></telerik:RadTextBox>

        <%--<telerik:RadLabel runat="server" Text="Date of birth" Width="100px" ID="RadLabel4" AssociatedControlID="RadDatePicker1"></telerik:RadLabel>--%>

    <%--<telerik:RadDatePicker runat="server" ID="RadDatePicker1"></telerik:RadDatePicker>--%>

    <%--<telerik:RadCheckBox runat="server" ID="RadCheckBox1" AutoPostBack="false">
        </telerik:RadCheckBox>--%>--%>


    <asp:Panel ID="formPane" runat="server" CssClass="max-width-500">
        <div class="row">
            <div class="col-lg-12 max-width-800">
                <div class="panel panel-default">
                    <div class="panel-heading"><i class="fa fa-edit fa-fw"></i>销假信息</div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-6 col-sm-6">
                                <div class="form-group">
                                    <telerik:RadTextBox ID="NameTB" runat="server" Label="姓名" MaxLength="20" Width="100%" WrapperCssClass="input-block" ReadOnly="true">
                                    </telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="col-lg-6 col-sm-6">
                                <div class="form-group">
                                    <telerik:RadTextBox ID="DepartmentTB" runat="server" Label="部门" MaxLength="20" Width="100%" WrapperCssClass="input-block" ReadOnly="true" Text="IT部">
                                    </telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="col-lg-6 col-sm-6">
                                <div class="form-group">
                                    <telerik:RadTextBox ID="PositionTB" runat="server" Label="职位" MaxLength="20" Width="100%" WrapperCssClass="input-block" ReadOnly="true" Text="程序员">
                                    </telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="col-lg-6 col-sm-6">
                                <div class="form-group">
                                    <telerik:RadComboBox ID="DaysCB" DataValueField="Area_ID" OnSelectedIndexChanged="DaysCB_SelectedIndexChanged" DataTextField="Area_Name" runat="server" Label="天数种类" CssClass="select-block" EmptyMessage="请选择" Width="100%" AutoPostBack="true">
                                    </telerik:RadComboBox>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">
                                    <telerik:RadComboBox ID="AreaCB" runat="server" Label="考勤区域" EmptyMessage="请选择" Width="100%"
                                        CssClass="select-block" DataTextField="Area_Name" DataValueField="Area_ID">
                                    </telerik:RadComboBox>
                                </div>
                            </div>
                            <div class="col-lg-6 col-sm-6">
                                <div class="form-group">
                                    <telerik:RadTextBox ID="DaysTB" runat="server" Label="销假天数" MaxLength="20" Width="100%" WrapperCssClass="input-block" ReadOnly="true">
                                    </telerik:RadTextBox>
                                </div>
                            </div>
                            <div class="col-lg-6 col-sm-6">
                                <div class="form-group">
                                    <label runat="server" id="StartDayLabel">销假日期</label>
                                    <telerik:RadDatePicker ID="StartDayDP" runat="server" Width="100%" DateInput-DisplayDateFormat="yyyy-MM-dd" AutoPostBack="true">
                                    </telerik:RadDatePicker>
                                </div>
                            </div>
                            <div class="col-lg-6 col-sm-6" runat="server" visible="false" id="EndDayDiv">
                                <div class="form-group">
                                    <label runat="server" id="EndDayLabel">结束日期</label>
                                    <telerik:RadDatePicker ID="EndDayDP" runat="server" Width="100%" DateInput-DisplayDateFormat="yyyy-MM-dd" AutoPostBack="true">
                                    </telerik:RadDatePicker>
                                </div>
                            </div>

                            <div class="col-lg-12 col-sm-12">
                                <div class="form-group">
                                    <telerik:RadTextBox ID="ReasonTB" runat="server" Label="销假原因" Width="100%" WrapperCssClass="input-block" TextMode="MultiLine">
                                    </telerik:RadTextBox>

                                </div>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--<div class="row">
            <div class="col-lg-12">
                <div class="dataTable_wrapper">
                    <telerik:RadGrid ID="DataGrid" runat="server" AllowPaging="true" AllowSorting="true" AllowCustomPaging="true"
                        OnNeedDataSource="DataGrid_NeedDataSource" LoadingPanelID="RadAjaxLoadingPanel" AutoGenerateColumns="false"
                        AllowAutomaticUpdates="True" AllowAutomaticDeletes="true" OnDataBound="DataGrid_DataBound"
                        OnDeleteCommand="DataGrid_DeleteCommand" OnCancelCommand="DataGrid_CancelCommand">
                        <MasterTableView DataKeyNames="Task_ID, WorkFlow_Url" NoMasterRecordsText="暂无数据">
                            <Columns>
                                <telerik:GridBoundColumn DataField="Number" HeaderText="任务编号"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="User_Name" HeaderText="姓名"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="WorkFlow_Name" HeaderText="任务名称"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Status_Name" HeaderText="状态"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Remarks" HeaderText="驳回理由"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Create_Date" HeaderText="创建日期"></telerik:GridBoundColumn>

                                <telerik:GridButtonColumn ButtonCssClass="btn btn-primary" ButtonType="PushButton" CommandName="Cancel" Text="查看详情"
                                    UniqueName="ResetColumn" Visible="true" />

                                <telerik:GridButtonColumn ConfirmText="是否确认撤回该任务？" ButtonCssClass="btn btn-danger" ConfirmDialogType="RadWindow"
                                    ConfirmTitle="撤回" ButtonType="PushButton" CommandName="Delete" Text="撤回" ConfirmDialogWidth="300" UniqueName="DeleteColumn" Visible="true" />
                            </Columns>
                        </MasterTableView>
                        <PagerStyle FirstPageToolTip="首页" PrevPageToolTip="上一页" NextPageToolTip="下一页" LastPageToolTip="尾页" PrevPagesToolTip="前10页" NextPagesToolTip="后10页"
                            PageSizeLabelText="每页显示数" PagerTextFormat="{4}共 <strong>{5}</strong> 条数据" />
                    </telerik:RadGrid>
                </div>

                <!-- /.col-lg-12 -->
            </div>
        </div>--%>
    </asp:Panel>

    <%--<asp:Button ID="btnSubmit" Text="确 定" runat="server" CssClass="btn btn-primary " OnClick="btnSubmit_Click"></asp:Button>--%>
</asp:Content>
