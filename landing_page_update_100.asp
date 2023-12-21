<!--#include virtual="/ad/common/inc/config_basic.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%
	'=== Open DB ================================================================================
	Set db = Open_DB(main_db)

	'=== POST 값이 아닌 경우 ========================================================================
'	If Request.ServerVariables("REQUEST_METHOD") <> "POST" Then
'		Alert_Window("잘못된 처리 요청입니다!!")
'		Response.End
'	End If

	On Error Resume Next
	Dim err_cnt : err_cnt = 0
	
	'=== Request Values ===========================================================================
	l_idkey			= trim(request("l_idkey"))
	user_name		= trim(request("NAME"))
	user_age		= trim(request("q3"))
	user_sex		= trim(request("SEX"))
	u_htel1			= trim(request("HP1"))
	u_htel2			= trim(request("HP2"))
	u_htel3			= trim(request("HP3"))
	user_remark		= trim(request("q2"))
	device_page		= trim(request("device_page"))
	quickphone		= trim(request.QueryString("phone"))
	cate			= trim(request("cate"))
	service			= trim(request("q1"))
	ip				= trim(Request.QueryString("ip"))




	Call getDeviceInfo()

	
	'=== injection 이름  =============================================================================
	
	user_name = Replace(user_name, "\", "")
	user_name = Replace(user_name, "|", "l") 
	user_name = Replace(user_name, ";", ";;")
	user_name = Replace(user_name,"""","")
	user_name = Replace(user_name,"/", "／")
	user_name = Replace(user_name, "'", "")
	user_name = Replace(user_name, "+", "")
	user_name = Replace(user_name,"--","")
	user_name = Replace(user_name, "CREATE", "")
	user_name = Replace(user_name, "create", "")
	user_name = Replace(user_name, "DROP", "")
	user_name = Replace(user_name, "drop", "")
	user_name = Replace(user_name, "SELECT", "")
	user_name = Replace(user_name, "UPDATE", "")
	user_name = Replace(user_name, "DELETE", "")
	user_name = Replace(user_name, "INSERT", "")
	user_name = Replace(user_name, "select", "")
	user_name = Replace(user_name, "delete", "")
	user_name = Replace(user_name, "update", "")
	user_name = Replace(user_name, "insert", "")
	user_name = Replace(user_name, "xp_","")
	user_name = Replace(user_name, "XP_","")
	user_name = Replace(user_name,"xp_cmdshell","")
	user_name = Replace(user_name,"xp_regread","")
	user_name = Replace(user_name,"xp_dirtree","")
	user_name = Replace(user_name,"<script>","")

	'=== injection 상담 내용  =========================================================================
	
	user_remark = Replace(user_remark, "\", "")
	user_remark = Replace(user_remark, "|", "l") 
	user_remark = Replace(user_remark, ";", ";;")
	user_remark = Replace(user_remark,"""","")
	user_remark = Replace(user_remark,"/", "／")
	user_remark = Replace(user_remark, "'", "")
	user_remark = Replace(user_remark, "+", "")
	user_remark = Replace(user_remark,"--","")
	user_remark = Replace(user_remark, "CREATE", "")
	user_remark = Replace(user_remark, "create", "")
	user_remark = Replace(user_remark, "DROP", "")
	user_remark = Replace(user_remark, "drop", "")
	user_remark = Replace(user_remark, "SELECT", "")
	user_remark = Replace(user_remark, "UPDATE", "")
	user_remark = Replace(user_remark, "DELETE", "")
	user_remark = Replace(user_remark, "INSERT", "")
	user_remark = Replace(user_remark, "select", "")
	user_remark = Replace(user_remark, "delete", "")
	user_remark = Replace(user_remark, "update", "")
	user_remark = Replace(user_remark, "insert", "")
	user_remark = Replace(user_remark, "xp_","")
	user_remark = Replace(user_remark, "XP_","")
	user_remark = Replace(user_remark,"xp_cmdshell","")
	user_remark = Replace(user_remark,"xp_regread","")
	user_remark = Replace(user_remark,"xp_dirtree","")
	user_remark = Replace(user_remark,"<script>","")

	'=== Config Values ==============================================================================
	user_phone	= u_htel1 & "-" & u_htel2 & "-" & u_htel3
	ip = request.ServerVariables("REMOTE_HOST")



	'=== 하루에 한번의 무료상담 신청  =======================================================================
'	sql = " SELECT COUNT(*) "
'	sql = sql & " FROM tb_ad_data "
'	sql = sql & " WHERE 1=1 "
'	sql = sql & " AND ip='" & IP & "'"
'	sql = sql & " AND hp ='" & user_phone & "' "
'	sql = sql & " AND write_date between '" & Date() & " 00:00:00 "& "' and '" & Date() & " 23:59:59'"
'	Set rs = db.execute(sql)
'	if Not( rs.EOF or rs.BOF ) then
'		user_comp = rs(0)
'	end if
'	rs.close

	'없는 경우
'	If user_comp = 0 Then 
		'db_status 상태값(0 : 정상 / 1: 중복 / 2: 에러)

			'대분류, 소분류 구분값 GET
			sql = " SELECT idkey, m_idkey, c1_idkey, c2_idkey "
			sql = sql & " FROM tb_ad_l "
			sql = sql & " WHERE idkey = '" & l_idkey & "' "
			'Response.Write sql & "<br>"
			'Response.end
			Set rs1 = db.execute(sql)
			if Not( rs1.EOF or rs1.BOF ) then
				m_idkey  = rs1("m_idkey")
				c1_idkey = rs1("c1_idkey")
				c2_idkey = rs1("c2_idkey")
			end if
			rs1.close


			'중복 핸드폰 처리 조회
			sql = "SELECT COUNT(*) FROM tb_ad_data "
			sql = sql & " WHERE hp = '" & user_phone & "' "
			sql = sql & " AND m_idkey = '" & m_idkey & "' "
			sql = sql & " AND c1_idkey = '" & c1_idkey & "' "
			sql = sql & " AND c2_idkey = '" & c2_idkey & "' "
			sql = sql & " AND l_idkey = '" & l_idkey & "' "
			Set rs2 = db.execute(sql)
			if Not( rs2.EOF or rs2.BOF ) then
				rs2_cnt = rs2(0)
			end if
			rs2.close
			
			If rs2_cnt < 1 Then 
				db_status = "0"	
			ElseIf rs2_cnt >= 1 Then 
				db_status = "1"
			End If 

			'=== INSERT1 ================================================================
			sql = "INSERT INTO tb_ad_data ( "
			sql = sql & "  m_idkey "
			sql = sql & " ,c1_idkey "
			sql = sql & " ,c2_idkey "
			sql = sql & " ,l_idkey "
			sql = sql & " ,name "
			sql = sql & " ,sex "
			sql = sql & " ,age "
			sql = sql & " ,hp "
			sql = sql & " ,contents "
			sql = sql & " ,service "
			sql = sql & " ,ip "
			sql = sql & " ,device_page "
			sql = sql & " ,db_status "
			sql = sql & " ,write_date "
			sql = sql & " ,use_yn "
			sql = sql & " ,cate "
			sql = sql & " ) VALUES ( "
			sql = sql & "  N'"& m_idkey &"' "
			sql = sql & " ,N'"& c1_idkey &"' "
			sql = sql & " ,N'"& c2_idkey &"' "
			sql = sql & " ,N'"& l_idkey &"' "
			sql = sql & " ,N'"& user_name &"' "
			sql = sql & " ,N'"& user_sex &"' "
			sql = sql & " ,N'"& user_age &"' "
			sql = sql & " ,N'"& user_phone &"' "
			sql = sql & " ,N'"& user_remark &"' "
			sql = sql & " ,N'"& service &"' "
			sql = sql & " ,N'"& ip &"' "
			sql = sql & " ,N'"& getDeviceInfo &"' "
			sql = sql & " ,N'"& db_status &"' "
			sql = sql & " ,CONVERT(CHAR(23),GETDATE(),21) "
			sql = sql & " ,N'Y' "
			sql = sql & " ,N'" & cate & "' "
			sql = sql & " )"
			db.Execute sql
			err_cnt = err_cnt + db.Errors.Count


	'있는경우
'	Else

'		  wString = "<script language='javascript'>"
'		  wString = wString & "alert('이미 무료상담이 접수되었습니다.');"
		  'wString = wString & "location.href='http://jlinvestad.com/ad/100/result.asp?l_idkey= '" & l_idkey & "'';"
'		  wString = wString & "history.back();"
'		  wString = wString & "</script>"
		  'Response.write wString
		 ' Response.End
	'
'	End If 

	'=== Close DB =======================================================================
'	if err_cnt = 0 then
'		db.CommitTrans
'	else
'		db.RollbackTrans
	'end if

	'db.Close
	'Set db = Nothing

	if err_cnt = 0 then
		db.CommitTrans
		sendType = "success"

	else

		db.RollbackTrans
		sendType = "100"

	end if

	db.Close
	Set db = Nothing
	'=== Move Page ========================================
	If err_cnt = 0 Then
		'Alert_Window("문의사항이 접수되었습니다.")
		wString = "<script language='javascript'>"
		'wString = wString & "alert('무료상담이 접수되었습니다.');"
		wString = wString & "location.href='http://jlinvestad.com/ad/100/result.asp?l_idkey=" & request("l_idkey") & "'"
		wString = wString & "</script>"
		wString = wString & "</head>"
		wString = wString & "</html>"
		Response.write wString
	Else
		Alert_Window("등록 처리 중 오류가 발생하였습니다.\n오류가 계속 발생할 경우 관리자에게 문의 바랍니다.")
		Response.End
	End if


%>

