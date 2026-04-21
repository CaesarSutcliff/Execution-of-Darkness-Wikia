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

            // Desabilitar inicialização automática - usar Schema Compare para updates manuais
            Database.SetInitializer<WikiDbContext>(null);

            _initialized = true;
        }
    }
}
