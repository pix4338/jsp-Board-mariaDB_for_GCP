package ch13.model;

import java.awt.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Vector;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ProductDBean {
		private static ProductDBean instance = new ProductDBean();
		//.jps페이지에서 DB연동빈인 BoardDBBean클래스의 메소드에 접근시 필요
		public static ProductDBean getInstance() {
			return instance;
		}
		private ProductDBean() {}
		
		//커넥션 풀로 부터 Connection객체를 얻어냄
		private Connection getConnection()throws Exception{//연결
			Context initCtx = new InitialContext(); 
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource)envCtx.lookup("jdbc/mariadb");
			return ds.getConnection();
	    }
		
		//상품의 내용을 가져오는 메소드
		public Vector<ProductDataBean> getSelectProduct(int disision,int startRow, int endRow)
				throws Exception{
			Vector<ProductDataBean> v = new Vector();
			Connection conn=null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				String sql = "SELECT A.* FROM (SELECT ROW_NUMBER() OVER() AS RNUM , P.* FROM"
		        		+ "(SELECT * FROM product WHERE DIVISION = ? ORDER BY NO DESC ) P )A"
		        		+ " WHERE RNUM >= ? and RNUM <= ?";
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setInt(1, disision);
		        pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
		        rs = pstmt.executeQuery();
		        	if (rs.next()) {
		        		v = new Vector<ProductDataBean>(endRow);
			            do{
			            	ProductDataBean pData = new ProductDataBean();
			            	pData.setName(rs.getString("name"));
							pData.setDivision(rs.getInt("Division"));
							pData.setPrice(rs.getInt("Price"));
							pData.setCount(rs.getInt("Count"));
							pData.setImg(rs.getString("Img"));
							pData.setInfo(rs.getString("Info"));
							pData.setNo(rs.getInt("no"));
							v.add(pData);
					    }while(rs.next());
					}
			}catch(Exception e) {
				
			} finally {
		        closeDBResources(rs, pstmt, conn);
		    }
			return v;
		}
		public ProductDataBean getSelectProductInfo(int no)
				throws Exception{
			ProductDataBean pData = null;
			Connection conn=null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				conn = getConnection();
				String sql = "select * from product where no = ?";
//				"SELECT * FROM PRODUCT WHERE NO = ?"
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, no);
				rs = pstmt.executeQuery();
				//int count =0;
				while(rs.next()) {
					pData = new ProductDataBean ();
					pData.setName(rs.getString("name"));
					pData.setDivision(rs.getInt("Division"));
					pData.setPrice(rs.getInt("Price"));
					pData.setCount(rs.getInt("Count"));
					pData.setImg(rs.getString("Img"));
					pData.setInfo(rs.getString("Info"));
					pData.setNo(rs.getInt("no"));
					
				}
				
			}catch(Exception e) {
				
			} finally {
		        closeDBResources(rs, pstmt, conn);
		    }
			return pData;
		}
		public List<ProductDataBean> getProductDatas(int disision,int startRow, int endRow)
		         throws Exception {
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    List<ProductDataBean> pList = null;
		    try {
		        conn = getConnection();
		        //SELECT * FROM (SELECT ROWNUM
		        String sql =  "SELECT A.* FROM (SELECT ROW_NUMBER() OVER() AS RNUM , P.* FROM"
		        		+ "(SELECT * FROM product WHERE DIVISION = ? ORDER BY NO DESC ) P )A"
		        		+ " WHERE RNUM >= ? and RNUM <= ?;";
		        
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setInt(1, disision);
		        pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
		        rs = pstmt.executeQuery();
		
		        if (rs.next()) {
		        	pList = new ArrayList<ProductDataBean>(endRow);//?
		            do{
		            	ProductDataBean pData = new ProductDataBean();
		            	pData.setName(rs.getString("name"));
						pData.setDivision(rs.getInt("Division"));
						pData.setPrice(rs.getInt("Price"));
						pData.setCount(rs.getInt("Count"));
						pData.setImg(rs.getString("Img"));
						pData.setInfo(rs.getString("Info"));
						pData.setNo(rs.getInt("no"));
						pList.add(pData);
				    }while(rs.next());
				}
		    } catch(Exception ex) {
		        ex.printStackTrace();
		    } finally {
		    	closeDBResources(rs, pstmt, conn);
		    }
			return pList;
		}
		//상품의 개수를 가져오는 메소드
		public int getProductCount(int division) throws Exception {
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    int x=0;
		    try {
		        conn = getConnection();
		        pstmt = conn.prepareStatement("select count(*) from product where division = ?");
//		        SELECT COUNT(*) FROM PRODUCT WHERE DIVISION = ?
		        pstmt.setInt(division, 1);
		        rs = pstmt.executeQuery();
		        if (rs.next()) {
		           x= rs.getInt(1);
				}
		    } catch(Exception ex) {
		        ex.printStackTrace();
		    } finally {
		        closeDBResources(rs, pstmt, conn);
		    }
			return x;
		}
		
		 private void closeDBResources(ResultSet rs, Statement stmt, Connection conn) {
				if (rs != null) {
					try {
						rs.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (stmt != null) {
					try {
						stmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			private void closeDBResources(ResultSet rs, PreparedStatement pstmt, Connection conn) {
				if (rs != null) {
					try {
						rs.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			private void closeDBResources(PreparedStatement pstmt, Connection conn) {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			private void closeDBResources(Statement stmt, Connection conn) {
				if (stmt != null) {
					try {
						stmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (conn != null) {
					try {
						conn.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			private void closeDBResources(ResultSet rs, PreparedStatement pstmt) {
				if (rs != null) {
					try {
						rs.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			private void closeDBResources(PreparedStatement pstmt) {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}


		}


