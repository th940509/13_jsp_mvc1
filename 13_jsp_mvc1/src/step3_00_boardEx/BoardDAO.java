package step3_00_boardEx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardDAO {
	
	private BoardDAO() {}
	private static BoardDAO instance = new BoardDAO();
	public static BoardDAO getInstance() {
		return instance;
	}
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public Connection getConnection() {
		
		try{
			String jdbcUrl = "jdbc:mysql://localhost:3306/step3_board_ex?serverTimezone=UTC";
			String dbId    = "root";
			String dbPass  = "1234";
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			conn = DriverManager.getConnection(jdbcUrl , dbId , dbPass);
		} catch(Exception e){
			e.printStackTrace();
		}
		return conn;
	}
	
	//게시글을 추가하는 DAO
	public void insertBoard(BoardDTO bdto) {
		
		conn = getConnection();
		String sql = "INSERT INTO BOARD (WRITER,EMAIL,SUBJECT,PASSWORD,REG_DATE,READ_COUNT,CONTENT)";
			   sql += "VALUES(?,?,?,?,NOW(),0,?)";
			   	
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bdto.getWriter());
			pstmt.setString(2, bdto.getEmail());
			pstmt.setString(3, bdto.getSubject());
			pstmt.setString(4, bdto.getPassword());
			pstmt.setString(5, bdto.getContent());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)  try {conn.close();}  catch (Exception e) {e.printStackTrace();}
		}
	}
	
	//전체 게시글을 조회하는 DAO
	public ArrayList<BoardDTO> getAllBoard() {
		
		ArrayList<BoardDTO> boardList = new ArrayList<BoardDTO>();
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from board");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO bdto = new BoardDTO();
				bdto.setNum(rs.getInt("num"));
				bdto.setWriter(rs.getString("writer"));
				bdto.setEmail(rs.getString("email"));
				bdto.setSubject(rs.getString("subject"));
				bdto.setPassword(rs.getString("password"));
				bdto.setRegDate(rs.getDate("reg_date"));
				bdto.setReadCount(rs.getInt("read_count"));
				bdto.setContent(rs.getString("content"));
				
				boardList.add(bdto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null)    try {rs.close();}    catch (Exception e) {e.printStackTrace();}
			if(pstmt!=null) try {pstmt.close();} catch (Exception e) {e.printStackTrace();}
			if(conn!=null)  try {conn.close();}  catch (Exception e) {e.printStackTrace();}
		}
		
		return boardList;
		
	}
	
	// 하나의 게시글을 조회하는 DAO
		public BoardDTO getOneBoard(int num) {

			BoardDTO bdto = new BoardDTO();

			try {
				
				conn = getConnection();

				pstmt = conn.prepareStatement("UPDATE BOARD SET READ_COUNT=READ_COUNT+1 WHERE NUM=?");
				pstmt.setInt(1, num);
				pstmt.executeUpdate();

				pstmt = conn.prepareStatement("SELECT * FROM BOARD WHERE NUM=?");
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					bdto.setNum(rs.getInt(1));
					bdto.setWriter(rs.getString(2));
					bdto.setEmail(rs.getString(3));
					bdto.setSubject(rs.getString(4));
					bdto.setPassword(rs.getString(5));
					bdto.setRegDate(rs.getDate(6));
					bdto.setReadCount(rs.getInt(7));
					bdto.setContent(rs.getString(8));
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (rs != null)    {try {rs.close();}    catch (SQLException e) {}}
				if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
				if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
			}
			
			return bdto;
			
		}

		// 수정할 게시글을 조회하는 DAO
		public BoardDTO getOneUpdateBoard(int num) {

			BoardDTO bdto = new BoardDTO();

			try {
				
				conn = getConnection();
				pstmt = conn.prepareStatement("SELECT * FROM BOARD WHERE NUM=?");
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if (rs.next()) {
					bdto.setNum(rs.getInt(1));
					bdto.setWriter(rs.getString(2));
					bdto.setEmail(rs.getString(3));
					bdto.setSubject(rs.getString(4));
					bdto.setPassword(rs.getString(5));
					bdto.setRegDate(rs.getDate(6));
					bdto.setReadCount(rs.getInt(7));
					bdto.setContent(rs.getString(8));
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (rs != null)    {try {rs.close();}    catch (SQLException e) {}}
				if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
				if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
			}
			
			return bdto;
			
		}

		
		// 비밀번호를 인증하는 DAO
		public boolean validMemberCheck(BoardDTO boardDTO) {

			boolean isValidMember = false;
			
			try {
				
				conn = getConnection();
				pstmt = conn.prepareStatement("SELECT * FROM BOARD WHERE NUM=? AND PASSWORD=?");
				pstmt.setInt(1, boardDTO.getNum());
				pstmt.setString(2, boardDTO.getPassword());
				rs = pstmt.executeQuery();

				if (rs.next()) 	isValidMember = true;

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (rs != null)    {try {rs.close();}    catch (SQLException e) {}}
				if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
				if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
			}

			return isValidMember;
			
		}

		// 게시글을 수정하는 DAO
		public boolean updateBoard(BoardDTO boardDTO) {

			boolean isUpdate = false;
			
			try {
				
				if (validMemberCheck(boardDTO)) {
					conn = getConnection();
					pstmt = conn.prepareStatement("UPDATE board SET SUBJECT=?, CONTENT=? WHERE NUM=?");
					pstmt.setString(1, boardDTO.getSubject());
					pstmt.setString(2, boardDTO.getContent());
					pstmt.setInt(3, boardDTO.getNum());
					pstmt.executeUpdate();
					isUpdate = true;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
				if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
			}
			
			return isUpdate;
			
		}

		
		// 게시글을 삭제하는 DAO
		public boolean deleteBoard(BoardDTO boardDTO) {

			boolean isDelete = false;
			
			try {
				
				if (validMemberCheck(boardDTO)) {
					conn = getConnection();
					pstmt = conn.prepareStatement("DELETE FROM BOARD WHERE NUM=?");
					pstmt.setInt(1, boardDTO.getNum());
					pstmt.executeUpdate();
					isDelete = true;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (pstmt != null) {try {pstmt.close();} catch (SQLException e) {}}
				if (conn != null)  {try {conn.close();}  catch (SQLException e) {}}
			}
			
			return isDelete;
			
		}
		
	}

