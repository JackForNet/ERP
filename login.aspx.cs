using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZhongLuan.ERP.Common;
using ZhongLuan.ERP.DAL;
using ZhongLuan.ERP.Entity;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Write(SecurityHelper.Encrypt(Config.DataBase_Key,"server=114.80.208.228,26433;database=ZKTeco_GL38;user id=sa;pwd=zhongluan@2015;max pool size=512;"));
        Session.Clear();
    }

    protected void loginBtn_Click(object sender, EventArgs e)
    {
        string name = accountTB.Text.Trim();
        string password = passwordTB.Text.Trim();

        if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(password))
        {
            Response.Write("<script>alert('账号或密码不能为空');</script>");
            return;
        }

        password = FormsAuthentication.HashPasswordForStoringInConfigFile(password, "MD5");
        DataHandler dh = new DataHandler();
        AccountVO account = dh.GetAccount(name, password);

        if (account == null)
        {
            Response.Write("<script>alert('账号或密码错误');</script>");
            return;
        }

        int timeout = Convert.ToInt32(FormsAuthentication.Timeout.TotalMinutes);
        //DateTime now = DateTime.Now;
        //FormsAuthenticationTicket Ticket = new FormsAuthenticationTicket(1, name, now, now.AddMinutes(timeout), true, password);
        //string HashTicket = FormsAuthentication.Encrypt(Ticket);
        //HttpCookie UserCookie = new HttpCookie(FormsAuthentication.FormsCookieName, HashTicket);
        //FormsAuthentication.SetAuthCookie(FormsAuthentication.FormsCookieName, true);
        //Context.Response.Redirect(Context.Request["ReturnUrl"]); // 重定向到用户申请的初始页面

        //account.PositionPurview = dh.GetPositionPurview(account.Position_ID);
        account.Position = dh.GetPositionByID(account.Position_ID);
        int templateID = account.Position == null ? 0 : account.Position.Template_ID;
        account.TemplatePurview = dh.GetTemplatePurview(templateID);

        //Session.Timeout = timeout;
        Session[Config.Session_Account] = account;

        //生成Cookie
        HttpCookie cookie = new HttpCookie(Config.Cookie_Account);
        cookie.Values.Add(Config.Cookie_UserName, name);
        cookie.Values.Add(Config.Cookie_Password, password);
        cookie.Expires = DateTime.Now.AddMinutes(timeout);
        Response.Cookies.Add(cookie);

        //判断是否为管理员
        if (account.Type_ID.Equals((int)Config.AccountType.Admin))
        {
            Response.Redirect("/system/purview.aspx");
            return;
        }

        //更新考勤工号
        StaffVO staff = account.Staff;
        if (staff != null && staff.User_ID == 0)
        {
            ZKDataHandler zkdh = new ZKDataHandler();
            CompanyAreaVO area = dh.GetCompanyAreaByID(staff.Area_ID);
            int userID = zkdh.GetUserIDByNumber(staff.Badge_Number, area.DataBase_Name);
            dh.UpdateStaffUserID(staff.Staff_ID, userID);
            account.Staff.User_ID = userID;
            Session[Config.Session_Account] = account;
        }

        //判断是否为入职
        if (staff != null && staff.Status_ID == (int)Config.StaffStatus.Entry)
        {
            Response.Redirect("/hr/entry.aspx");
        }
        else
        {
            Response.Redirect("index.aspx");
        }
    }
}