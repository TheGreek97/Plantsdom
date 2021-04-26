

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import plantsdom.DBOperations;
import plantsdom.DatabaseOracle;

import org.json.*;

/**
 * Servlet implementation class Servlet
 */
@WebServlet({ "/Servlet", "/show_customer_purchases", "/show_most_sold", "/show_available_plants", "/insert_sale", "/insert_supply" })
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int operation = Integer.parseInt (request.getParameter("operation"));
		String result = "";
		
		try {
			switch (operation) {
			case 3 :
				result = DBOperations.getAvailablePlants().toString();
				break;
			case 4 : 
				String customer_id = request.getParameter("customer_id");
				result = DBOperations.getCustomerPurchases(customer_id).toString();
				break;
			case 5 :
				result = DBOperations.getMostSoldPlants().toString();
				break;
			}

			response.setContentType("application/json"); 
		    response.setCharacterEncoding("UTF-8");
			response.getWriter().write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int operation = Integer.parseInt (request.getParameter("operation"));
		try {
			if (operation == 1) {
				int supplier_code = Integer.parseInt( request.getParameter("supplierCode") );
				String purch_date = request.getParameter("purchaseDate");
				String arr_date = request.getParameter("arrivalDate");
				String plants_purchased = request.getParameter("plants_purchased");

				int [] ids = new int[200];
				float [] paids = new float[200];
				String [] colors = new String[200];
				int [] quantities = new int[200];
				JSONArray plants = new JSONArray(plants_purchased);
				for (int i = 0; i < plants.length(); i++) {
					JSONObject p = plants.getJSONObject(i);
					ids[i] = p.getInt("id");
					paids[i] = p.getFloat("paid");
					colors[i] = p.getString("color");
					quantities[i] = p.getInt("quantity");
				}
				
				if (DBOperations.insertSupply(supplier_code, purch_date, arr_date, ids, quantities, paids, colors) == 200) {
					response.setStatus(200);
					request.setAttribute("previousResult", "Success");
					response.sendRedirect("operations.jsp");
				} else {
					System.out.println("error!");
					response.setStatus(500);
					request.setAttribute("previousResult", "Error");
					response.sendRedirect("operations.jsp");
				}
			} else if (operation == 2) {
				String customer_code = request.getParameter("customerCode");
				String plants_purchased = request.getParameter("plants_purchased");

				int [] ids = new int[200];
				String [] colors = new String[200];
				int [] quantities = new int[200];
				JSONArray plants = new JSONArray(plants_purchased);
				for (int i = 0; i < plants.length(); i++) {
					JSONObject p = plants.getJSONObject(i);
					ids[i] = p.getInt("id");
					colors[i] = p.getString("color");
					quantities[i] = p.getInt("quantity");
				}
				float tot_paid = DBOperations.insertPurchase(customer_code, ids, quantities, colors);
				//return amount to pay
				if ( tot_paid == 0) {
					response.setStatus(200);
					request.setAttribute("previousResult", "Success");
					response.sendRedirect("operations.jsp");
				} else {
					System.out.println("error!");
					response.setStatus(500);
					request.setAttribute("previousResult", "Error");
					response.sendRedirect("operations.jsp");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
