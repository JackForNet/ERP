using System;
using System.Collections.Generic;
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

public partial class MasterPage : System.Web.UI.MasterPage
{
    private DataHandler dh = new DataHandler();
    //private List<NotificationData> notificationList = new List<NotificationData>();
    private AccountVO accountInfo = null;

    protected void Page_Load(object sender, EventArgs e)
    {
       accountInfo = WebHelper.GetSessionAccount();

        if (!IsPostBack)
        {
            BuildBrand();
            BuildNav();
            BuildTask();
            CheckExamine();
            if (accountInfo.Staff != null)
            {
                Name.Text = accountInfo.Staff.Name + "[" + CommonHelper.StaffNumberLength(accountInfo.Staff.Staff_Number) + "]";
            }
        }
    }

    private void BuildBrand()
    {
        StringBuilder html = new StringBuilder();
        CompanyVO company = dh.GetCompanyByID(accountInfo.Company_ID);
        if (company != null)
            html.Append("<a class=\"navbar-brand\">" + company.Company_Name + " - ERP系统</a>");
        else
            html.Append("<a class=\"navbar-brand\">ERP系统后台</a>");

        BrandLiteral.Text = html.ToString();
    }

    private void BuildTask()
    {
        StringBuilder html = new StringBuilder();
        List<TaskVO> collection = dh.GetTaskByAccount(accountInfo.Account_ID);
        foreach (TaskVO item in collection)
        {
            string workflowName = item.WorkFlow_Name + "(" + item.Create_Date.ToString("yyyy-MM-dd") + ")";
            //int process = 40;
            List<WorkFlowProcessVO> list = dh.GetWorkFlowProcess(item.WorkFlow_ID);
            string taskUrl = item.WorkFlow_Url + "?tid=" + WebHelper.Encrypt(item.Task_ID.ToString());
            string percent = getPercent(item.Sequence, list.Count);
            html.Append("<li>");
            html.Append("    <a href=\"" + taskUrl + "\">");
            html.Append("        <div>");
            html.Append("            <p>");
            html.Append("                <strong>" + workflowName + "</strong>");
            html.Append("                <span class=\"pull-right text-muted\">" + percent + "</span>");
            html.Append("            </p>");
            html.Append("            <div class=\"progress progress-striped active\">");
            html.Append("                <div class=\"progress-bar progress-bar-info\" role=\"progressbar\" aria-valuenow=\"" + percent.Replace("%", "") + "\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: " + percent + "\">");
            html.Append("                </div>");
            html.Append("            </div>");
            html.Append("        </div>");
            html.Append("    </a>");
            html.Append("</li>");
            html.Append("<li class=\"divider\"></li>");
        }

        TaskLiteral.Text = html.ToString();
    }

    private string getPercent(object A, object B)
    {
        double rate = new double();
        try
        {
            rate = Convert.ToDouble(A) / Convert.ToDouble(B);
            rate = rate > 1 ? 1 : rate;
        }
        catch (Exception)
        {
            return null;
        }
        return rate.ToString("p"); //格式为12.23%
    }

