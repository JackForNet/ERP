using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZhongLuan.ERP.Entity;
using ZhongLuan.ERP.Common;
using ZhongLuan.ERP.DAL;
using Telerik.Web.UI;

public partial class Demo : System.Web.UI.Page
{
    private DataHandler dh = new DataHandler();
    private ZKDataHandler zkdh = new ZKDataHandler();
    private AccountVO newAccount = new AccountVO();
    private StaffVO newStaff = new StaffVO();

    private AccountVO account = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        AccountVO account = WebHelper.GetSessionAccount();

        if (!IsPostBack)
        {

            NameTB.Text = account.Staff.Name.ToString().Trim();
            GetDay();
            AreaCb();
        }

    }



    private void GetDay()
    {
        AccountVO account = WebHelper.GetSessionAccount();
        int companyID = account.Company_ID;
        DaysCB.Items.Clear();
        DaysCB.DataSource = dh.GetCompanyArea(companyID);
        DaysCB.DataBind();
    }


    private void AreaCb()
    {
        
    }

    public void Button1_Click(object sender, EventArgs e)
    {
        RadWindowManager.RadAlert("Demo", 300, 300, "演示", null);
        Server.Transfer("index.aspx");
    }
    protected void DaysCB_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        AccountVO account = WebHelper.GetSessionAccount();
        int companyID = account.Company_ID;
        AreaCB.Items.Clear();
        AreaCB.DataSource = dh.GetCompanyArea(companyID);
        AreaCB.DataBind();
    }


    protected void DataGrid_DeleteCommand(object sender,GridCommandEventArgs e)
    {

    }

    protected void DataGrid_CancelCommand(object sender, GridCommandEventArgs e)
    {

    }

    protected void DataGrid_NeedDataSource(object sender,GridNeedDataSourceEventArgs e)
    {

    }

    protected void DataGrid_DataBound(object sender, EventArgs e)
    {

    }
}