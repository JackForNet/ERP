using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using ZhongLuan.ERP.Common;
using ZhongLuan.ERP.DAL;
using ZhongLuan.ERP.Entity;

public partial class RedundancyHandler : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static SearchBoxData GetNameResults(SearchBoxContext context)
    {
        AccountVO account = WebHelper.GetSessionAccount();
        List<StaffVO> list = new List<StaffVO>();
        DataHandler dh = new DataHandler();

        string name = context.Text;
        int departmentID = 0;
        if (context.SelectedContextItem != null)
        {
            int.TryParse(context.SelectedContextItem.Key, out departmentID);
        }
        if (!string.IsNullOrEmpty(name))
             list = dh.GetStaffByNameStatus(account.Company_ID, departmentID, name, Config.StaffStatus.Quit);

        List<SearchBoxItemData> result = new List<SearchBoxItemData>();

        foreach (StaffVO item in list)
        {
            SearchBoxItemData itemData = new SearchBoxItemData();
            itemData.Text = item.Name;
            itemData.Value = item.Staff_ID.ToString();
            result.Add(itemData);
        }

        SearchBoxData res = new SearchBoxData();
        res.Items = result.ToArray();

        return res;
    }
}