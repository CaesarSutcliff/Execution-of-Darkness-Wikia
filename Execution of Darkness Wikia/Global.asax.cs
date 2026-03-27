using System;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using Execution_of_Darkness_Wikia.Data;

namespace Execution_of_Darkness_Wikia
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            WikiStartup.Initialize();
        }
    }
}
