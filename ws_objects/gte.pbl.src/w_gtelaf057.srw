$PBExportHeader$w_gtelaf057.srw
forward
global type w_gtelaf057 from window
end type
type dp_2 from datepicker within w_gtelaf057
end type
type st_1 from statictext within w_gtelaf057
end type
type dp_1 from datepicker within w_gtelaf057
end type
type st_3 from statictext within w_gtelaf057
end type
type dw_2 from datawindow within w_gtelaf057
end type
type cb_2 from commandbutton within w_gtelaf057
end type
type cb_1 from commandbutton within w_gtelaf057
end type
type cb_4 from commandbutton within w_gtelaf057
end type
type dw_1 from datawindow within w_gtelaf057
end type
end forward

global type w_gtelaf057 from window
integer width = 6967
integer height = 2484
boolean titlebar = true
string title = "(w_gtelaf057) P.F. Form 1 Import"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
event ue_option ( )
dp_2 dp_2
st_1 st_1
dp_1 dp_1
st_3 st_3
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
cb_4 cb_4
dw_1 dw_1
end type
global w_gtelaf057 w_gtelaf057

type variables
string ls_temp,ls_AC_CD, ls_DIV_CD, ls_PARTY_NAME, ls_remark
long ll_empcd,ll_user_level, l_count, ll_doc_srl,ll_emp
double ld_dramt,ld_cramt
string ls_contribution, ls_advance_made, ls_advance_refund, ls_advance_interest, ls_emp_name, ls_pf_no, ls_frdt, ls_todt, ls_emp_id, ls_yrmn, ls_pfyear
n_cst_powerfilter iu_powerfilter



end variables

event ue_option();	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_1)
		case "PRINTPREVIEW"
				this.dw_1.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_1.modify("datawindow.print.preview = no")
		case "SAVEAS"
				this.dw_1.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked			
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_1.setredraw(false)
				this.dw_1.setfilter(gs_filtertext)
				this.dw_1.filter()
				this.dw_1.groupcalc()
				if this.dw_1.rowcount() > 0 then;
					this.dw_1.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_1.setredraw(false)
				this.dw_1.setsort(gs_sorttext)
				this.dw_1.sort()
				this.dw_1.groupcalc()
				if this.dw_1.rowcount() > 0 then;
					this.dw_1.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose

end event

on w_gtelaf057.create
this.dp_2=create dp_2
this.st_1=create st_1
this.dp_1=create dp_1
this.st_3=create st_3
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.dp_2,&
this.st_1,&
this.dp_1,&
this.st_3,&
this.dw_2,&
this.cb_2,&
this.cb_1,&
this.cb_4,&
this.dw_1}
end on

on w_gtelaf057.destroy
destroy(this.dp_2)
destroy(this.st_1)
destroy(this.dp_1)
destroy(this.st_3)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
//ddlb_1.Enabled = TRUE
this.tag = Message.StringParm
//ll_user_level = long(this.tag)
// wf_getreports(ll_user_level)
end event

type dp_2 from datepicker within w_gtelaf057
integer x = 1723
integer y = 16
integer width = 370
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-02-17"), Time("16:18:53.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gtelaf057
integer x = 1481
integer y = 36
integer width = 229
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date :"
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtelaf057
integer x = 1097
integer y = 16
integer width = 370
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-02-17"), Time("16:18:53.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_3 from statictext within w_gtelaf057
integer x = 439
integer y = 36
integer width = 654
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date (dd/mm/yyyy) : "
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_gtelaf057
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer x = 32
integer y = 132
integer width = 4155
integer height = 2244
integer taborder = 60
string title = "none"
string dataobject = "dw_gtelaf057a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF

end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event rbuttondown;dw_1.hide()
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF

end event

type cb_2 from commandbutton within w_gtelaf057
integer x = 2107
integer y = 12
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)

setpointer(hourglass!)

if isnull(dp_1.text) or isnull(dp_2.text) or dp_1.text='00/00/0000' or dp_2.text = '00/00/0000' then
	messagebox('Warning','Please Enter From And To Date')
	return 
end if

