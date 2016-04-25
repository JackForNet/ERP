using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using ZhongLuan.ERP.Common;
using ZhongLuan.ERP.DAL;
using ZhongLuan.ERP.Entity;

public partial class index : System.Web.UI.Page
{
    private DataHandler dh = new DataHandler();
    private AccountVO account = null;
    private StaffVO staff = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        account = WebHelper.GetSessionAccount();
        staff = account.Staff;

        if (staff.Status_ID == (int)Config.StaffStatus.Entry)
        {
            Response.Redirect("/hr/entry.aspx", true);
            return;
        }

        if (!IsPostBack)
        {
            // Show Bank Card Window
            if (staff != null)
                BankCardWindow.VisibleOnPageLoad = string.IsNullOrEmpty(staff.BankCard);

            if (WebHelper.CheckPurview(Config.Staff_Module, Config.Purview.Chart, false))
            {
                InitPage();
            }

            //if (WebHelper.CheckPurview(Config.Item_Module, Config.Purview.Chart))
            //{
            //    BarChartInit();
            //}

            if (WebHelper.CheckPurview(Config.Self_Attendance, Config.Purview.View, false))
            {
                attendanceDiv.Visible = true;
            }
            TaskLogInit();
            NoticeInit();
        }
    }

    protected void TaskLogInit()
    {
        StringBuilder html = new StringBuilder();
        List<TaskLogVO> logList = dh.GetTop10LogByAccount(account.Account_ID);

        if (logList.Count > 0)
        {
            foreach (TaskLogVO item in logList)
            {
                string createDate = item.Create_Date.ToString();
                string taskStatus = GetTaskStatus(item.Task_Status);
                string comment = item.Operat_Name + "操作了" + item.Process_Name + "(" + item.Inform_Name + "提交的" + item.WorkFlow_Name + ")<span class=\"log-status\">任务状态：" + taskStatus + "</span>";

                html.Append("<a class=\"list-group-item\">");
                html.Append("   <i class=\"fa fa-comment fa-fw\"></i> " + comment + "");
                html.Append("   <span class=\"log-time text-muted small\">");
                html.Append("       <em>" + createDate + "</em>");
                html.Append("   </span>");
                html.Append("</a>");
            }

            TaskLogLiteral.Text = html.ToString();
        }
        else
        {
            taskLogDiv.Visible = false;
        }

        
    }

    protected void NoticeInit()
    {
        //StringBuilder html = new StringBuilder();
        //NoticeVO notice = dh.GetTop1NoticeByDepartment(account.Department_ID, Config.NoticeRelationStatus.Active);

        //if (notice != null)
        //{
        //    html.Append("<div class=\"timeline-panel\">");
        //    html.Append("   <div class=\"timeline-heading\">");
        //    html.Append("       <h4 class=\"timeline-title\">" + notice.Title + "</h4>");
        //    html.Append("   </div>");
        //    html.Append("   <div class=\"timeline-body\">");
        //    html.Append("       <p>" + notice.Substance + "</p>");
        //    html.Append("   </div>");
        //    html.Append("</div>");
            
        //    NoticeLiteral.Text = html.ToString();
        //}
        //else
        //{
        //    noticeDiv.Visible = false;
        //}
    }

    protected string GetTaskStatus(int status)
    {
        string taskStatus = "执行中";
        switch (status)
        {
            case 1:
                taskStatus = "执行中";
                break;
            case 2:
                taskStatus = "完成";
                break;
            case 3:
                taskStatus = "驳回";
                break;
            case 4:
                taskStatus = "撤销";
                break;
        }

        return taskStatus;
    }

    //protected void BarChartInit()
    //{
    //    barDivChart.Visible = true;
    //    List<ItemStorageVO> itemStorageList = dh.GetStorage();
    //    List<ItemVO> itemList = dh.GetItems();
    //    List<Object> dataSource = new List<object>();
    //    foreach (ItemVO item in itemList)
    //    {
    //        item.inventories = itemStorageList.FindAll(delegate(ItemStorageVO isvo) { return isvo.Item_ID.Equals(item.Item_ID) && isvo.Quantity < 0; }).Sum(delegate(ItemStorageVO isvo) { return isvo.Quantity; }) * -1;
    //        item.intos = itemStorageList.FindAll(delegate(ItemStorageVO isvo) { return isvo.Item_ID.Equals(item.Item_ID) && isvo.Quantity > 0; }).Sum(delegate(ItemStorageVO isvo) { return isvo.Quantity; });

    //        dataSource.Add(new { Value1 = item.intos, Value2 = item.inventories, Item = item.Item_Name });
    //    }

    //    BarChart.DataSource = dataSource;
    //    BarChart.DataBind();
    //}

    protected void InitPage()
    {
        pieChart.Visible = true;
        List<DepartmentVO> deptList = dh.GetDepartmentStaffCount(account.Company_ID);
        PieSeries pieSeries = (PieSeries)PieChart1.PlotArea.Series[0];

        int i = 0;
        foreach (DepartmentVO depart in deptList)
        {
            PieSeriesItem psItem = new PieSeriesItem();
            psItem.Name = depart.Department_Name;
            psItem.Y = depart.Staff_Count;
            psItem.BackgroundColor = GetColor(i);
            psItem.Exploded = false;
            pieSeries.SeriesItems.Add(psItem);
            i++;
        }
    }

    protected System.Drawing.Color GetColor(int DepartmentID)
    {
        System.Drawing.Color bgColor = System.Drawing.Color.Black;
        switch (DepartmentID)
        {
            case 1:
                bgColor = System.Drawing.Color.Red;
                break;
            case 2:
                bgColor = System.Drawing.Color.Purple;
                break;
            case 3:
                bgColor = System.Drawing.Color.Pink;
                break;
            case 4:
                bgColor = System.Drawing.Color.Violet;
                break;
            case 5:
                bgColor = System.Drawing.Color.Tomato;
                break;
            case 6:
                bgColor = System.Drawing.Color.SteelBlue;
                break;
            case 7:
                bgColor = System.Drawing.Color.OliveDrab;
                break;
            case 8:
                bgColor = System.Drawing.Color.Orange;
                break;
            case 9:
                bgColor = System.Drawing.Color.PaleGreen;
                break;
            case 10:
                bgColor = System.Drawing.Color.Peru;
                break;
            case 11:
                bgColor = System.Drawing.Color.Plum;
                break;
            case 12:
                bgColor = System.Drawing.Color.SandyBrown;
                break;
            case 13:
                bgColor = System.Drawing.Color.AliceBlue;
                break;
            case 14:
                bgColor = System.Drawing.Color.Black;
                break;
            case 15:
                bgColor = System.Drawing.Color.CornflowerBlue;
                break;
            case 16:
                bgColor = System.Drawing.Color.Indigo;
                break;
            default:
                bgColor = System.Drawing.Color.YellowGreen;
                break;
        }

        return bgColor;
    }

    protected void SubmitBtn_Click(object sender, EventArgs e)
    {
        string bankCard = bankCardTB.Text.Trim();
        if (string.IsNullOrEmpty(bankCard))
        {
            ErrorMsg.Text = "工资卡号不能为空";
            ErrorMsg.Visible = true;
            return;
        }
        if (bankCard.Length != 19)
        {
            ErrorMsg.Text = "工资卡号无效";
            ErrorMsg.Visible = true;
            return;
        }

        dh.UpdateStaffBankCard(staff.Staff_ID, bankCard);
        ErrorMsg.Visible = false;
        BankCardWindow.Visible = false;

        account.Staff.BankCard = bankCard;
        Session[Config.Session_Account] = account;

        RadWindowManager1.RadAlert("操作成功", 200, 180, "提示", "");
    }

    protected void AttendanceRS_DataBinding(object sender, EventArgs e)
    {
        if (attendanceDiv.Visible)
        {
            DateTime start = AttendanceRS.VisibleRangeStart;
            DateTime end = AttendanceRS.VisibleRangeEnd;
            AttendanceRS.DataSource = WebHelper.GetAttendance(account.Account_ID, start, end);
        }
    }

    protected void RadDataForm_NeedDataSource(object sender, Telerik.Web.UI.RadDataFormNeedDataSourceEventArgs e)
    {
        RadDataForm.DataSource = dh.GetNoticeDetailsByDepartment(account.Department_ID, Config.NoticeRelationStatus.Active, 0, 5);
    }
}