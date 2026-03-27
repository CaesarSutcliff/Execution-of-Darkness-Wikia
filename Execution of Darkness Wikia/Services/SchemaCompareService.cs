using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;

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

                    if (!typeMatches || !nullableMatches)
                    {
                        differences.Add(new SchemaDifference
                        {
                            Type = "ColumnMismatch",
                            TableName = expectedTable.Key,
                            ColumnName = expectedColumn.ColumnName,
                            Expected = Describe(expectedColumn),
                            Actual = Describe(actualColumn),
                            Details = "Diferença de tipo e/ou nulabilidade."
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
                            Details = "Coluna existente no banco, mas não prevista na base atual."
                        });
                    }
                }
            }

            foreach (var actualTable in actualTables.Keys)
            {
                if (!expectedTables.ContainsKey(actualTable))
                {
                    differences.Add(new SchemaDifference
                    {
                        Type = "ExtraTable",
                        TableName = actualTable,
                        Details = "Tabela existente no banco, mas não prevista na base atual."
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
            return new Dictionary<string, List<SchemaColumnDefinition>>(StringComparer.OrdinalIgnoreCase)
            {
                ["WikiArticle"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false),
                    new SchemaColumnDefinition("IsActive", "bit", false),
                    new SchemaColumnDefinition("Title", "nvarchar", false),
                    new SchemaColumnDefinition("Slug", "nvarchar", false),
                    new SchemaColumnDefinition("Summary", "nvarchar", true),
                    new SchemaColumnDefinition("Content", "nvarchar", true),
                    new SchemaColumnDefinition("Category", "nvarchar", true),
                    new SchemaColumnDefinition("IsPublished", "bit", false),
                    new SchemaColumnDefinition("PublishedAt", "datetime", true),
                    new SchemaColumnDefinition("CoverImageUrl", "nvarchar", true)
                },
                ["Faction"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false),
                    new SchemaColumnDefinition("IsActive", "bit", false),
                    new SchemaColumnDefinition("Name", "nvarchar", false),
                    new SchemaColumnDefinition("Slug", "nvarchar", false),
                    new SchemaColumnDefinition("Summary", "nvarchar", true),
                    new SchemaColumnDefinition("Description", "nvarchar", true),
                    new SchemaColumnDefinition("Motto", "nvarchar", true),
                    new SchemaColumnDefinition("Alignment", "nvarchar", true),
                    new SchemaColumnDefinition("EmblemUrl", "nvarchar", true)
                },
                ["Location"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false),
                    new SchemaColumnDefinition("IsActive", "bit", false),
                    new SchemaColumnDefinition("Name", "nvarchar", false),
                    new SchemaColumnDefinition("Slug", "nvarchar", false),
                    new SchemaColumnDefinition("Summary", "nvarchar", true),
                    new SchemaColumnDefinition("Description", "nvarchar", true),
                    new SchemaColumnDefinition("Region", "nvarchar", true),
                    new SchemaColumnDefinition("DangerLevel", "nvarchar", true),
                    new SchemaColumnDefinition("ImageUrl", "nvarchar", true)
                },
                ["CharacterProfile"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false),
                    new SchemaColumnDefinition("IsActive", "bit", false),
                    new SchemaColumnDefinition("Name", "nvarchar", false),
                    new SchemaColumnDefinition("Slug", "nvarchar", false),
                    new SchemaColumnDefinition("Alias", "nvarchar", true),
                    new SchemaColumnDefinition("Summary", "nvarchar", true),
                    new SchemaColumnDefinition("Biography", "nvarchar", true),
                    new SchemaColumnDefinition("Rank", "nvarchar", true),
                    new SchemaColumnDefinition("Status", "nvarchar", true),
                    new SchemaColumnDefinition("FirstAppearance", "nvarchar", true),
                    new SchemaColumnDefinition("AvatarUrl", "nvarchar", true),
                    new SchemaColumnDefinition("FactionId", "int", true),
                    new SchemaColumnDefinition("LocationId", "int", true)
                },
                ["TimelineEvent"] = new List<SchemaColumnDefinition>
                {
                    new SchemaColumnDefinition("Id", "int", false),
                    new SchemaColumnDefinition("CreatedAt", "datetime", false),
                    new SchemaColumnDefinition("UpdatedAt", "datetime", false),
                    new SchemaColumnDefinition("IsActive", "bit", false),
                    new SchemaColumnDefinition("Title", "nvarchar", false),
                    new SchemaColumnDefinition("Slug", "nvarchar", false),
                    new SchemaColumnDefinition("Summary", "nvarchar", true),
                    new SchemaColumnDefinition("Description", "nvarchar", true),
                    new SchemaColumnDefinition("EventDate", "datetime", true),
                    new SchemaColumnDefinition("Era", "nvarchar", true),
                    new SchemaColumnDefinition("ImportanceLevel", "nvarchar", true)
                }
            };
        }

        private Dictionary<string, List<SchemaColumnDefinition>> ReadActualSchema(string connectionStringName)
        {
            var result = new Dictionary<string, List<SchemaColumnDefinition>>(StringComparer.OrdinalIgnoreCase);
            var connectionString = ConfigurationManager.ConnectionStrings[connectionStringName]?.ConnectionString;

            if (string.IsNullOrWhiteSpace(connectionString))
                return result;

            using (var connection = new SqlConnection(connectionString))
            using (var command = connection.CreateCommand())
            {
                command.CommandText = @"
                    SELECT 
                        TABLE_NAME,
                        COLUMN_NAME,
                        DATA_TYPE,
                        CASE WHEN IS_NULLABLE = 'YES' THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END AS IS_NULLABLE
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
                            Convert.ToBoolean(reader["IS_NULLABLE"])
                        );

                        if (!result.ContainsKey(tableName))
                            result[tableName] = new List<SchemaColumnDefinition>();

                        result[tableName].Add(column);
                    }
                }
            }

            return result;
        }

        private string Describe(SchemaColumnDefinition column)
        {
            return string.Format("{0} | Nullable: {1}", column.DataType, column.IsNullable ? "YES" : "NO");
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
        public SchemaColumnDefinition()
        {
        }

        public SchemaColumnDefinition(string columnName, string dataType, bool isNullable)
        {
            ColumnName = columnName;
            DataType = dataType;
            IsNullable = isNullable;
        }

        public string ColumnName { get; set; }
        public string DataType { get; set; }
        public bool IsNullable { get; set; }
    }
}
