List<ErpPriceColumn > resultList = new List<ErpPriceColumn>();
            IDataReader reader = null;
            SqlConnection dbConnection = null;
            //
            try
            {
                dbConnection = new  SqlConnection(connectionString);   
                IDbCommand dbCommand = new SqlCommand();
                dbCommand.Connection = dbConnection;
                dbCommand.CommandType = CommandTyp;
                dbCommand.CommandText = "TimeSummary_ForInvoice";
                //
                dbConnection.Open();
                //
                reader = dbCommand.ExecuteReader();
                //
                while (reader.Read())
                {
                    ErpPriceColumn erpEntity = new ErpPriceColumn();
                    erpEntity.ID = (int)reader["ID"];
                    erpEntity.Comment = (string)reader["Comment"];
                    erpEntity.BeforeTaxPrice = (0 == (byte)reader["BeforeTaxPrice"]);
                    erpEntity.UpdateDate = (DateTime)reader["UpdateDate"];
                    //
                    resultList.Add(erpEntity);
                }
            }
            catch (SqlException exception)
            {
                throw new MyExceptionClass(exception.Message, exception); //This is good to have!
            }
            finally
            {
                if (reader != null)
                    reader.Close();
                //
                dbConnection.Close();
            }
            //
            return resultList.ToArray();
			
			
			
SqlConnection connection = new SqlConnection(ConnectionString);

command = new SqlCommand("TestProcedure", connection);
command.CommandType = System.Data.CommandType.StoredProcedure;
connection.Open();
reader = command.ExecuteReader();

List<Test> TestList = new List<Test>();
Test test;

while (reader.Read())
{
    test = new Test();
    test.ID = int.Parse(reader["ID"].ToString());
    test.Name = reader["Name"].ToString();
    TestList.Add(test);
}

gvGrid.DataSource = TestList;
gvGrid.DataBind();