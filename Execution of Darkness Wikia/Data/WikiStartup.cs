using System.Data.Entity;

namespace Execution_of_Darkness_Wikia.Data
{
    public static class WikiStartup
    {
        private static bool _initialized;

        public static void Initialize()
        {
            if (_initialized)
                return;

            Database.SetInitializer(new WikiDbInitializer());

            using (var context = new WikiDbContext())
            {
                context.Database.Initialize(false);
            }

            _initialized = true;
        }
    }
}
