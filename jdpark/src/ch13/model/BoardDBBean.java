package ch13.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.*;
import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.sql.*;


import java.net.InetAddress;

public class BoardDBBean {
	private static BoardDBBean instance = new BoardDBBean();
	//.jps페이지에서 DB연동빈인 BoardDBBean클래스의 메소드에 접근시 필요
	public static BoardDBBean getInstance() {
		return instance;
	}
	private BoardDBBean() {}
	
	//커넥션 풀로 부터 Connection객체를 얻어냄
	private Connection getConnection()throws Exception{//연결
		Context initCtx = new InitialContext(); 
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/mariadb"); //oracledb를 mariadb형식으로 변경해야함
		return ds.getConnection();
    }
	public void insertArticle(BoardDataBean article) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int num = article.getNum();
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
		int number = 0;
		String sql = "";
		
		try {
			conn = getConnection();
			if(conn==null)
				System.out.println("fail");
			else
				System.out.println("Connected");
			sql = "select max(num) from boarde";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				number = rs.getInt(1) + 1;
			} else {
				number = 1;
			}
			closeDBResources(rs, pstmt);			
			if(num!=0) {  // 댓글
				sql = "update boarde set re_step=re_step+1 where ref=? and re_step>?";
//				"UPDATE BOARDE SET RE_STEP=RE_STEP+1 WHERE REF=? AND RE_STEP>?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step+1;
				re_level = re_level+1;
			} else {  // 원본글쓰기 - 댓글x
				ref = number;
				re_step = 0;
				re_level = 0;				
			}
			closeDBResources(rs, pstmt);			
			// ejkim.m for to add filename
			sql="insert into boarde (num, writer, email, subject, passwd, reg_date, ";
					sql+=" ref, re_step, re_level, content, ip, filename) "
							+ " values (?,?,?,?,?,?,?,?,?,?,?,?)";
//					sql="INSERT INTO BOARDE (NUM, WRITER, EMAIL, SUBJECT, PASSWD, REG_DATE, "; 
//					sql+=" REF, RE_STEP, RE_LEVEL, CONTENT, IP, FILENAME) " 
//					+ " VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
            pstmt.setString(2, article.getWriter());
            pstmt.setString(3, article.getEmail());
            pstmt.setString(4, article.getSubject());
            pstmt.setString(5, article.getPasswd());
			pstmt.setTimestamp(6, article.getReg_date());
            pstmt.setInt(7, ref);
            pstmt.setInt(8, re_step);
            pstmt.setInt(9, re_level);
			pstmt.setString(10, article.getContent());
			pstmt.setString(11, article.getIp());
			// ejkim.m for to add filename
			pstmt.setString(12, article.getFileName());
			pstmt.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			closeDBResources(rs, pstmt, conn);
		}
	}
	
	//boarde테이블에 저장된 전체글의 수를 얻어냄(select문)<=list.jsp에서 사용
	public int getArticleCount() throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int x=0;
	    try {
	        conn = getConnection();
	        pstmt = conn.prepareStatement("select count(*) from boarde");
//	        "SELECT COUNT(*) FROM BOARDE"
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
	
	//글의 목록(복수개의 글)을 가져옴(select문) <=list.jsp에서 사용
	public List<BoardDataBean> getArticles(int start, int end)
	         throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<BoardDataBean> articleList = null;
	    try {
	        conn = getConnection();
	
	        // BoardDAO - boardList 메서드 - 페이징 처리
	        //String sql = "select * from boarde order by ref desc, re_step asc limit ?,? ";
	        // ejkim.m for oracle
	        String sql =   "SELECT A.* FROM "
					+ " (SELECT ROW_NUMBER() OVER() AS rnum, B.* FROM "
									+ " ( SELECT * FROM boarde ORDER BY ref desc, re_step asc ) B )A ";
	        sql += " WHERE rnum >= ? and rnum <= ?";
//             sql = "SELECT * FROM " 
//            		+ " (SELECT ROWNUM RNUM, B.* FROM " 
//            		+ " ( SELECT * FROM BOARDE ORDER BY REF DESC, RE_STEP ASC ) B ) "; 
//            		sql += " WHERE RNUM >= ? AND RNUM <= ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, start);
			pstmt.setInt(2, end);
	        rs = pstmt.executeQuery();
	
	        if (rs.next()) {
	            articleList = new ArrayList<BoardDataBean>(end);//?
	            do{
	              BoardDataBean article= new BoardDataBean();
				  article.setNum(rs.getInt("num"));
				  article.setWriter(rs.getString("writer"));
	              article.setEmail(rs.getString("email"));
	              article.setSubject(rs.getString("subject"));
	              article.setPasswd(rs.getString("passwd"));
			      article.setReg_date(rs.getTimestamp("reg_date"));
				  article.setReadcount(rs.getInt("readcount"));
	              article.setRef(rs.getInt("ref"));
	              article.setRe_step(rs.getInt("re_step"));
				  article.setRe_level(rs.getInt("re_level"));
	              article.setContent(rs.getString("content"));
			      article.setIp(rs.getString("ip")); 
			      // ejkim.a for file download
			      article.setFileName(rs.getString("filename"));
	              articleList.add(article);
			    }while(rs.next());
			}
	    } catch(Exception ex) {
	        ex.printStackTrace();
	    } finally {
	    	closeDBResources(rs, pstmt, conn);
	    }
		return articleList;
	}
	

	//글의 내용을 보기(1개의 글)(select문)<=content.jsp페이지에서 사용
	public BoardDataBean getArticle(int num)    throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardDataBean article=null;
        try {
            conn = getConnection();
//글의 조회수 추가하기
            pstmt = conn.prepareStatement("update boarde set readcount=readcount+1 where num = ?");
//			"UBOARDEBOARDE SET READCOUNT=READCOUNT+1 WHERE NUM = ?"
            pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			closeDBResources(pstmt);  
			//글번호 검색
            pstmt = conn.prepareStatement("select * from boarde where num = ?");
//            "SELECT * FROM BOARDE WHERE NUM = ?"
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                article = new BoardDataBean();
                article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
                article.setEmail(rs.getString("email"));
                article.setSubject(rs.getString("subject"));
                article.setPasswd(rs.getString("passwd"));
			    article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
                article.setRef(rs.getInt("ref"));
                article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
                article.setContent(rs.getString("content"));
			    article.setIp(rs.getString("ip"));     
			    // ejkim.a for file download
			    article.setFileName(rs.getString("filename"));
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
        	closeDBResources(rs, pstmt, conn);
        }
		return article;
    }
	
	

	//글 수정폼에서 사용할 글의 내용(1개의 글)(select문)<=updateForm.jsp에서 사용
    public BoardDataBean updateGetArticle(int num)
          throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        BoardDataBean article=null;
        try {
            conn = getConnection();

            pstmt = conn.prepareStatement(
            	"select * from boarde where num = ?");
//            "SELECT * FROM BOARDE WHERE NUM = ?"
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                article = new BoardDataBean();
                article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
                article.setEmail(rs.getString("email"));
                article.setSubject(rs.getString("subject"));
                article.setPasswd(rs.getString("passwd"));
			    article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
                article.setRef(rs.getInt("ref"));
                article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
                article.setContent(rs.getString("content"));
                
			    article.setIp(rs.getString("ip"));     
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
        	closeDBResources(rs, pstmt, conn);
        }
		return article;
    }
    

    //글 수정처리에서 사용(update문)<=updatePro.jsp에서 사용
    public int updateArticle(BoardDataBean article)
          throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;

        String dbpasswd="";
        String sql="";
		int x=-1;
        try {
            conn = getConnection();
            
			pstmt = conn.prepareStatement(
            	"select passwd from boarde where num = ?");
//			"SELECT PASSWD FROM BOARDE WHERE NUM = ?"
            pstmt.setInt(1, article.getNum());
            rs = pstmt.executeQuery();
            
			if(rs.next()){
			  dbpasswd= rs.getString("passwd"); 
			  if(dbpasswd.equals(article.getPasswd())){
                sql="update boarde set writer=?,email=?,subject=?,passwd=?";
			    sql+=",content=? where num=?";
//			    sql="UPDATE BOARDE SET WRITER=?,EMAIL=?,SUBJECT=?,PASSWD=?"; 
//			    sql+=",CONTENT=? WHERE NUM=?";
			    if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}  // ejkim.a for warning
			    
                pstmt = conn.prepareStatement(sql);

                pstmt.setString(1, article.getWriter());
                pstmt.setString(2, article.getEmail());
                pstmt.setString(3, article.getSubject());
                pstmt.setString(4, article.getPasswd());
                pstmt.setString(5, article.getContent());
			    pstmt.setInt(6, article.getNum());
                pstmt.executeUpdate();
				x= 1;
			  }else{
				x= 0;
			  }
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
    }
    
    //글삭제처리시 사용(delete문)<=deletePro.jsp페이지에서 사용
    public int deleteArticle(int num, String passwd)
        throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        String dbpasswd="";
        int x=-1;
        try {
			conn = getConnection();

            pstmt = conn.prepareStatement(
            	"select passwd from boarde where num = ?");
//            "SELECT PASSWD FROM BOARDE WHERE NUM = ?"
            pstmt.setInt(1, num);
            rs = pstmt.executeQuery();
            
			if(rs.next()){
				dbpasswd= rs.getString("passwd"); 
				if(dbpasswd.equals(passwd)){
					if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}  // ejkim.a for warning
					pstmt = conn.prepareStatement(
            	      "delete from boarde where num=?");
//					"DELETE FROM BOARDE WHERE NUM=?"
                    pstmt.setInt(1, num);
                    pstmt.executeUpdate();
					x= 1; //글삭제 성공
				}else
					x= 0; //비밀번호 틀림
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
            closeDBResources(rs, pstmt, conn);
        }
		return x;
    }
    
    public LoginDataBean checkIdPw(String id) throws Exception {
    	String pwd = null;
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        LoginDataBean logDb = new LoginDataBean();
        try {
			conn = getConnection();
            pstmt = conn.prepareStatement(
            	"select pwd, nickname, email from member where id= ?");
//            "SELECT PWD, NICKNAME, EMAIL FROM MEMBER WHERE ID= ?"
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            
			if(rs.next()){
				logDb.setPwd(rs.getString("pwd"));
				logDb.setNickname(rs.getString("nickname"));
				logDb.setEmail(rs.getString("email"));
			}
        } catch(Exception ex) {
            ex.printStackTrace();
        } finally {
        	closeDBResources(rs, pstmt, conn);
        }
    	return logDb;
    }
    
