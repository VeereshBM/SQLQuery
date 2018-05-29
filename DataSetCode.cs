using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;
using RASKeeperTool.DataObjects;


namespace RASKeeperTool.SharePoint
{
    class SPPLCDbconnection 
    {

        //open Copernicus DB connection By Veeresh

        public List<CloseRequestBean> getData()
        {
            List<CloseRequestBean> ClosedRequestBeanList = new List<CloseRequestBean>();
            SqlConnection cnn1 = null;
            System.Data.IDataReader reader = null;
            string connectionString1 = ConfigurationSettings.AppSettings["CONNECTION_STR1"];

            try
            {
                using(SqlDataAdapter closeBean = new SqlDataAdapter())
                {
                    cnn1 = new SqlConnection(connectionString1);

                    closeBean.SelectCommand = new SqlCommand("SP_GetRaskeeperPLCChangeRequests", cnn1);
                    closeBean.SelectCommand.CommandType = CommandType.StoredProcedure;

                    DataSet beanList = new DataSet();
                    closeBean.Fill(beanList, "CloseRequestBean");

                    DataTable dt = beanList.Tables["CloseRequestBean"];
                    
                
                }

                //cnn1 = new SqlConnection(connectionString1);
                //System.Data.IDbCommand dbcommand = new SqlCommand();
                //dbcommand.Connection = cnn1;
                //dbcommand.CommandType = CommandType.StoredProcedure;
                //dbcommand.CommandText = "SPText";
                //cnn1.Open();
                //reader = dbcommand.ExecuteReader();

                //while (reader.Read())
                //{
                  //  CloseRequestBean BeanList = new CloseRequestBean();
                   // BeanList.RequestID = (string)reader["ID"];
                    //BeanList.CreatedDate = (string)reader["CreatorDate"];
                    //BeanList.RequestorName = (string)reader["ReqstorName"];

                    //ClosedRequestBeanList.Add(BeanList);

                //}
            }
            catch (SqlException e)
            {

                 //PHWebException exMail = new PHWebException();
                 //exMail.popupMailOnIECrash(e);
            }

            finally
            {
                if (reader != null) 
                    reader.Close();
                    cnn1.Close();  
            }

            return ClosedRequestBeanList;
           
        }
      
    

    }
}

   