if Date(dp_1.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','From Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(dp_2.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','To Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(dp_1.text) > Date(dp_2.text) then
	messagebox('Alert!','From Date Should Be <= Than To Date !!!')
	return 1
end if

ls_frdt = dp_1.text
ls_todt = dp_2.text
select distinct 'x' into :ls_temp from FB_LABOURWAGESWEEK where trunc(LWW_STARTDATE) = to_date(:ls_frdt,'dd/mm/yyyy');
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting No Of Payment period',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning !','Invalid From Date, Should Be Start Date of Week / Fortnight, Please Check !!!')
	return 1
end if	

select distinct 'x' into :ls_temp from FB_LABOURWAGESWEEK where trunc(LWW_ENDDATE) = to_date(:ls_todt,'dd/mm/yyyy');
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting No Of Labours',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning !','Invalid To Date, Should Be End Date of Week / Fortnight, Please Check !!!')
	return 1
end if	

dw_1.retrieve(ls_frdt,ls_todt)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Date !!!')
	return 1
end if

setpointer(arrow!)


end event

type cb_1 from commandbutton within w_gtelaf057
integer x = 37
integer y = 16
integer width = 274
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Import"
end type

event clicked;integer l_fnum,l_loops,l_x
long ll_i,l_flen,l_bytes_read,l_newpos,l_rec_len,l_max_ref_no,l_fexit
string l_rec_val,ls_filename,lf_fnamed,ls_ack_catg,ls_std_price
string l_field1,l_field1a,l_field2,l_field3,l_field4,l_field5,l_field6,l_field7,l_field8,l_field9
string l_field10,l_field11,l_field12,l_field13,l_field14,l_field15,l_field16,l_field17,l_field18,l_field19,l_field32,l_field35,l_field36
date ld_dt1
string l_byte,lf_fnext
string             ls_pathname
long               ll_rc
oleobject        loo_excel
string lstr_currdata
integer c1
string ls_dsgncd


l_count = 0 

l_fexit = GetFileOpenName("Select Product File", &
+ ls_filename, lf_fnamed, "CSV", & 
+ "All Files (*.*),*.*")

lf_fnext = upper(right(lf_fnamed, 4))
lf_fnamed = upper(left(lf_fnamed,len(lf_fnamed) - 4))

setpointer(HourGlass!)

//if messagebox('Confirmation','This File Belongs To "Import Orders" ',question!,yesno!,2) = 1 then
//	ls_ack_catg = 'I'
//else
	ls_ack_catg = 'N'
//end if

l_count = 0 

if fileexists(ls_filename) then
	
	if(lf_fnext = ".CSV") then
