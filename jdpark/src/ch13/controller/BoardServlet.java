package ch13.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import ch13.model.BoardDBBean;
import ch13.model.BoardDataBean;
import ch13.model.LoginDataBean;

/**
 * Servlet implementation class BoardServlet
 */
@WebServlet("*.do")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	   //request.setCharacterEncoding("UTF-8");
		//response.setCharacterEncoding("UTF-8");
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String uri = request.getRequestURI();//url를 긁어온다.
		System.out.println("############ uji uri:"+uri);//url중
		int lastIndex = uri.lastIndexOf("/");//uri중 /ch13/list.jsp
											 //list.jsp
		String action = uri.substring(lastIndex+1);//0 ~lastIndex+1까지 문자열 자르기
		System.out.println("############ uji uri:"+action);
		String viewPage = null;
		if(action.equals("write.do")) {// /ch13/write.do 입력하면 writeForm.jsp로 이동해라
			viewPage="writeForm.jsp";
		}
		if(action.equals("writePro.do")) {
			// ejkim.a for file upload // ejkim.test
			String realFolder = "";//웹 어플리케이션상의 절대 경로
			String filename = "";
					
			//파일이 업로드되는 폴더를 지정한다.
			String saveFolder = "/fileSave";
			String encType = "utf-8"; //엔코딩타입
			int maxSize = 5*1024*1024;  //최대 업로될 파일크기 5Mb

			ServletContext context = getServletContext();
			//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
			realFolder = context.getRealPath(saveFolder);  
			MultipartRequest multi = null;
			try{
			   //전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
			   //전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
			   multi = new MultipartRequest(request,realFolder, maxSize,encType,new DefaultFileRenamePolicy());
			   
			   //Form의 파라미터 목록을 가져온다
				// Enumeration<?> params = multi.getParameterNames();
			  
			   //전송한 파일 정보를 가져와 출력한다
			   Enumeration<?> files = multi.getFileNames();
			   //파일 정보가 있다면
			   while(files.hasMoreElements()){
			      //input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
			      String name = (String)files.nextElement();
			     //서버에 저장된 파일 이름
			      filename = multi.getFilesystemName(name);
			   }
			    BoardDataBean art = new BoardDataBean();
				art.setNum(Integer.parseInt(multi.getParameter("num")));
				art.setWriter(multi.getParameter("writer"));
				art.setSubject(multi.getParameter("subject"));
				art.setEmail(multi.getParameter("email"));
				art.setContent(multi.getParameter("content"));
				art.setPasswd(multi.getParameter("passwd"));
				art.setRef(Integer.parseInt(multi.getParameter("ref")));
				art.setRe_step(Integer.parseInt(multi.getParameter("re_step")));
				art.setRe_level(Integer.parseInt(multi.getParameter("re_level")));
				if(request.getParameter("subject")==null||request.getParameter("content")==null ||
						request.getParameter("passwd")==null) {
					System.out.print("다시입력");
					viewPage="writeForm.jsp";
				}
				art.setReg_date(new Timestamp(System.currentTimeMillis()));
				art.setIp(request.getRemoteAddr());
				// ejkim.a for file upload
				art.setFileName(filename);
				
				BoardDBBean dbPro = BoardDBBean.getInstance();
				dbPro.insertArticle(art);

			}catch(IOException ioe){
			 System.out.println(ioe);
			}catch(Exception ex){
			 System.out.println(ex);
			}
			viewPage="listShopping.jsp";
		}
		if (action.equals("updatePro.do")) {
			int check=0;
			String pageNum="";
			// ejkim.a for file upload
			String realFolder = "";// 웹 어플리케이션상의 절대 경로
			String filename = "";
			String saveFolder = "/fileSave";
			String encType = "utf-8"; // 엔코딩타입
			int maxSize = 5 * 1024 * 1024; // 최대 업로될 파일크기 5Mb
			ServletContext context = getServletContext();
			realFolder = context.getRealPath(saveFolder);
			MultipartRequest multi = null;
			try {
				multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
				Enumeration<?> files = multi.getFileNames();
				while (files.hasMoreElements()) {
					String name = (String) files.nextElement();
					filename = multi.getFilesystemName(name);
				}
				BoardDataBean art = new BoardDataBean();
				art.setNum(Integer.parseInt(multi.getParameter("num")));
				art.setWriter(multi.getParameter("writer"));
				art.setSubject(multi.getParameter("subject"));
				art.setEmail(multi.getParameter("email"));
				art.setContent(multi.getParameter("content"));
				art.setPasswd(multi.getParameter("passwd"));
				//TODO:
				// ejkim.a for file upload
				art.setFileName(filename);
				pageNum=multi.getParameter("pageNum");
				BoardDBBean dbPro = BoardDBBean.getInstance();
				check=dbPro.updateArticle(art); 
			} catch (IOException ioe) {
				System.out.println(ioe);
			} catch (Exception ex) {
				System.out.println(ex);
			}
			request.setAttribute("check", check);
			request.setAttribute("pageNum", pageNum);
			viewPage = "updatePro.jsp";
		}
		if (action.equals("list.do")) {

			viewPage = "listShoping.jsp";
		}
		if (action.equals("content.do")) {//글내용 보기 페이지
		   int num = Integer.parseInt(request.getParameter("num"));//사용자가 클릭한 글 번호
		   String pageNum = request.getParameter("pageNum");//몇번째 페이지 인지
		   try{
		      BoardDBBean dbPro = BoardDBBean.getInstance(); 
		      BoardDataBean article =  dbPro.getArticle(num);//글보기 
			  request.setAttribute("vo", article);
			  request.setAttribute("nicknameCheck",0);
		   	} catch(Exception e) {
		   		e.printStackTrace();
		   	}
		   request.setAttribute("num", num);
		   request.setAttribute("pageNum", pageNum);
			viewPage = "content.jsp";
		}
		if (action.equals("downloadPro.do")) {

		}
		if (action.equals("deletePro.do")) {
			int check = 0;
			int num = Integer.parseInt(request.getParameter("num"));
			String pageNum = request.getParameter("pageNum");
			String passwd = request.getParameter("passwd");
			try {//게시판 삭제
				
				BoardDBBean dbPro = BoardDBBean.getInstance();
				check = dbPro.deleteArticle(num, passwd);
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("check", check);
			viewPage = "deletePro.jsp";
		}

		//포워드를 시키는데 RequestDispatcher
				//RequestDispatcher는 클라이언트로부터 최초에 들어온 요청을 
				//JSP/Servlet 내에서 원하는 자원으로 요청을 넘기는(보내는) 역할을 수행하거나, 
				//특정 자원에 처리를 요청하고 처리 결과를 얻어오는 기능을 수행하는 클래스입니다.
		if(action.contentEquals("login.do")) {
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			//PrintWriter out  = response.getWriter();  한글이 깨진다.
		
			try {
					BoardDBBean dbPro = BoardDBBean.getInstance();
				    LoginDataBean logDb = dbPro.checkIdPw(id);
					if(logDb.getPwd() == null) {
						//id를 찾을 수 없음
						request.setAttribute("checkId", -1);
						viewPage = "shoppingLogin.jsp";
					}else if(pwd.equals(logDb.getPwd())) {//로그인 성공
						request.setAttribute("checkId",0);
						logDb.getId();
						request.getSession().setAttribute("id", id);
						request.getSession().setAttribute("nickname",logDb.getNickname());
						//request.setAttribute("checkId",1);
						request.setAttribute("check", 1);
						viewPage = "mypage.jsp";	
						//System.out.println("1"+request.getAttribute("nickname ") +""+logDb.getNickname() );
					}else {
							//pwd가 틀림
						request.setAttribute("checkId", 1);
						viewPage = "shoppingLogin.jsp";		
						
					}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(action.contentEquals("joinMembership.do")) {
			//input:text 입력된 값을 받아온다.
			String id = request.getParameter("idN");
			String pwdN = request.getParameter("pwdN");
			String pwdNe = request.getParameter("pwdNe");
			String nickname  = request.getParameter("nickname ");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String day = request.getParameter("day");
			String date_number = year+"년"+month+"월"+day+"일";

			String email1 = request.getParameter("email1");
			String email2 = request.getParameter("email2");
			String email =email1+"@"+email2;
			
			String address = request.getParameter("address");
			String tel1 = request.getParameter("tel1");
			String tel2 = request.getParameter("tel2");
			String tel3 = request.getParameter("tel3");
			String tel = tel1+"-"+tel2+"-"+tel3;
			try {
				//DB연동을 하기 위해  getInstance() 메소드를 선언해준다.
				BoardDBBean dbPro = BoardDBBean.getInstance();
				//닉네임을 한번더 체크 해준다.
				int nicNum = dbPro.NicknameCheck(nickname );
				//회원 가입 화면에 조건문을 실행 하기 위해 setAttribute를 해준다
				request.setAttribute("NicknameCheck", nicNum);
				if(nicNum==3) {//닉네임이 중복이 되지 않았다면 insertChecked메소드를 실행한다.
					int num = dbPro.insertChecked(id, pwdN, pwdNe, nickname , date_number, email, address, tel);
					//회원 가입 화면에 조건문을 실행 하기 위해 setAttribute를 해준다
					request.setAttribute("checkNum", num);
					//insertChecked메소드에서 리턴한 num값에 대한 조건문을 실행한다.
					if(num ==-1) {//가입 완료
						//다른 폼에서 쓰일 정보를 getSession을 해준다.
						request.getSession().setAttribute("id", id);
						request.getSession().setAttribute("nickname ",nickname );
					}
				}
				viewPage = "shoppingMemberShip.jsp";
			
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(action.contentEquals("mypageUpdate.do")) {
			//request.setCharacterEncoding("UTF-8");
			String pwd = request.getParameter("passwd");
			String Npwd1 = request.getParameter("newpass1");
			String Npwd2 = request.getParameter("newpass2");
			String newtel = request.getParameter("newtel");
			String newemail = request.getParameter("newemail");
			String newaddress = request.getParameter("newaddress");
			//response.setContentType("text/html;charset=UTF-8");
			
			try {
				String id =(String) request.getSession().getAttribute("id");
				BoardDBBean dbPro = BoardDBBean.getInstance();
			    LoginDataBean logDb = dbPro.checkIdPw(id);
				if(logDb.getPwd().equals(pwd)) {//비밀번호 일치할시
					if(Npwd1!=""||Npwd2!="") {//비밀번호 입력 했을시
						if(Npwd1.equals(Npwd2)){//비밀번호 변경
							dbPro.ProfileUpdate(Npwd2, newtel, newemail, newaddress, id);
							request.setAttribute("checkUpdate",1);
						}else{//입력한 비밀번호가 틀렸을시 
							
							 request.setAttribute("checkUpdate",2);
						}}else {//비밀번호 변경 안할시
							 dbPro.ProfileUpdate(pwd, newtel, newemail, newaddress, id);
							 request.setAttribute("checkUpdate",1);
						}
				 }else {//비밀번호 일치하지 않을시
					request.setAttribute("checkUpdate",3);
				 }
				viewPage = "mypageUpdate.jsp";
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(action.contentEquals("memberDelete.do")) {// 계정 삭제//
			String pwd = request.getParameter("pwd");
			String pwdCheck = request.getParameter("pwdCheck");
			String id =(String) request.getSession().getAttribute("id");
			//response.setContentType("text/html;charset=UTF-8");
			try {
				BoardDBBean dbPro = BoardDBBean.getInstance();
				LoginDataBean logDb = dbPro.checkIdPw(id);
				if(pwd!=""||pwdCheck!="") {
				if(pwd.equals(pwdCheck)) {
					if(logDb.getPwd().equals(pwd)){//진짜 비밀번호와 일치 회원 탈퇴 해준다.
						dbPro.MemberDelete(id);
						dbPro.BoardeDelete(logDb.getNickname());
						request.setAttribute("str","회원탈퇴 완료");
					}else {//진짜 비밀번호와 일치 하지 않음
						request.setAttribute("str","계정 비밀번호와 일치하지 않습니다.");
					}
				}else{//비밀번호와 비밀번호 재확인 입력이 일치하게 입력해주세요
					request.setAttribute("str","비밀번호와 재확인 비밀번호가 일치하지 않습니다.");
					}}else {//빈칸이 있습니다 다시 입력해주세요
						request.setAttribute("str","빈칸이 있습니다. 다시 입력해 주세요");
				}
				viewPage = "memberDelete.jsp";
			}catch(Exception e) {
				e.printStackTrace();
			}
		}if(action.contentEquals("nickname .do")) {
			//response.setContentType("text/html;charset=UTF-8");
			LoginDataBean logDb = new LoginDataBean();
			String id = request.getParameter("idN");
			String pwdN = request.getParameter("pwdN");
			String pwdNe = request.getParameter("pwdNe");
			String nickname  = request.getParameter("nickname ");
			String year = request.getParameter("year");
			String month = request.getParameter("month");
			String day = request.getParameter("day");
			String date_number = year+month+day;
			

			String email1 = request.getParameter("email1");
			String email2 = request.getParameter("email2");
			String email =email1+"@"+email2;
			
			String address = request.getParameter("address");
			String tel1 = request.getParameter("tel1");
			String tel2 = request.getParameter("tel2");
			String tel3 = request.getParameter("tel3");
			String tel = tel1+"-"+tel2+"-"+tel3;
			logDb.setNickname(nickname );
			logDb.setId(id);
			System.out.println("hh"+logDb.getNickname()+logDb.getPwd());


			try {
				BoardDBBean dbPro = BoardDBBean.getInstance();
				int num = dbPro.NicknameCheck(nickname );
				//request.setAttribute("NicnameCheck",num);
				request.getSession().setAttribute("NicknameCheck", num);
				viewPage = "shoppingMemberShip.jsp";
			}catch(Exception e) {
				e.printStackTrace();
		
		 }
		}
		if(action.contentEquals("getBoardList.do")) {
			String opt = request.getParameter("opt");
			String condition = request.getParameter("condition");
			String startRow = (String)request.getAttribute("startRow");
			String endRow = (String)request.getAttribute("endRow");
			
			try {
				BoardDBBean dbPro = BoardDBBean.getInstance();
			//	 List<BoardDataBean> article = dbPro.getBoardList(opt,condition,startRow,endRow);
				//request.setAttribute("NicnameCheck",num);
				//request.getSession().setAttribute("NicnameCheck", num);
				viewPage = "listShopping.jsp";
			}catch(Exception e) {
				e.printStackTrace();
		
		 }
		}
		//페이지를 넘겨 준다
		RequestDispatcher rDis = request.getRequestDispatcher(viewPage);
		rDis.forward(request,response);
	}
	
	
}
