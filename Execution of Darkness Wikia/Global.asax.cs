using System;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Data.Entity;
using Execution_of_Darkness_Wikia.Data;

namespace Execution_of_Darkness_Wikia
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Desabilitar inicialização automática do Entity Framework
            Database.SetInitializer<WikiDbContext>(null);

            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            // WikiStartup.Initialize(); // Removido - inicialização manual via Schema Compare
        }
    }
}
