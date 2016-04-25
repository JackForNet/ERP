using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using ZhongLuan.ERP.Common;
using ZhongLuan.ERP.DAL;
using ZhongLuan.ERP.Entity;

public partial class Demo2 : System.Web.UI.Page
{
    private DataHandler dh = new DataHandler();
    private AccountVO account = null;
    private StaffVO staff = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        account = WebHelper.GetSessionAccount();
        staff = account.Staff;
    }

    protected void DataGrid_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        int total = 0;
        string Number = "";
        if (NumberTB.Text.Trim() != "")
            Number = NumberTB.Text;
        List<TaskVO> list = dh.GetTaskByAccount(account.Account_ID, Number, DataGrid.CurrentPageIndex, DataGrid.PageSize, out total);
        //List<TaskVO> list = dh.GetTaskByAccount(account.Account_ID, DataGrid.CurrentPageIndex, DataGrid.PageSize, out total);
        DataGrid.DataSource = list;
        DataGrid.VirtualItemCount = total;
    }

    protected void DataGrid_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        var editableItem = ((GridEditableItem)e.Item);
        var taskID = (int)editableItem.GetDataKeyValue("Task_ID");

        if (staff.Status_ID.Equals((int)Config.StaffStatus.OnJob) || staff.Status_ID.Equals((int)Config.StaffStatus.Active))
        {
            dh.DeleteTaskByID(taskID);

            TaskVO task = dh.GetTaskByID(taskID);

            WebHelper.CreateTaskLog(task);

            DataGrid.MasterTableView.Rebind();
        }
        else
        {
            RadWindowManager.RadAlert("目前状态不能撤销任务", 300, 200, "操作结果", null);
        }
    }
    protected void DataGrid_CancelCommand(object sender, GridCommandEventArgs e)
    {
        var editableItem = ((GridEditableItem)e.Item);
        var taskID = (int)editableItem.GetDataKeyValue("Task_ID");
        var url = (string)editableItem.GetDataKeyValue("WorkFlow_Url");
        string idStr = WebHelper.Encrypt(taskID.ToString());
        string linkUrl = url + "?tid=" + idStr;

        HttpContext.Current.Response.Redirect(linkUrl, true);
    }
    protected void DataGrid_DataBound(object sender, EventArgs e)
    {
        //foreach (GridDataItem item in DataGrid.MasterTableView.Items)
        //{
        //    TaskVO task = (TaskVO)item.DataItem;
        //    if (!task.IsFirst)
        //        item.Cells[item.Cells.Count - 1].Controls[0].Visible = false;
        //}
    }
    protected void SubmitBtn_Click(object sender, EventArgs e)
    {
        this.DataGrid.MasterTableView.Rebind();
    }
}