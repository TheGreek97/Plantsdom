package plantsdom;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;

import org.json.JSONArray;

import oracle.jdbc.OraclePreparedStatement;
import oracle.jdbc.OracleResultSet;
import oracle.jdbc.OracleStatement;

public class DBOperations {
	//Operation 1
		public static int insertSupply (int supplier_code, String purch_date, String arr_date, int[] ids, int[] quantities, float[] paids, String[] colors)
				throws IOException, ServletException, SQLException{
			Connection conn = DatabaseOracle.openConnection();
			
			if (ids.length == quantities.length && ids.length == paids.length) {
				try {
					int no_plants = DatabaseOracle.countPositive (ids);
					CallableStatement stmt = conn.prepareCall("{call register_supply(?, ?, ?," +
							DatabaseOracle.convertToIntVarray(ids, no_plants)+","+ 
							DatabaseOracle.convertToIntVarray(quantities, no_plants) +"," +
							DatabaseOracle.convertToMoneyVarray(paids, no_plants)+ "," +
							DatabaseOracle.convertToColorsVarray(colors, no_plants) +", ?)}");
					
					stmt.setInt (1, supplier_code);
					stmt.setDate (2, java.sql.Date.valueOf(purch_date));
					stmt.setDate (3, java.sql.Date.valueOf(arr_date));
					stmt.setInt (4, no_plants);
					
					stmt.close();
					conn.close();
					System.out.println("Success");
					return 200;
				}
				catch (SQLException e) {
					throw new ServletException (e);
				}
				catch (Exception e) {
					throw new ServletException (e);
				}
			} else {
				return 400; //Bad request
			}
			
		}
		
		//Operation 2
		public static Float insertPurchase (String customer_code, int[] ids, int[] quantities, String[] colors)
				throws IOException, ServletException, SQLException{
			Connection conn = DatabaseOracle.openConnection();
			
			if (ids.length == quantities.length && ids.length == colors.length) {
				int no_plants = DatabaseOracle.countPositive (ids);
				try {
					CallableStatement stmt = conn.prepareCall("{call register_sale(?," +
							DatabaseOracle.convertToIntVarray(ids, no_plants)+","+ 
							DatabaseOracle.convertToIntVarray(quantities, no_plants) +"," +
							DatabaseOracle.convertToColorsVarray(colors, no_plants) +", ?)}");
					System.out.println("register_sale(?," +
							DatabaseOracle.convertToIntVarray(ids, no_plants)+","+ 
							DatabaseOracle.convertToIntVarray(quantities, no_plants) +"," +
							DatabaseOracle.convertToColorsVarray(colors, no_plants) +", ?)}");
					stmt.setString (1, customer_code);
					stmt.setInt (2, no_plants);

					stmt.close();
					conn.close();
					System.out.println("Success");
					return (float) 0; 
				}
				catch (SQLException e) {
					throw new ServletException (e);
				}
			} else {
				return (float) -1; //Bad request
			}
		}
		
		
		//Operation 3
		public static JSONArray getAvailablePlants () throws ServletException, SQLException {
			Connection conn = DatabaseOracle.openConnection();
			try {
				OracleStatement stmt = (OracleStatement) conn.createStatement();
				OracleResultSet rs = (OracleResultSet) stmt.executeQuery("SELECT  * from Plants WHERE in_stock>0");
				JSONArray json = DatabaseOracle.convert(rs);
				stmt.close();
				conn.close();
				//System.out.println("results: " + json.toString());
				return json;
			}
		    catch(SQLException e){
		       conn.close();
		       throw new ServletException(e);
		    }
		}
		
		//Operation 4
		public static JSONArray getCustomerPurchases (String customer_id) throws ServletException, SQLException {
			Connection conn = DatabaseOracle.openConnection();
			try {
				OraclePreparedStatement stmt = (OraclePreparedStatement) conn.prepareStatement("SELECT t.* FROM TABLE (SELECT Purchases FROM Customers WHERE identification_number = ?) t");
				stmt.setString(1, customer_id);
				stmt.executeQuery();
				OracleResultSet rs = (OracleResultSet) stmt.getResultSet();
				JSONArray json = DatabaseOracle.convert(rs);
				rs.close();
				stmt.close();
				conn.close();
				//System.out.println("results: " + json.toString());
				return json;
			}
		    catch(SQLException e){
		       conn.close();
		       throw new ServletException(e);
		    }
		}
		
		// Operation 5
		public static JSONArray getMostSoldPlants () throws ServletException, SQLException {
			Connection conn = DatabaseOracle.openConnection();
			try {
				OracleStatement stmt = (OracleStatement) conn.createStatement();
				OracleResultSet rs = (OracleResultSet) stmt.executeQuery("SELECT * FROM plants ORDER BY (number_sold) DESC");
				JSONArray json = DatabaseOracle.convert(rs);
				stmt.close();
				conn.close();
				//System.out.println("results: " + json.toString());
				return json;
			} 
		    catch(SQLException e){
			       conn.close();
			       throw new ServletException(e);
			}
		}
		
}
