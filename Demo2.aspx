<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Demo2.aspx.cs" Inherits="Demo2" %>

<%--<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="ContentCPH" runat="server">
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager runat="server" ID="RadWindowManager">
    </telerik:RadWindowManager>
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Button1">
                <UpdatedControls>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="DetailWindow">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="DetailWindow" />
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="DataGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl LoadingPanelID="RadAjaxLoadingPanel" ControlID="DataGrid" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <asp:Panel ID="formPane" runat="server" CssClass="max-width-500">
        <div class="row">
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
        </div>
    </asp:Panel>
</asp:Content>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentCPH" runat="Server">
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager runat="server" ID="RadWindowManager">
    </telerik:RadWindowManager>
    <telerik:RadAjaxManager ID="RadAjaxManager" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="DataGrid">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="DataGrid" LoadingPanelID="RadAjaxLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="SubmitBtn">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="DataGrid" LoadingPanelID="RadAjaxLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"><i class="fa fa-fw fa-tasks"></i>任务列表</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->




    <div class="row">
        <div class="col-lg-12 max-width-1200">
            <div class="panel panel-default">
                <div class="panel-heading"><i class="fa fa-edit fa-fw"></i>员工筛选查询</div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-3 col-sm-6">
                            <div class="form-group">
                                <telerik:RadTextBox ID="NumberTB" runat="server" Label="任务编号" MaxLength="20" Width="100%" WrapperCssClass="input-block">
                                </telerik:RadTextBox>
                            </div>
                        </div>
                        <div class="col-lg-12 col-sm-12">
                            <div class="form-group">
                                <asp:LinkButton ID="SubmitBtn" runat="server" OnClick="SubmitBtn_Click" CssClass="btn btn-primary"><i class="fa fa-fw fa-search"></i> 查询</asp:LinkButton>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>



    <div class="row">
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

                            <%--<telerik:GridTemplateColumn >
                                <ItemTemplate>
                                    <asp:Button ID="deleteButton" CommandName="Delete" Text="撤回" CssClass="btn btn-danger" runat="server"/>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>--%>
                        </Columns>
                    </MasterTableView>
                    <PagerStyle FirstPageToolTip="首页" PrevPageToolTip="上一页" NextPageToolTip="下一页" LastPageToolTip="尾页" PrevPagesToolTip="前10页" NextPagesToolTip="后10页"
                        PageSizeLabelText="每页显示数" PagerTextFormat="{4}共 <strong>{5}</strong> 条数据" />
                </telerik:RadGrid>
            </div>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
</asp:Content>