    private void BuildNav()
    {
        if (accountInfo.Type_ID.Equals((int)Config.AccountType.Admin))
        {
            task.Visible = false;

            Navigation.Controls.Clear();
            
            HtmlGenericControl purviewLi = new HtmlGenericControl("li");
            purviewLi.InnerHtml = "<a href=\"/system/purview.aspx\"><i class=\"fa fa-fw fa-gear \"></i> 权限管理</a>";
            Navigation.Controls.Add(purviewLi);

            HtmlGenericControl moduleLi = new HtmlGenericControl("li");
            moduleLi.InnerHtml = "<a href=\"/system/module.aspx\"><i class=\"fa fa-fw fa-windows \"></i> 模块管理</a>";
            Navigation.Controls.Add(moduleLi);

            HtmlGenericControl workFlowLi = new HtmlGenericControl("li");
            workFlowLi.InnerHtml = "<a href=\"/system/workflow.aspx\"><i class=\"fa fa-fw fa-list \"></i> 工作流管理</a>";
            Navigation.Controls.Add(workFlowLi);

            HtmlGenericControl holidayLi = new HtmlGenericControl("li");
            holidayLi.InnerHtml = "<a href=\"/system/holiday.aspx\"><i class=\"fa fa-fw fa-retweet \"></i> 节假日生成</a>";
            Navigation.Controls.Add(holidayLi);

            HtmlGenericControl templateLi = new HtmlGenericControl("li");
            templateLi.InnerHtml = "<a href=\"/system/template.aspx\"><i class=\"fa fa-fw fa-indent \"></i> 权限模板管理</a>";
            Navigation.Controls.Add(templateLi);
        }
        else
        {
            StaffVO staff = accountInfo.Staff;
            if (staff != null && staff.Status_ID == (int)Config.StaffStatus.Entry)
            {
                Navigation.Controls.Clear();
                HtmlGenericControl li = new HtmlGenericControl("li");
                li.InnerHtml = "<a href=\"/hr/entry.aspx\"><i class=\"fa fa-fw fa-sign-in\"></i> 入职登记表</a>";
                Navigation.Controls.Add(li);
                return;
            }

            //List<PositionPurviewVO> pp = accountInfo.PositionPurview;

            List<TemplatePurviewVO> pp = accountInfo.TemplatePurview;
            List<ModuleVO> list = WebHelper.GetModule();

            List<ModuleVO> selfModuleList = new List<ModuleVO>();//该用户拥有的模块列表
            List<ModuleGroupVO> modulegroup = new List<ModuleGroupVO>();//该用户拥有的一级菜单
            foreach (ModuleVO item in list)
            {
                if (pp.Exists(t => t.Module_ID.Equals(item.Module_ID) && t.Purview_ID.Equals((int)Config.Purview.View)))
                {
                    selfModuleList.Add(item);
                    if (!modulegroup.Exists(t => t.Group_Name.Equals(item.Group.Group_Name)))
                        modulegroup.Add(item.Group);
                }
            }
            
            foreach (ModuleGroupVO item in modulegroup)
            {
                HtmlGenericControl ul = new HtmlGenericControl("li");
                string sb = "<a href='#'>" + item.Group_Name + "<span class=\"fa arrow\"></span></a><ul class=\"nav nav-second-level collapse\">";

                List<ModuleVO> moduleList = selfModuleList.FindAll(t => t.Group_ID.Equals(item.Group_ID));
                foreach (ModuleVO module in moduleList)
                {
                    sb += "<li><a href=\"" + module.Module_Url + "\" ><i class=\"fa fa-fw " + module.Module_Icon + "\"></i> " + module.Module_Name + "</a></li>";
                }
                sb += "</ul>";
                ul.InnerHtml = sb;
                Navigation.Controls.Add(ul);
            }

            
        }

        
    }

    private void CheckExamine()
    {
        List<TaskVO> taskList = WebHelper.GetNotification();
        if (taskList != null && taskList.Count > 0)
        {
            string result = WebHelper.ShowNotification(taskList.First());
            Label label = new Label();
            label.Text = result;
            RadNotification1.ContentContainer.Controls.Add(label);
            RadNotification1.Show();
        }
    }


    //private void LoadDataInNotification(NotificationData notificationDataItem)
    //{
    //    RadNotification1.ContentIcon = notificationDataItem.EmbeddedContentIcon;
    //    RadNotification1.Text = notificationDataItem.NotificationText;
    //    RadNotification1.Value = notificationDataItem.NotificationTitle + "|" + notificationDataItem.EmbeddedTitleIcon;

    //    Label label = new Label();
    //    label.Text = notificationDataItem.NotificationText;

    //    RadNotification1.ContentContainer.Controls.Add(label);

    //    RadNotification1.Title = notificationDataItem.NotificationTitle;
    //    RadNotification1.TitleIcon = notificationDataItem.EmbeddedTitleIcon;

    //}

    //protected void RadNotification1_CallbackUpdate(object sender, RadNotificationEventArgs e)
    //{
        //if (notificationList.Count > 0)
        //{
        //    int currentNotificationIndex = Int32.TryParse(e.Value, out currentNotificationIndex) ? currentNotificationIndex : 0;
        //    LoadDataInNotification(notificationList[currentNotificationIndex]);
        //}
        //if (!string.IsNullOrEmpty(RadNotification1.Text))
        //    RadNotification1.Show();
    //}
}

//public class NotificationData
//{
//    public string EmbeddedTitleIcon;
//    public string NotificationTitle;
//    public string EmbeddedContentIcon;
//    public string NotificationText;

//    public NotificationData(string embeddedTitleIcon, string notificationTitle, string embeddedContentIcon, string notificationText)
//    {
//        this.EmbeddedTitleIcon = embeddedTitleIcon;
//        this.NotificationTitle = notificationTitle;
//        this.EmbeddedContentIcon = embeddedContentIcon;


//        StringBuilder content = new StringBuilder();
//        content.Append("<a href=\"" + embeddedContentIcon + "\">");
//        content.Append(notificationText);
//        content.Append("</a>");

//        this.NotificationText = content.ToString();
//    }
//}
