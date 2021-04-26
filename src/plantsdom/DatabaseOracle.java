package plantsdom;

import java.io.IOException;
import java.sql.Array;

import oracle.jdbc.OracleResultSet;
import oracle.sql.*;
import java.sql.CallableStatement;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import oracle.sql.*;

public class DatabaseOracle {
	
	static Connection openConnection () throws ServletException, SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Connected to the Database");
			return DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", Config.user, Config.password);
		} catch (Exception e) {
			throw new ServletException (e);
		}
	}
	
	static ArrayList <String> formatResults(ResultSet result) throws SQLException {
		ArrayList <String> results = new ArrayList<String>();
		int i = 0;
		System.out.println(result);
		while (result.next()) {
			results.add(result.getString(i++));
		}
		return results;
	}
	
	static String convertToDate (String date) {
		//System.out.println("TO_DATE('"+ date +"', 'YYYY-MM-DD')");
		return "TO_DATE('"+ date +"', 'YYYY-MM-DD')";
	}
	
	static String convertToIntVarray (int [] array, int length) {
		if (array.length > 0) {
			String result = array[0]+"";
			for (int i = 1; i< length; i++) {
				result += "," + array[i];
			}
			//System.out.println("int_varray(" + result + ")");
			return "int_varray(" + result + ")";
		} else {
			return "NULL";
		}
	}
	
	static String convertToMoneyVarray (float [] array, int length) {
		if (array.length > 0) {
			String result = array[0]+"";
			for (int i = 1; i< length; i++) {
				result += "," + array[i];
			}
			//System.out.println("money_varray(" + result + ")");
			return "money_varray(" + result + ")";
		} else {
			return "NULL";
		}
	}
	
	static String convertToColorsVarray (String [] array, int length) {
		if (array.length > 0) {
			String result="";
			for (int i = 0; i< length; i++) {
				if (i != 0) {
					result +=",";
				}
				if (array[i] == "") {
					result += "NULL";
				} else {
					result += "'"+array[i]+"'";
				}
			}
			//System.out.println("colors_va(" + result + ")");
			return "colors_va(" + result + ")";
		} else {
			return "NULL";
		}
	}
	
	/**
	 * Counts the first positive elements of the array
	 * @param array
	 * @return
	 */
	static int countPositive (int [] array) {
		int k = 0;
		while (k < array.length && array[k] > 0) {
			k++;
		}
		return k;
	}
	
	public static JSONArray convert( OracleResultSet rs )
		    throws SQLException, JSONException 
	{
		    JSONArray json = new JSONArray();
		    ResultSetMetaData rsmd = rs.getMetaData();
		    while(rs.next()) {
		      int numColumns = rsmd.getColumnCount();
		      JSONObject obj = new JSONObject();
		      
		      for (int i=1; i<numColumns+1; i++) {
		        String column_name = rsmd.getColumnName(i);
		        System.out.println("col_name: " + column_name);
		        System.out.println("type: " + rsmd.getColumnType(i));
		        System.out.println("value: " + rs.getString(column_name));
		        
		        if(rsmd.getColumnType(i)==java.sql.Types.ARRAY){ //MANAGE VARRAYS AND NESTED TABLES
			         ARRAY r = rs.getARRAY(column_name);
			         if (r != null) {
			        	 OracleResultSet subrow = (OracleResultSet) r.getResultSet();
		        		 subrow.next();
		        		 JSONArray jsa = new JSONArray();
				        System.out.println(r.getSQLTypeName());
			        	 switch (r.getSQLTypeName()) {
			        	 case "FINAL_PROJECT.PRICES_NT":
			        		 jsa = convertPricesNT(subrow);
			        		 break;
			        	 case "FINAL_PROJECT.COLORS_VA":
			        		 jsa = convertColorsVA(subrow);
			        		 break;
			        	 case "FINAL_PROJECT.PLANTS_PURCHASED_VA":
			        		 jsa = convertPlantsPurchasedVA(subrow);
			        		 break;
			        	// case "FINAL_PROJECT.PLANTS_SUPPLIED_NT":
			        		 //jsa = DatabaseOracle.convertColorsVA(subrow);
			        		// break;
			        	 } 
		        		 obj.put(column_name, jsa);
			         } else {
			        	 obj.put(column_name, "{}"); 
			         }
		        }
		        else if(rsmd.getColumnType(i)==java.sql.Types.BIGINT){
		         obj.put(column_name, rs.getInt(column_name));
		        }
		        else if(rsmd.getColumnType(i)==java.sql.Types.BOOLEAN){
		         obj.put(column_name, rs.getBoolean(column_name));
		        }
		        else if(rsmd.getColumnType(i)==java.sql.Types.BLOB){
		         obj.put(column_name, rs.getBlob(column_name));
		        }
		        else if(rsmd.getColumnType(i)==java.sql.Types.DOUBLE){
		         obj.put(column_name, rs.getDouble(column_name)); 
		        }
		        else if(rsmd.getColumnType(i)==java.sql.Types.FLOAT){
		         obj.put(column_name, rs.getFloat(column_name));
		        }
		        else if(rsmd.getColumnType(i)==java.sql.Types.INTEGER){
		         obj.put(column_name, rs.getInt(column_name));
		        }
		        else if(rsmd.getColumnType(i)==java.sql.Types.NVARCHAR){
		         obj.put(column_name, rs.getNString(column_name));
		        }
		        else if(rsmd.getColumnType(i)==java.sql.Types.VARCHAR){
		         obj.put(column_name, rs.getString(column_name));
		        }
		        else if(rsmd.getColumnType(i)==java.sql.Types.TINYINT){
		         obj.put(column_name, rs.getInt(column_name));
		        }
		        else if(rsmd.getColumnType(i)==java.sql.Types.SMALLINT){
		         obj.put(column_name, rs.getInt(column_name));
		        }
		        else if(rsmd.getColumnType(i)==java.sql.Types.DATE){
		         obj.put(column_name, rs.getDate(column_name));
		        }
		        else if(rsmd.getColumnType(i)==java.sql.Types.TIMESTAMP){
		        obj.put(column_name, rs.getTimestamp(column_name));   
		        }
		        else{
		         obj.put(column_name, rs.getObject(column_name));
		        }
		      }
		      json.put(obj);
		    }

		    return json;
		  }
	
		protected static JSONArray convertPricesNT (OracleResultSet rs) {
			try {
				JSONArray prices = new JSONArray ();
				do {
					STRUCT str = rs.getSTRUCT(2); // rs.getString(1) always contains "1";
					JSONObject jo = new JSONObject ();
					jo.put("amount", str.getOracleAttributes()[0].floatValue());
					jo.put("start_date", str.getOracleAttributes()[1].stringValue());
					jo.put("ending_date", str.getOracleAttributes()[2].stringValue());
					prices.put(jo);
				} while (rs.next());
				return prices;
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
		}
		
		protected static JSONArray convertColorsVA (OracleResultSet rs) {
			try {
				JSONArray colors = new JSONArray ();
				do {
					colors.put(rs.getString(2));
				} while (rs.next());
				return colors;
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}
		}
		
		protected static JSONArray convertPlantsPurchasedVA (OracleResultSet rs) {
			try {
				JSONArray purchased = new JSONArray ();
				do {
					STRUCT str = rs.getSTRUCT(2);
					JSONObject jo = new JSONObject ();
					REF plant_ref = (REF) str.getOracleAttributes()[0];
					STRUCT plant_struct = (STRUCT) plant_ref.getValue();
		
					jo.put("plant_id",plant_struct.getOracleAttributes()[0].stringValue());
					jo.put("plant_common_name", plant_struct.getOracleAttributes()[2].stringValue());
					jo.put("quantity", str.getOracleAttributes()[1].intValue());
					jo.put("paid", str.getOracleAttributes()[2].floatValue());
					jo.put("color", str.getOracleAttributes()[3].stringValue());
					purchased.put(jo);
				} while (rs.next());
				return purchased;
			} catch (SQLException e) {
				e.printStackTrace();
				return null;
			}	
		}
}
