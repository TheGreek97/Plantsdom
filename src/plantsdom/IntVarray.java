package plantsdom;

import java.sql.Array;
import java.sql.SQLData;
import java.sql.SQLException;
import java.sql.SQLInput;
import java.sql.SQLOutput;

public class IntVarray implements SQLData {

	private Array data;
	private String sql_type = "int_varray";
	
	@Override
	public String getSQLTypeName() throws SQLException {
		return sql_type;
	}

	@Override
	public void readSQL(SQLInput stream, String type) throws SQLException {
		this.sql_type = type;
		this.data = stream.readArray();
	}

	@Override
	public void writeSQL(SQLOutput stream) throws SQLException {
		stream.writeArray(data);
	}
	
	public Array data () {
		return this.data;
	}
	
	public void data (Array a) {
		this.data = a;
	}

}