public int insertChecked(String id,String pwdN,String pwdNe,String nickname, String date_number,String email,String address,String tel ) 
	throws Exception {
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs= null;
        String sql ="";
        String coment ="";
        int num = -1;//회원 가입 완료시 -1
        LoginDataBean article=null;
        Timestamp reg_date = new Timestamp(System.currentTimeMillis());
        try {
        	conn = getConnection();
        	sql = "select id from member where id=?";
//        	"SELECT ID FROM MEMBER WHERE ID=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs=pstmt.executeQuery();
			if(rs.next()){//중복된 아이디가 있음
				num = 1;
				}else if(id.equals("")||pwdNe.equals("")){
					num = 2;//빈칸이 있음
						}else {//아이디가 중복 되지도 않고 아이디,비밀번호에 빈칸이 없다면
							if(pwdN.equals(pwdNe)) {//입력한 비밀번호가 일치한다면 
								//가입완료
								sql = "insert into member (id,pwd,date_number,email,address,tel,nickname,reg_date) values (?,?,?,?,?,?,?,?)";
//								 = "INSERT INTO MEMBER(ID,PWD,DATE_NUMBER,EMAIL,ADDRESS,TEL,NICKNAME,REG_DATE) VALUES (?,?,?,?,?,?,?,?)"; 
								pstmt = conn.prepareStatement(sql);
								pstmt.setString(1,id);
								pstmt.setString(2,pwdN);
								pstmt.setString(3,date_number);
								pstmt.setString(4,email);
								pstmt.setString(5,address);
								pstmt.setString(6,tel);
								pstmt.setString(7,nickname);
								pstmt.setTimestamp(8, reg_date);
								pstmt.executeUpdate();
								System.out.println(nickname+"님환영합니다.");;
							}else {//입력한 비밀번호가 일치하지 않는다면
								num = 3;
							}
						}
    } catch(Exception ex) {
    ex.printStackTrace();
    } finally {
	closeDBResources(rs, pstmt, conn);
    }
return num;
}
    public LoginDataBean ProfileSelect(String id) {
    	Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LoginDataBean logDb = new LoginDataBean();

    try{
    conn = getConnection();
	String sql = "select * from member where id =?";
//	"SELECT * FROM MEMBER WHERE ID =?"
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,id);
	rs = pstmt.executeQuery();
    
	if(rs.next()){
		logDb.setId( rs.getString("id"));
		logDb.setDate_number( rs.getString("date_number"));
		logDb.setEmail( rs.getString("email"));
		logDb.setAddress(  rs.getString("address"));
		logDb.setTel(rs.getString("tel"));
		logDb.setNickname(rs.getString("nickname"));
    	} }catch(Exception ex) {
    	    ex.printStackTrace();
        } finally {
    	closeDBResources(rs, pstmt, conn);
        }
	return logDb;
    }
    
    public LoginDataBean ProfileUpdate(String pwd,String tel,String email,String address,String id) {
    	Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LoginDataBean logDb = new LoginDataBean();

    try{
    conn = getConnection(); //
	String sql = "update member set pwd =?,tel =?, email =?, address =? where id =?";
//	 "UPDATE MEMBER SET PWD =?,TEL =?, EMAIL =?, ADDRESS =? WHERE ID =?"; 
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,pwd);
	pstmt.setString(2,tel);
	pstmt.setString(3,email);
	pstmt.setString(4,address);
 	pstmt.setString(5,id);
	pstmt.executeUpdate();

    	}catch(Exception ex) {
    	    ex.printStackTrace();
        } finally {
    	closeDBResources(rs, pstmt, conn);
        }
	return logDb;
    }
    
    public void MemberDelete(String id) {
    	ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;
		String sql = "";
    	try {
    		conn = getConnection();
    		sql="delete from member where id=?";
//    		"DELETE FROM MEMBER WHERE ID=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.executeUpdate();
			System.out.println("회원 삭제완료");
	    }catch(Exception ex) {
		    ex.printStackTrace();
	    } finally {
		closeDBResources(rs, pstmt, conn);
	    } 
    }
    public void BoardeDelete(String nickname) {
    	ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = null;
		String sql = "";
    	try {
    		conn = getConnection();
    		sql="delete from boarde where writer=?";
//    		"DELETE FROM BOARDE WHERE WRITER=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,nickname);
			pstmt.executeUpdate();
			System.out.println("회원글 삭제완료");
	    }catch(Exception ex) {
		    ex.printStackTrace();
	    } finally {
		closeDBResources(rs, pstmt, conn);
	    } 
    }
    public int NicknameCheck(String nickname) 
    		throws Exception {
    	    	Connection conn = null;
    	        PreparedStatement pstmt = null;
    	        ResultSet rs= null;
    	        String sql ="";
    	        String coment ="";
    	        int num = 0;
    	        LoginDataBean article=null;
    	        try {
    	        	conn = getConnection();
    	        	sql = "select nickname from member where nickname=?";
//    	        	"SELECT NICKNAME FROM MEMBER WHERE NICKNAME=?";
    				pstmt = conn.prepareStatement(sql);
    				pstmt.setString(1,nickname);
    				rs=pstmt.executeQuery();
    				if(rs.next()){//"이미 사용중인 닉네임입니다."
    					num =1;
    					}else if(nickname.equals("")){//닉네임을 입력해주세요
    						num = 2;
	    					}else { //닉네임 사용 가능
	    						num = 3;		    						
    		}} catch(Exception ex) {
    			ex.printStackTrace();
    	    } finally {
    	    	closeDBResources(rs, pstmt, conn);
    	    }
    	return num;
    	}
    
    public List<BoardDataBean> getBoardList(String opt,String condition,int start, int end)
    throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
    	 List<BoardDataBean> articleList = null;
    	// ArrayList<BoardDataBean> list = new ArrayList<BoardDataBean>();
		/*int num = article.getNum();
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();*/
		
		try {
			conn = getConnection();
          //  StringBuffer sql = new StringBuffer();
            
            // 글목록 전체를 보여줄 때
            if(opt == null)
            {
                // BOARD_RE_REF(그룹번호)의 내림차순 정렬 후 동일한 그룹번호일 때는
                // BOARD_RE_SEQ(답변글 순서)의 오름차순으로 정렬 한 후에
                // 10개의 글을 한 화면에 보여주는(start번째 부터 start+9까지) 쿼리
                // desc : 내림차순, asc : 오름차순 ( 생략 가능 )
//            	SELECT * FROM "(SELECT ROWNUM
            	String sql = "SELECT A.* FROM " 
                      + " (SELECT ROW_NUMBER() OVER() AS RNUM, B.* FROM " 
                      + " ( SELECT * FROM boarde ORDER BY REF DESC, RE_STEP ASC ) B )A "; 
                      sql += " WHERE RNUM >= ? AND RNUM <= ?";
//                "SELECT A.* FROM " 
//                + " (SELECT ROW_NUMBER() OVER() AS RNUM, B.* FROM " 
//                + " ( SELECT * FROM BOARDE ORDER BY REF DESC, RE_STEP ASC ) B )A "; 
//                sql += " WHERE RNUM >= ? AND RNUM <= ?"
                
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, start);
                pstmt.setInt(2, end);
                
                // StringBuffer를 비운다.
              //  sql.delete(0, sql.toString().length());
            }
            else if(opt.equals("0")) // 제목으로 검색
            {
            	String sql = "SELECT A.* FROM " 
                      + " (SELECT ROW_NUMBER() OVER() AS RNUM, B.* FROM " 
                      + " ( SELECT * FROM boarde WHERE SUBJECT LIKE ? ORDER BY REF DESC, RE_STEP ASC ) B )A "; 
                      sql += " WHERE RNUM >= ? AND RNUM <= ?";
//                "SELECT A.* FROM " 
//                + " (SELECT ROW_NUMBER() OVER() AS RNUM, B.* FROM " 
//                + " ( SELECT * FROM BOARDE WHERE SUBJECT LIKE ? ORDER BY REF DESC, RE_STEP ASC ) B )A "; 
//                sql += " WHERE RNUM >= ? AND RNUM <= ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%"+condition+"%");
                pstmt.setInt(2, start);
                pstmt.setInt(3, end);
                
              //  sql.delete(0, sql.toString().length());
            }
            else if(opt.equals("1")) // 내용으로 검색
            {
            	String  sql = "SELECT A.* FROM " 
                		+ " (SELECT ROW_NUMBER() OVER() AS RNUM, B.* FROM " 
                		+ " ( SELECT * FROM boarde WHERE CONTENT LIKE ? ORDER BY REF DESC, RE_STEP ASC ) B )A "; 
                		sql += " WHERE RNUM >= ? AND RNUM <= ?";
               
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%"+condition+"%");
                pstmt.setInt(2, start);
                pstmt.setInt(3, end);
                
              //  sql.delete(0, sql.toString().length());
            }
            else if(opt.equals("2")) // 제목+내용으로 검색
            {
            	String sql = "SELECT A.* FROM " 
                      + " (SELECT ROW_NUMBER() OVER() AS RNUM, B.* FROM " 
                      + " ( SELECT * FROM boarde WHERE SUBJECT LIKE ? OR ONTENT LIKE ?" 
                      + " ORDER BY REF DESC, RE_STEP ASC ) B )A "; 
                      sql += " WHERE RNUM >= ? AND RNUM <= ?";
//                
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%"+condition+"%");
                pstmt.setString(2, "%"+condition+"%");
                pstmt.setInt(2, start);
                pstmt.setInt(3, end);
                
               // sql.delete(0, sql.toString().length());
            }
            else if(opt.equals("3")) // 글쓴이로 검색
            {
            	String sql =  "SELECT A.* FROM " 
                      + " (SELECT ROW_NUMBER() OVER() AS RNUM, B.* FROM " 
                      + " ( SELECT * FROM BOARDE WHERE WRITER LIKE ? ORDER BY REF DESC, RE_STEP ASC ) B )A "; 
                      sql += " WHERE RNUM >= ? AND RNUM <= ?";
//                "SELECT A.* FROM " 
//                + " (SELECT ROW_NUMBER() OVER() AS RNUM, B.* FROM " 
//                + " ( SELECT * FROM BOARDE WHERE WRITER LIKE ? ORDER BY REF DESC, RE_STEP ASC ) B )A "; 
//                sql += " WHERE RNUM >= ? AND RNUM <= ?";
                
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%"+condition+"%");
                pstmt.setInt(2, start);
                pstmt.setInt(3, end);
                
               // sql.delete(0, sql.toString().length());
            }
            
            rs = pstmt.executeQuery();
            if (rs.next()) {
	            articleList = new ArrayList<BoardDataBean>(end);//?
	            do{
	              BoardDataBean article= new BoardDataBean();
				  article.setNum(rs.getInt("num"));
				  article.setWriter(rs.getString("writer"));
	              article.setEmail(rs.getString("email"));
	              article.setSubject(rs.getString("subject"));
	              article.setPasswd(rs.getString("passwd"));
			      article.setReg_date(rs.getTimestamp("reg_date"));
				  article.setReadcount(rs.getInt("readcount"));
	              article.setRef(rs.getInt("ref"));
	              article.setRe_step(rs.getInt("re_step"));
				  article.setRe_level(rs.getInt("re_level"));
	              article.setContent(rs.getString("content"));
			      article.setIp(rs.getString("ip")); 
			      // ejkim.a for file download
			      article.setFileName(rs.getString("filename"));
	              articleList.add(article);
			    }while(rs.next());
            

			}}catch(Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            closeDBResources(rs, pstmt, conn);
	        }
			return articleList;
	    }
    
    public int getSearchArticleCount(String opt, String condition) throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int x=0;
	    try {
	    	conn = getConnection();
	    	 if(opt.equals("0")) // 제목으로 검색
	            {
	                pstmt = conn.prepareStatement("SELECT count(*) FROM boarde where SUBJECT like ? ");
//	                SELECT COUNT(*) FROM BOARDE WHERE SUBJECT LIKE ?
	                pstmt.setString(1, "%"+condition+"%");

	              //  sql.delete(0, sql.toString().length());
	            }
	    	else if(opt.equals("1")) // 내용으로 검색
            {
	            pstmt = conn.prepareStatement("select count(*) from boarde where CONTENT  like ? ");
//	            "SELECT COUNT(*) FROM BOARDE WHERE CONTENT LIKE ? "
                pstmt.setString(1, "%"+condition+"%");
            }
            else if(opt.equals("2")) // 제목+내용으로 검색
            {   
            	pstmt = conn.prepareStatement("SELECT count(*) FROM boarde where SUBJECT like ? OR ONTENT like ?");
//            	"SELECT COUNT(*) FROM BOARDE WHERE SUBJECT LIKE ? OR ONTENT LIKE ?"
                pstmt.setString(1, "%"+condition+"%");
                pstmt.setString(2, "%"+condition+"%");
               // sql.delete(0, sql.toString().length());
            }
            else if(opt.equals("3")) // 글쓴이로 검색
            {
            	
                pstmt = conn.prepareStatement("SELECT count(*) FROM boarde where writer like ? ");
//                "SELECT COUNT(*) FROM BOARDE WHERE WRITER LIKE ? "
                pstmt.setString(1, "%"+condition+"%");
                
               // sql.delete(0, sql.toString().length());
            }
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


























