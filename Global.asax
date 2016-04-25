<%@ Application Language="C#" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="ZhongLuan.ERP.Common" %>
<%@ Import Namespace="ZhongLuan.ERP.Entity" %>

<script runat="server">

    protected void Application_AuthenticateRequest(Object sender, EventArgs e)
    {
        HttpApplication app = (HttpApplication)sender;
        HttpContext ctx = app.Context; //获取本次Http请求相关的HttpContext对象

        if (ctx.Request.CurrentExecutionFilePathExtension != ".aspx")
        {
            return;
        }
        if (ctx.Request.Path == "/error.aspx" || ctx.Request.Path == "/login.aspx")
        {
            return;
        }

        //AccountVO account = WebHelper.GetSessionAccount();
        //if (account == null)
        //{
        //    ctx.Response.Redirect(FormsAuthentication.LoginUrl, true);
        //}

        //if (ctx.Request.IsAuthenticated) //验证过的用户才进行role的处理
        //{
        //    FormsIdentity Id = (FormsIdentity)ctx.User.Identity;
        //    FormsAuthenticationTicket Ticket = Id.Ticket; //取得身份验证票
        //    string[] Roles = Ticket.UserData.Split(','); //将身份验证票中的role数据转成字符串数组
        //    ctx.User = new GenericPrincipal(Id, Roles); //将原有的Identity加上角色信息新建一个GenericPrincipal表示当前用户,这样当前用户就拥有了role信息
        //}
        //else if (ctx.Request.Path != FormsAuthentication.LoginUrl)
        //{
        //    ctx.Response.Redirect(FormsAuthentication.LoginUrl, true);
        //}
    }

    void Application_Start(object sender, EventArgs e) 
    {
        // 在应用程序启动时运行的代码

    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  在应用程序关闭时运行的代码

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // 在出现未处理的错误时运行的代码
        
        // 本地调试
        HttpApplication app = (HttpApplication)sender;
        HttpContext ctx = app.Context;
        if (ctx.Request.Url.Host.Equals("localhost"))
        {
            return;
        }
        
        Exception ex = Server.GetLastError();
        if (ex is HttpException)
        {
            int code = ((HttpException)ex).GetHttpCode();
            if (code == 404)
            {
                Server.Transfer("/index.aspx", false);
            }
            else
            {
                Server.Transfer("/error.aspx", false);
            }
        }
        else
        {
            Server.Transfer("/error.aspx", false);
        }
    }

    void Session_Start(object sender, EventArgs e) 
    {
        // 在新会话启动时运行的代码

    }

    void Session_End(object sender, EventArgs e) 
    {
        // 在会话结束时运行的代码。 
        // 注意: 只有在 Web.config 文件中的 sessionstate 模式设置为
        // InProc 时，才会引发 Session_End 事件。如果会话模式设置为 StateServer
        // 或 SQLServer，则不引发该事件。

    }
       
</script>
