using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;

namespace Execution_of_Darkness_Wikia.Services
{
    public class SchemaCompareService
    {
        public SchemaCompareResult Compare(string connectionStringName)
        {
            var expectedTables = BuildExpectedSchema();
            var actualTables = ReadActualSchema(connectionStringName);
            var differences = new List<SchemaDifference>();

            foreach (var expectedTable in expectedTables)
            {
                if (!actualTables.ContainsKey(expectedTable.Key))
                {
                    differences.Add(new SchemaDifference
                    {
                        Type = "MissingTable",
                        TableName = expectedTable.Key,
                        Details = "Tabela esperada não encontrada no banco."
                    });
                    continue;
                }

                var actualColumns = actualTables[expectedTable.Key];

                foreach (var expectedColumn in expectedTable.Value)
                {
                    var actualColumn = actualColumns.FirstOrDefault(x =>
                        x.ColumnName.Equals(expectedColumn.ColumnName, StringComparison.OrdinalIgnoreCase));

                    if (actualColumn == null)
                    {
                        differences.Add(new SchemaDifference
                        {
                            Type = "MissingColumn",
                            TableName = expectedTable.Key,
                            ColumnName = expectedColumn.ColumnName,
                            Expected = Describe(expectedColumn),
                            Actual = "-",
                            Details = "Coluna esperada não encontrada."
                        });
                        continue;
                    }

                    var typeMatches = string.Equals(actualColumn.DataType, expectedColumn.DataType, StringComparison.OrdinalIgnoreCase);
                    var nullableMatches = actualColumn.IsNullable == expectedColumn.IsNullable;
                    var lengthMatches = expectedColumn.MaxLength <= 0 || actualColumn.MaxLength == expectedColumn.MaxLength || actualColumn.MaxLength == -1;

                    if (!typeMatches || !nullableMatches || !lengthMatches)
                    {
                        differences.Add(new SchemaDifference
                        {
                            Type = "ColumnMismatch",
                            TableName = expectedTable.Key,
                            ColumnName = expectedColumn.ColumnName,
                            Expected = Describe(expectedColumn),
                            Actual = Describe(actualColumn),
                            Details = !typeMatches ? "Tipo diferente." : !nullableMatches ? "Nulabilidade diferente." : "Tamanho diferente."
                        });
                    }
                }

                foreach (var actualColumn in actualColumns)
                {
                    var existsInExpected = expectedTable.Value.Any(x =>
                        x.ColumnName.Equals(actualColumn.ColumnName, StringComparison.OrdinalIgnoreCase));

                    if (!existsInExpected)
                    {
                        differences.Add(new SchemaDifference
                        {
                            Type = "ExtraColumn",
                            TableName = expectedTable.Key,
                            ColumnName = actualColumn.ColumnName,
                            Expected = "-",
                            Actual = Describe(actualColumn),
                            Details = "Coluna existente no banco, mas não prevista no schema esperado."
                        });
                    }
                }
            }

            foreach (var actualTable in actualTables.Keys)
            {
                // Ignorar tabelas de sistema do EF
                if (actualTable == "__MigrationHistory")
                    continue;

                if (!expectedTables.ContainsKey(actualTable))
                {
                    differences.Add(new SchemaDifference
                    {
                        Type = "ExtraTable",
                        TableName = actualTable,
                        Details = "Tabela existente no banco, mas não prevista no schema esperado."
                    });
                }
            }

            return new SchemaCompareResult
            {
                Differences = differences.OrderBy(x => x.TableName).ThenBy(x => x.ColumnName).ToList(),
                ExpectedTableCount = expectedTables.Count,
                ActualTableCount = actualTables.Count
            };
        }