//		  IF l_fexit = 1 THEN   
//		open(w_import_rows_information)
//		
//		l_flen = filelength(ls_filename)
//		l_fnum = fileopen(ls_filename)
//		l_bytes_read = fileread(l_fnum,l_byte)
//		do while l_bytes_read <> -100
//				l_rec_val = l_byte
//				l_rec_len = len(l_rec_val)
//				l_rec_val = right(l_rec_val,l_rec_len)
//				
//				l_field1  = f_get_string_position(l_rec_val,',')
//				l_field2  = em_1.text
//				l_field3  = em_2.text
//				l_field4  = f_get_string_position(l_rec_val,',')
//				l_field5  = f_get_string_position(l_rec_val,',')
//				l_field6  = f_get_string_position(l_rec_val,',')
//				l_field7  = f_get_string_position(l_rec_val,',')
//				l_field8  = f_get_string_position(l_rec_val,',')
//				l_field9  = f_get_string_position(l_rec_val,',')
//				l_field10  = f_get_string_position(l_rec_val,',')
//				l_field11  = f_get_string_position(l_rec_val,',')
//				
//				select replace(:l_field1,'"',''),replace(:l_field2,'"',''),replace(:l_field3,'"',''),replace(:l_field4,'"',''),replace(:l_field5,'"',''),replace(:l_field6,'"',''),replace(:l_field7,'"',''),
//						replace(:l_field8,'"',''),replace(:l_field9,'"',''),replace(:l_field10,'"',''),replace(:l_field11,'"','')
//				  into :l_field1, :l_field2, :l_field3, :l_field4, :l_field5, :l_field6, :l_field7,:l_field8, :l_field9, :l_field10, :l_field11
//				 from dual;
//	
//				if sqlca.sqlcode = -1 then
//					messagebox('Error During Replacing Double Quotes',sqlca.sqlerrtext)
//						close(w_import_rows_information)
//					fileclose(l_fnum)
//					rollback using sqlca;
//					return 1
//				end if	
//		
//			select distinct 'x' into :ls_temp from fb_battingorder where BO_YEAR =:l_field2 and  BO_SALENO = :l_field3;
//	 
//			if sqlca.sqlcode = -1 then
//				messagebox('Error','Error occured while getting sale detail '+sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 
//			elseif sqlca.sqlcode = 0 then
//				if messagebox('Warning','Data for this crop year and sale no already exists, Do you want to delete and re-import?',question!,yesno!,1) = 1 then
//					delete from fb_battingorder where BO_YEAR =:l_field2 and  BO_SALENO = :l_field3;
//				else
//					return 1;
//				end if
//			end if
//	
//			insert into fb_battingorder (BO_ZONE, BO_YEAR, BO_SALENO, BO_GARDEN, BO_CURRYRQTY, BO_CURRYRRATE, BO_CURRYRRANK, BO_PREYRQTY, BO_PREYRRATE, BO_PREYRRANK)
//				values (ltrim(rtrim(:l_field1)),to_number(ltrim(rtrim(:l_field2))),to_number(ltrim(rtrim(:l_field3))),ltrim(rtrim(:l_field4)), to_number(ltrim(rtrim(:l_field5))),to_number(ltrim(rtrim(:l_field6))),
//							to_number(ltrim(rtrim(:l_field7))),to_number(ltrim(rtrim(:l_field8))),to_number(ltrim(rtrim(:l_field9))),to_number(ltrim(rtrim(:l_field10))));
//	
//				if sqlca.sqlcode = -1 then
//					messagebox("SQL Error: During Import",SQLCA.SQLErrtext,Information!)
//						close(w_import_rows_information)				
//					fileclose(l_fnum)
//						rollback using sqlca;
//					return 
//				end if
//		
//				l_bytes_read = fileread(l_fnum,l_byte)
//				l_count = l_count + 1
//				w_import_rows_information.sle_1.text= string(l_count) 
//		loop
//		commit using sqlca;
//	
//		fileclose(l_fnum)
//		setpointer(arrow!)
//		close(w_import_rows_information)
//		dw_2.visible = true
//	
//		messagebox("Import File Information",'Total ' + string(l_count) + ' Rows Imported.....')
//	else
//		messagebox("file","File Does Not Exists -> " + ls_filename)
//	end if
else		
		dw_2.reset()
		loo_excel = CREATE OLEObject
		loo_excel.ConnectToNewObject( "excel.application" )
		loo_excel.visible = false
		loo_excel.workbooks.open( ls_filename )
		loo_excel.ActiveCell.CurrentRegion.Select()
		loo_excel.Selection.Copy()
		ll_rc = dw_2.ImportClipBoard ()
		ClipBoard('')
		loo_excel.workbooks.close()
		loo_excel.disconnectobject()
		DESTROY loo_excel
		dw_2.settransobject(sqlca)
		 if(dw_2.RowCount() > 0) then		 
		 		
				open(w_import_rows_information)
		 	     for c1=1 to dw_2.RowCount()
					ls_emp_id = trim(dw_2.GetItemstring( c1 ,"emp_id"))
					ls_emp_name = trim(dw_2.GetItemstring( c1 ,"emp_name"))
					ls_pf_no = trim(dw_2.GetItemString( c1 ,"pf_no"))
					ls_contribution = trim(dw_2.GetItemstring( c1 ,"contribution"))
					ls_advance_made = trim(dw_2.GetItemString( c1 ,"advance_made"))
					ls_advance_refund = trim(dw_2.GetItemstring( c1 ,"advance_refund"))
					ls_advance_interest = trim(dw_2.GetItemstring( c1 ,"advance_interest"))
					ls_frdt = trim(dw_2.GetItemstring( c1 ,"frdt"))
					ls_todt = trim(dw_2.GetItemstring( c1 ,"todt"))					
					ls_yrmn = trim(dw_2.GetItemstring( c1 ,"yrmn"))	
					ls_pfyear = trim(dw_2.getitemstring(c1, "pf_year"))
					
					if isnull(ls_contribution) then ls_contribution = '0';
					if isnull(ls_advance_made) then ls_advance_made = '0';
					if isnull(ls_advance_refund) then ls_advance_refund = '0';
					if isnull(ls_advance_interest) then ls_advance_interest = '0';
					if isnull(ls_yrmn) or len(ls_yrmn) = 0 then ls_yrmn = '0'
					if isnull(ls_pfyear) or len(ls_pfyear) = 0 then ls_pfyear = '0'
				
					select distinct 'x' into :ls_temp from FB_LABOURWAGESWEEK where trunc(LWW_STARTDATE) = to_date(:ls_frdt,'dd/mm/yyyy') and trunc(LWW_ENDDATE) = to_date(:ls_todt,'dd/mm/yyyy');
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Checking Payment Period',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode  = 100 then
						messagebox('Warning !','Data can only be saved payment period wise, Kindly check from date and to date in file at line no. '+string(c1))
						rollback using sqlca;
						return 1
					end if	
					
					if not isnull(ls_yrmn) and len(ls_yrmn) <> 0 and ls_yrmn <> '0' then
						select to_date(:ls_yrmn,'yyyymm') into :ls_temp from dual ;
						if sqlca.sqlcode = -1 then
							messagebox('Error : While checking Year Month at line no. ' +string(c1) ,sqlca.sqlerrtext)
							return 1
						end if
					end if
										
					if c1 = 1 then
						select distinct 'x' into :ls_temp from fb_pfform1_exp where frdt = to_date(:ls_frdt,'dd/mm/yyyy') and todt = to_date(:ls_todt,'dd/mm/yyyy');
		 
						if sqlca.sqlcode = -1 then
							messagebox('Error','Error occured while getting detail '+sqlca.sqlerrtext)
							rollback using sqlca;
							return  1;
						elseif sqlca.sqlcode = 0 then
							if messagebox('Warning','Data already exists for this period, Do you want to delete and re-import?',question!,yesno!,1) = 1 then
								delete from fb_pfform1_exp ;
								if sqlca.sqlcode = -1 then
									messagebox('Error occured while deleting existing records',sqlca.sqlerrtext)
									rollback using sqlca;
								end if	
							else
								return 1;
							end if
						end if
						
						if not isnull(ls_yrmn) and len(ls_yrmn) <> 0 and ls_yrmn <> '0' then
							select distinct 'x' into :ls_temp from fb_pfform1_exp where year_mon = :ls_yrmn  ;
			 
							if sqlca.sqlcode = -1 then
								messagebox('Error','Error occured while getting detail '+sqlca.sqlerrtext)
								rollback using sqlca;
								return 1;
							elseif sqlca.sqlcode = 0 then
								messagebox('Warning','Data for this year month exists in a different payment period. Please check the file you are importing.');
								rollback using sqlca;
								return 1;
							end if
						end if
					end if
					
						 if len(ls_pf_no) > 0  then
							insert into fb_pfform1_exp (EMP_ID, EMP_NAME, PF_NO, CONTRIBUTION, ADVANCE_MADE, ADVANCE_REFUND, ADVANCE_INTEREST, FRDT, TODT, YEAR_MON, ENTRY_BY, ENTRY_DT, PF_YEAR)
							                              values (:ls_emp_id,:ls_emp_name, to_number(:ls_pf_no),to_number(:ls_contribution),to_number(:ls_advance_made),to_number(:ls_advance_refund),to_number(:ls_advance_interest), to_date(:ls_frdt,'dd/mm/yyyy'),
																	to_date(:ls_todt,'dd/mm/yyyy'), to_number(:ls_yrmn),:gs_user, sysdate, :ls_pfyear);	 
							  if sqlca.sqlcode = -1 then
								 messagebox("SQL Error while inserting record "+string(c1),SQLCA.SQLErrtext,Information!)
								 rollback using sqlca;
								 return 1
							elseif sqlca.sqlcode = 0 and c1 = dw_2.rowcount() then
									commit;
							  end if
							
						 elseif len(ls_pf_no) = 0 or isnull(ls_pf_no) then
							 messagebox('Error: Invalid P.F. No. ',l_field1+', Please Check !!!')
							 return 1
						  end if  
						 l_count = l_count + 1
						 w_import_rows_information.sle_1.text= string(l_count)
				  next
				  close(w_import_rows_information)
					messagebox("file","File Imported " + ls_filename + " Completed")
					dw_2.reset()
					//dw_1.retrieve()
				   
		else
				messagebox("file","File Does Not Exists -> " + ls_filename)
		end if
	
end if
end if
end event

type cb_4 from commandbutton within w_gtelaf057
integer x = 2382
integer y = 12
integer width = 279
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)

		


end event

type dw_1 from datawindow within w_gtelaf057
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 32
integer y = 132
integer width = 4201
integer height = 2244
integer taborder = 50
string title = "none"
string dataobject = "dw_gtelaf057"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF

end event

event rbuttondown;dw_1.hide()
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF

end event

