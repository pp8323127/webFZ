package ci.db;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverPropertyInfo;
import java.sql.SQLException;
import java.util.Properties;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class PoolDriver implements Driver {

	public boolean acceptsURL(String url) throws SQLException {
		// TODO
		return false;
	}

	public Connection connect(String url, Properties properties)
			throws SQLException {
		Connection con = null;
		try {
			InitialContext initialcontext = new InitialContext();
			DataSource ds = (DataSource) initialcontext.lookup(url);
			con = ds.getConnection();
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}

	public int getMajorVersion() {
		// TODO Auto-generated method stub
		return 0;
	}

	public int getMinorVersion() {
		// TODO Auto-generated method stub
		return 0;
	}

	public DriverPropertyInfo[] getPropertyInfo(String url,
			Properties properties) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean jdbcCompliant() {
		// TODO Auto-generated method stub
		return false;
	}

}