        private Dictionary<string, List<SchemaColumnDefinition>> BuildExpectedSchema()
        {
            // Schema esperado alinhado com o banco real (scripts originais + upgrades aplicados)
            return new Dictionary<string, List<SchemaColumnDefinition>>(StringComparer.OrdinalIgnoreCase)
            {
                ["WikiArticle"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("Title", "nvarchar", false, 200),
                    new SchemaColumnDefinition("Slug", "nvarchar", false, 200),
                    new SchemaColumnDefinition("Summary", "nvarchar", true, 500),
                    new SchemaColumnDefinition("Content", "nvarchar", true, -1),
                    new SchemaColumnDefinition("Category", "nvarchar", true, 100),
                    new SchemaColumnDefinition("RelatedCharacterId", "int", true),
                    new SchemaColumnDefinition("RelatedFactionId", "int", true),
                    new SchemaColumnDefinition("RelatedLocationId", "int", true),
                    new SchemaColumnDefinition("RelatedVolumeId", "int", true),
                    new SchemaColumnDefinition("IsPublished", "bit", false),
                    new SchemaColumnDefinition("PublishedAt", "datetime", true),
                    new SchemaColumnDefinition("CoverImageUrl", "nvarchar", true, 300),
                    new SchemaColumnDefinition("IsActive", "bit", false),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false)
                },
                ["ArticleVersion"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("ArticleId", "int", false),
                    new SchemaColumnDefinition("VersionNumber", "int", false),
                    new SchemaColumnDefinition("TitleSnapshot", "nvarchar", false, 200),
                    new SchemaColumnDefinition("ContentSnapshot", "nvarchar", true, -1),
                    new SchemaColumnDefinition("AuthorName", "nvarchar", true, 120),
                    new SchemaColumnDefinition("ChangeSummary", "nvarchar", true, 500),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false),
                    new SchemaColumnDefinition("IsActive", "bit", false)
                },
                ["ArticleSection"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("ArticleId", "int", false),
                    new SchemaColumnDefinition("Title", "nvarchar", false, 150),
                    new SchemaColumnDefinition("SectionType", "nvarchar", true, 80),
                    new SchemaColumnDefinition("Body", "nvarchar", true, -1),
                    new SchemaColumnDefinition("SortOrder", "int", false)
                },
                ["ArticleTag"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("ArticleId", "int", false),
                    new SchemaColumnDefinition("TagId", "int", false)
                },
                ["TagEntry"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("Name", "nvarchar", false, 100),
                    new SchemaColumnDefinition("Slug", "nvarchar", false, 120)
                },
                ["Faction"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("Name", "nvarchar", false, 150),
                    new SchemaColumnDefinition("Slug", "nvarchar", false, 200),
                    new SchemaColumnDefinition("Summary", "nvarchar", true, 500),
                    new SchemaColumnDefinition("Description", "nvarchar", true, -1),
                    new SchemaColumnDefinition("FactionType", "nvarchar", true, 80),
                    new SchemaColumnDefinition("Alignment", "nvarchar", true, 100),
                    new SchemaColumnDefinition("Motto", "nvarchar", true, 150),
                    new SchemaColumnDefinition("EmblemUrl", "nvarchar", true, 300),
                    new SchemaColumnDefinition("CrestUrl", "nvarchar", true, 300),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false),
                    new SchemaColumnDefinition("IsActive", "bit", false)
                },
                ["Location"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("Name", "nvarchar", false, 150),
                    new SchemaColumnDefinition("Slug", "nvarchar", false, 200),
                    new SchemaColumnDefinition("Summary", "nvarchar", true, 500),
                    new SchemaColumnDefinition("Description", "nvarchar", true, -1),
                    new SchemaColumnDefinition("Region", "nvarchar", true, 100),
                    new SchemaColumnDefinition("DangerLevel", "nvarchar", true, 100),
                    new SchemaColumnDefinition("LocationType", "nvarchar", true, 80),
                    new SchemaColumnDefinition("FirstAppearanceVolumeId", "int", true),
                    new SchemaColumnDefinition("ImageUrl", "nvarchar", true, 300),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false),
                    new SchemaColumnDefinition("IsActive", "bit", false)
                },
                ["CharacterProfile"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("Name", "nvarchar", false, 150),
                    new SchemaColumnDefinition("Slug", "nvarchar", false, 200),
                    new SchemaColumnDefinition("Alias", "nvarchar", true, 150),
                    new SchemaColumnDefinition("Summary", "nvarchar", true, 500),
                    new SchemaColumnDefinition("Biography", "nvarchar", true, -1),
                    new SchemaColumnDefinition("AgeText", "nvarchar", true, 50),
                    new SchemaColumnDefinition("Clan", "nvarchar", true, 120),
                    new SchemaColumnDefinition("Occupation", "nvarchar", true, 250),
                    new SchemaColumnDefinition("RankTitle", "nvarchar", true, 100),
                    new SchemaColumnDefinition("StatusText", "nvarchar", true, 80),
                    new SchemaColumnDefinition("FirstAppearance", "nvarchar", true, 100),
                    new SchemaColumnDefinition("AvatarUrl", "nvarchar", true, 300),
                    new SchemaColumnDefinition("FactionId", "int", true),
                    new SchemaColumnDefinition("CurrentLocationId", "int", true),
                    new SchemaColumnDefinition("LocationId", "int", true),
                    new SchemaColumnDefinition("IsFeaturedOnHome", "bit", false),
                    new SchemaColumnDefinition("FeaturedOrder", "int", true),
                    new SchemaColumnDefinition("Race", "nvarchar", true, 80),
                    new SchemaColumnDefinition("Gender", "nvarchar", true, 40),
                    new SchemaColumnDefinition("Alignment", "nvarchar", true, 80),
                    new SchemaColumnDefinition("BirthPlace", "nvarchar", true, 150),
                    new SchemaColumnDefinition("Residence", "nvarchar", true, 150),
                    new SchemaColumnDefinition("Personality", "nvarchar", true, -1),
                    new SchemaColumnDefinition("Appearance", "nvarchar", true, -1),
                    new SchemaColumnDefinition("AbilitiesOverview", "nvarchar", true, -1),
                    new SchemaColumnDefinition("Quote", "nvarchar", true, 500),
                    new SchemaColumnDefinition("BannerUrl", "nvarchar", true, 300),
                    new SchemaColumnDefinition("Status", "nvarchar", true, 100),
                    new SchemaColumnDefinition("Rank", "nvarchar", true, 100),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false),
                    new SchemaColumnDefinition("IsActive", "bit", false)
                },
                ["CharacterRelationship"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("CharacterId", "int", false),
                    new SchemaColumnDefinition("RelatedCharacterId", "int", false),
                    new SchemaColumnDefinition("RelationshipType", "nvarchar", false, 80),
                    new SchemaColumnDefinition("Summary", "nvarchar", true, 500)
                },
                ["CharacterPower"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("CharacterId", "int", false),
                    new SchemaColumnDefinition("PowerId", "int", false),
                    new SchemaColumnDefinition("Notes", "nvarchar", true, 500)
                },
                ["CharacterArtifact"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("CharacterId", "int", false),
                    new SchemaColumnDefinition("ArtifactId", "int", false),
                    new SchemaColumnDefinition("Notes", "nvarchar", true, 500)
                },
                ["CharacterFactionHistory"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("CharacterId", "int", false),
                    new SchemaColumnDefinition("FactionId", "int", false),
                    new SchemaColumnDefinition("RoleName", "nvarchar", true, 120),
                    new SchemaColumnDefinition("StartMarker", "nvarchar", true, 80),
                    new SchemaColumnDefinition("EndMarker", "nvarchar", true, 80),
                    new SchemaColumnDefinition("IsCurrent", "bit", false)
                },
                ["TimelineEvent"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("Title", "nvarchar", false, 200),
                    new SchemaColumnDefinition("Slug", "nvarchar", false, 200),
                    new SchemaColumnDefinition("Summary", "nvarchar", true, 500),
                    new SchemaColumnDefinition("Description", "nvarchar", true, -1),
                    new SchemaColumnDefinition("Era", "nvarchar", true, 100),
                    new SchemaColumnDefinition("VolumeId", "int", true),
                    new SchemaColumnDefinition("ChapterId", "int", true),
                    new SchemaColumnDefinition("EventDate", "datetime", true),
                    new SchemaColumnDefinition("EventDateText", "nvarchar", true, 80),
                    new SchemaColumnDefinition("ImportanceLevel", "nvarchar", true, 50),
                    new SchemaColumnDefinition("IsActive", "bit", false),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false)
                },
                ["EventCharacter"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("EventId", "int", false),
                    new SchemaColumnDefinition("CharacterId", "int", false),
                    new SchemaColumnDefinition("ParticipationType", "nvarchar", true, 80)
                },
                ["EventLocation"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("EventId", "int", false),
                    new SchemaColumnDefinition("LocationId", "int", false)
                },
                ["VolumeEntry"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("VolumeNumber", "int", false),
                    new SchemaColumnDefinition("Title", "nvarchar", false, 200),
                    new SchemaColumnDefinition("Subtitle", "nvarchar", true, 200),
                    new SchemaColumnDefinition("Summary", "nvarchar", true, -1),
                    new SchemaColumnDefinition("CoverImageUrl", "nvarchar", true, 300),
                    new SchemaColumnDefinition("IsPublished", "bit", false),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false)
                },
                ["ChapterEntry"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("VolumeId", "int", false),
                    new SchemaColumnDefinition("ChapterNumber", "int", false),
                    new SchemaColumnDefinition("Title", "nvarchar", false, 250),
                    new SchemaColumnDefinition("Summary", "nvarchar", true, -1),
                    new SchemaColumnDefinition("SortOrder", "int", false),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false)
                },
                ["ArtifactEntry"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("Name", "nvarchar", false, 150),
                    new SchemaColumnDefinition("Slug", "nvarchar", false, 200),
                    new SchemaColumnDefinition("Summary", "nvarchar", true, 500),
                    new SchemaColumnDefinition("Description", "nvarchar", true, -1),
                    new SchemaColumnDefinition("ArtifactType", "nvarchar", true, 80),
                    new SchemaColumnDefinition("CurrentOwnerCharacterId", "int", true),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false)
                },
                ["PowerEntry"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("Name", "nvarchar", false, 150),
                    new SchemaColumnDefinition("Slug", "nvarchar", false, 200),
                    new SchemaColumnDefinition("Summary", "nvarchar", true, 500),
                    new SchemaColumnDefinition("Description", "nvarchar", true, -1),
                    new SchemaColumnDefinition("PowerType", "nvarchar", true, 80),
                    new SchemaColumnDefinition("SourceType", "nvarchar", true, 80),
                    new SchemaColumnDefinition("RiskLevel", "nvarchar", true, 80),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false)
                },
                ["QuoteEntry"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("CharacterId", "int", true),
                    new SchemaColumnDefinition("ArticleId", "int", true),
                    new SchemaColumnDefinition("VolumeId", "int", true),
                    new SchemaColumnDefinition("ChapterId", "int", true),
                    new SchemaColumnDefinition("QuoteText", "nvarchar", false, -1),
                    new SchemaColumnDefinition("ContextText", "nvarchar", true, 500),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false)
                },
                ["User"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("Username", "nvarchar", false, 100),
                    new SchemaColumnDefinition("Email", "nvarchar", false, 200),
                    new SchemaColumnDefinition("PasswordHash", "nvarchar", false, 256),
                    new SchemaColumnDefinition("Salt", "nvarchar", false, 128),
                    new SchemaColumnDefinition("DisplayName", "nvarchar", true, 150),
                    new SchemaColumnDefinition("IsActive", "bit", false),
                    new SchemaColumnDefinition("IsAdmin", "bit", false),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false),
                    new SchemaColumnDefinition("LastLoginAt", "datetime", true)
                },
                ["Comment"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("ArticleId", "int", false),
                    new SchemaColumnDefinition("UserId", "int", false),
                    new SchemaColumnDefinition("ParentCommentId", "int", true),
                    new SchemaColumnDefinition("Content", "nvarchar", false, -1),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false),
                    new SchemaColumnDefinition("IsActive", "bit", false),
                    new SchemaColumnDefinition("IsDeleted", "bit", false)
                }
            };
        }

        private Dictionary<string, List<SchemaColumnDefinition>> ReadActualSchema(string connectionStringName)
        {
            var result = new Dictionary<string, List<SchemaColumnDefinition>>(StringComparer.OrdinalIgnoreCase);
            var connectionString = ConfigurationManager.ConnectionStrings[connectionStringName]?.ConnectionString;

            if (string.IsNullOrWhiteSpace(connectionString))
                return result;

            try
            {
                using (var connection = new SqlConnection(connectionString))
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = @"
                        SELECT 
                            TABLE_NAME,
                            COLUMN_NAME,
                            DATA_TYPE,
                            CASE WHEN IS_NULLABLE = 'YES' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS IS_NULLABLE,
                            CASE WHEN CHARACTER_MAXIMUM_LENGTH IS NULL THEN 0 ELSE CHARACTER_MAXIMUM_LENGTH END AS MAX_LENGTH
                        FROM INFORMATION_SCHEMA.COLUMNS
                        WHERE TABLE_SCHEMA = 'dbo'
                        ORDER BY TABLE_NAME, ORDINAL_POSITION";

                    connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var tableName = reader["TABLE_NAME"].ToString();
                            var column = new SchemaColumnDefinition(
                                reader["COLUMN_NAME"].ToString(),
                                reader["DATA_TYPE"].ToString(),
                                Convert.ToBoolean(reader["IS_NULLABLE"]),
                                Convert.ToInt32(reader["MAX_LENGTH"])
                            );

                            if (!result.ContainsKey(tableName))
                                result[tableName] = new List<SchemaColumnDefinition>();

                            result[tableName].Add(column);
                        }
                    }
                }
            }
            catch (SqlException)
            {
                return result;
            }

            return result;
        }

        private string Describe(SchemaColumnDefinition column)
        {
            var len = column.MaxLength > 0 ? "(" + column.MaxLength + ")" : column.MaxLength == -1 ? "(MAX)" : "";
            return string.Format("{0}{1} | Nullable: {2}", column.DataType, len, column.IsNullable ? "SIM" : "NÃO");
        }

        public string GenerateUpgradeScript(string connectionStringName)
        {
            var result = Compare(connectionStringName);
            if (result.Differences.Count == 0)
                return "-- Nenhuma diferença encontrada. O banco está sincronizado.";

            var sb = new StringBuilder();
            sb.AppendLine("-- Script de upgrade gerado automaticamente em " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            sb.AppendLine("-- Diferenças encontradas: " + result.Differences.Count);
            sb.AppendLine();

            var missingTables = result.Differences.Where(d => d.Type == "MissingTable").ToList();
            var missingColumns = result.Differences.Where(d => d.Type == "MissingColumn").ToList();

            foreach (var table in missingTables)
            {
                sb.AppendLine("-- AVISO: Tabela '" + table.TableName + "' não existe no banco.");
                sb.AppendLine("-- Execute o script 10-full-schema-fresh.sql ou crie a tabela manualmente.");
                sb.AppendLine();
            }

            foreach (var col in missingColumns)
            {
                var expected = BuildExpectedSchema();
                if (expected.ContainsKey(col.TableName))
                {
                    var colDef = expected[col.TableName].FirstOrDefault(c =>
                        c.ColumnName.Equals(col.ColumnName, StringComparison.OrdinalIgnoreCase));
                    if (colDef != null)
                    {
                        var sqlType = colDef.DataType;
                        if (colDef.MaxLength > 0) sqlType += "(" + colDef.MaxLength + ")";
                        else if (colDef.MaxLength == -1) sqlType += "(MAX)";

                        var nullable = colDef.IsNullable ? "NULL" : "NOT NULL";
                        sb.AppendLine(string.Format("IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '{0}' AND COLUMN_NAME = '{1}')",
                            col.TableName, colDef.ColumnName));
                        sb.AppendLine(string.Format("    ALTER TABLE [dbo].[{0}] ADD [{1}] [{2}] {3};",
                            col.TableName, colDef.ColumnName, sqlType, nullable));
                        sb.AppendLine("GO");
                        sb.AppendLine();
                    }
                }
            }

            return sb.ToString();
        }

        public string ApplyUpgrade(string connectionStringName)
        {
            var connectionString = ConfigurationManager.ConnectionStrings[connectionStringName]?.ConnectionString;
            if (string.IsNullOrWhiteSpace(connectionString))
                return "Erro: Connection string não encontrada.";

            // Tentar primeiro o script de upgrade padrão
            var scriptPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Database", "Scripts", "11-upgrade-from-foundation.sql");
            if (!File.Exists(scriptPath))
                return "Erro: Script de upgrade não encontrado em: " + scriptPath;

            return ExecuteScript(connectionString, scriptPath);
        }

        public string ApplyScript(string connectionStringName, string scriptFileName)
        {
            var connectionString = ConfigurationManager.ConnectionStrings[connectionStringName]?.ConnectionString;
            if (string.IsNullOrWhiteSpace(connectionString))
                return "Erro: Connection string não encontrada.";

            var scriptPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Database", "Scripts", scriptFileName);
            if (!File.Exists(scriptPath))
                return "Erro: Script não encontrado em: " + scriptPath;

            return ExecuteScript(connectionString, scriptPath);
        }

        public List<string> GetAvailableScripts()
        {
            var scriptsPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Database", "Scripts");
            if (!Directory.Exists(scriptsPath))
                return new List<string>();

            return Directory.GetFiles(scriptsPath, "*.sql")
                .Select(Path.GetFileName)
                .OrderBy(f => f)
                .ToList();
        }

        private string ExecuteScript(string connectionString, string scriptPath)
        {
            var script = File.ReadAllText(scriptPath);
            // Usar regex-like split para GO em linha própria
            var commands = script.Split(new[] { "\nGO\r", "\nGO\n", "\nGO" }, StringSplitOptions.RemoveEmptyEntries);
            int executed = 0;
            int skipped = 0;

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();
                foreach (var commandText in commands)
                {
                    var trimmed = commandText.Trim();
                    if (string.IsNullOrWhiteSpace(trimmed) || trimmed.StartsWith("USE "))
                    {
                        skipped++;
                        continue;
                    }

                    using (var command = new SqlCommand(trimmed, connection))
                    {
                        try
                        {
                            command.ExecuteNonQuery();
                            executed++;
                        }
                        catch (Exception ex)
                        {
                            return string.Format("Erro no comando #{0}: {1}", executed + 1, ex.Message);
                        }
                    }
                }
            }

            return string.Format("Script executado com sucesso. {0} comandos executados, {1} ignorados.", executed, skipped);
        }

        /// <summary>
        /// Roda todos os scripts de upgrade em sequência (11, 20, 21) para sincronizar o banco.
        /// </summary>
        public string ApplyFullSync(string connectionStringName)
        {
            var connectionString = ConfigurationManager.ConnectionStrings[connectionStringName]?.ConnectionString;
            if (string.IsNullOrWhiteSpace(connectionString))
                return "Erro: Connection string não encontrada.";

            var scriptsDir = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Database", "Scripts");
            if (!Directory.Exists(scriptsDir))
                return "Erro: Pasta Database/Scripts não encontrada.";

            // Scripts de upgrade na ordem correta (ignora 00/01 baseline/seed e 10 fresh)
            var upgradeScripts = Directory.GetFiles(scriptsDir, "*.sql")
                .Select(Path.GetFileName)
                .Where(f => !f.StartsWith("00") && !f.StartsWith("01") && !f.StartsWith("10"))
                .OrderBy(f => f)
                .ToList();

            if (upgradeScripts.Count == 0)
                return "Nenhum script de upgrade encontrado na pasta.";

            var results = new StringBuilder();
            int totalExecuted = 0;
            int totalErrors = 0;

            foreach (var scriptFile in upgradeScripts)
            {
                var scriptPath = Path.Combine(scriptsDir, scriptFile);
                var result = ExecuteScript(connectionString, scriptPath);

                if (result.Contains("Erro"))
                {
                    totalErrors++;
                    results.AppendLine("[ERRO] " + scriptFile + ": " + result);
                }
                else
                {
                    totalExecuted++;
                    results.AppendLine("[OK] " + scriptFile + ": " + result);
                }
            }

            var summary = string.Format("Sincronização completa. {0} scripts executados, {1} com erro.", totalExecuted, totalErrors);
            if (totalErrors > 0)
                summary += "\n" + results.ToString();

            return summary;
        }

        /// <summary>
        /// Cria um usuário administrador master diretamente no banco.
        /// </summary>
        public string SeedAdminUser(string connectionStringName, string username, string password)
        {
            var connectionString = ConfigurationManager.ConnectionStrings[connectionStringName]?.ConnectionString;
            if (string.IsNullOrWhiteSpace(connectionString))
                return "Erro: Connection string não encontrada.";

            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
                return "Erro: Usuário e senha são obrigatórios.";

            try
            {
                // Gerar salt e hash (mesmo algoritmo do UserService)
                var saltBytes = new byte[32];
                using (var rng = new System.Security.Cryptography.RNGCryptoServiceProvider())
                {
                    rng.GetBytes(saltBytes);
                }
                var salt = Convert.ToBase64String(saltBytes);

                string hash;
                using (var sha256 = System.Security.Cryptography.SHA256.Create())
                {
                    var hashBytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password + salt));
                    hash = Convert.ToBase64String(hashBytes);
                }

                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Verificar se já existe
                    using (var checkCmd = new SqlCommand("SELECT COUNT(*) FROM [dbo].[User] WHERE Username = @u", connection))
                    {
                        checkCmd.Parameters.AddWithValue("@u", username);
                        var count = (int)checkCmd.ExecuteScalar();
                        if (count > 0)
                        {
                            // Atualizar para admin
                            using (var updateCmd = new SqlCommand("UPDATE [dbo].[User] SET IsAdmin = 1, PasswordHash = @h, Salt = @s, UpdatedAt = GETDATE() WHERE Username = @u", connection))
                            {
                                updateCmd.Parameters.AddWithValue("@u", username);
                                updateCmd.Parameters.AddWithValue("@h", hash);
                                updateCmd.Parameters.AddWithValue("@s", salt);
                                updateCmd.ExecuteNonQuery();
                            }
                            return "Usuário '" + username + "' atualizado para administrador com nova senha.";
                        }
                    }

                    // Criar novo
                    using (var insertCmd = new SqlCommand(
                        @"INSERT INTO [dbo].[User] (Username, Email, PasswordHash, Salt, DisplayName, IsActive, IsAdmin, CreatedAt, UpdatedAt)
                          VALUES (@u, @e, @h, @s, @d, 1, 1, GETDATE(), GETDATE())", connection))
                    {
                        insertCmd.Parameters.AddWithValue("@u", username);
                        insertCmd.Parameters.AddWithValue("@e", username + "@eod-wiki.local");
                        insertCmd.Parameters.AddWithValue("@h", hash);
                        insertCmd.Parameters.AddWithValue("@s", salt);
                        insertCmd.Parameters.AddWithValue("@d", "Admin " + username);
                        insertCmd.ExecuteNonQuery();
                    }

                    return "Usuário administrador '" + username + "' criado com sucesso.";
                }
            }
            catch (Exception ex)
            {
                return "Erro ao criar admin: " + ex.Message;
            }
        }

        public string CreateDatabase(string connectionStringName)
        {
            var connectionString = ConfigurationManager.ConnectionStrings[connectionStringName]?.ConnectionString;
            if (string.IsNullOrWhiteSpace(connectionString))
                return "Erro: Connection string não encontrada.";

            var scriptPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Database", "Scripts", "10-full-schema-fresh.sql");
            if (!File.Exists(scriptPath))
                return "Erro: Script de criação não encontrado em: " + scriptPath;

            var builder = new SqlConnectionStringBuilder(connectionString);
            var databaseName = builder.InitialCatalog;
            builder.InitialCatalog = "master";

            try
            {
                using (var connection = new SqlConnection(builder.ConnectionString))
                {
                    connection.Open();
                    using (var command = new SqlCommand(
                        string.Format("IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = '{0}') CREATE DATABASE [{0}]", databaseName),
                        connection))
                    {
                        command.ExecuteNonQuery();
                    }
                }

                builder.InitialCatalog = databaseName;
                return ExecuteScript(builder.ConnectionString, scriptPath);
            }
            catch (Exception ex)
            {
                return "Erro ao criar banco: " + ex.Message;
            }
        }
    }

    public class SchemaCompareResult
    {
        public List<SchemaDifference> Differences { get; set; } = new List<SchemaDifference>();
        public int ExpectedTableCount { get; set; }
        public int ActualTableCount { get; set; }
    }

    public class SchemaDifference
    {
        public string Type { get; set; }
        public string TableName { get; set; }
        public string ColumnName { get; set; }
        public string Expected { get; set; }
        public string Actual { get; set; }
        public string Details { get; set; }
    }

    public class SchemaColumnDefinition
    {
        public SchemaColumnDefinition() { }

        public SchemaColumnDefinition(string columnName, string dataType, bool isNullable, int maxLength = 0)
        {
            ColumnName = columnName;
            DataType = dataType;
            IsNullable = isNullable;
            MaxLength = maxLength;
        }

        public string ColumnName { get; set; }
        public string DataType { get; set; }
        public bool IsNullable { get; set; }
        public int MaxLength { get; set; }
    }
}
