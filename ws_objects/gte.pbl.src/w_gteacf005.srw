$PBExportHeader$w_gteacf005.srw
forward
global type w_gteacf005 from window
end type
type st_1 from statictext within w_gteacf005
end type
type em_1 from editmask within w_gteacf005
end type
type cb_6 from commandbutton within w_gteacf005
end type
type cb_5 from commandbutton within w_gteacf005
end type
type cb_7 from commandbutton within w_gteacf005
end type
type cb_8 from commandbutton within w_gteacf005
end type
type cb_9 from commandbutton within w_gteacf005
end type
type dw_2 from datawindow within w_gteacf005
end type
type cb_4 from commandbutton within w_gteacf005
end type
type cb_3 from commandbutton within w_gteacf005
end type
type cb_2 from commandbutton within w_gteacf005
end type
type cb_1 from commandbutton within w_gteacf005
end type
type dw_1 from datawindow within w_gteacf005
end type
end forward

global type w_gteacf005 from window
integer width = 3223
integer height = 2436
boolean titlebar = true
string title = "(w_gteacf005) Accounting Year "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
st_1 st_1
em_1 em_1
cb_6 cb_6
cb_5 cb_5
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
dw_2 dw_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteacf005 w_gteacf005

type variables
long ll_last,ll_ctr,ll_cnt,ll_indunit_id,ll_ayid_no,ll_ASON_YY,ll_ASON_MM,ll_nexty,ll_nextm
string ls_temp,ls_cons,ls_sup_id,ls_indent_id,ls_tmp_id, ls_indent_dt,ls_unit_id,ls_indtype,ls_company,ls_gl_cd,ls_sgl_cd
boolean lb_neworder, lb_query
double ld_efunit_price,ld_amount,ld_qnty,ld_old_qnty,ld_indqnty,ld_clos

datawindowchild idw_prod,idw_quot
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_upd_indent_recvqnty (string fs_indent_id, string fs_sp_id, double fd_po_quantity, string fs_rec_old)
public function integer wf_check_duplicate_rec (string fs_ayp_id)
end prototypes

public function integer wf_check_fillcol (integer fl_row);//if dw_1.rowcount() > 0 and fl_row > 0 then
//	if (isnull(dw_1.getitemstring(fl_row,'machine_id')) or  len(dw_1.getitemstring(fl_row,'machine_id'))=0 or &
//		 isnull(dw_1.getitemdatetime(fl_row,'peg_date'))) then
//	    messagebox('Warning: One Of The Following Fields Are Blank','Machine ID, Run Date, Please Check !!!')
//		 return -1
//	end if
//end if
if dw_2.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_2.getitemnumber(fl_row,'ap_period_id')) or  dw_2.getitemnumber(fl_row,'ap_period_id')=0 or &
	    isnull(dw_2.getitemnumber(fl_row,'ap_year_id')) or dw_2.getitemnumber(fl_row,'ap_year_id') = 0 or &
		 isnull(dw_2.getitemdatetime(fl_row,'ap_start_dt')) or  isnull(dw_2.getitemdatetime(fl_row,'ap_end_dt')) or & 
		 isnull(dw_2.getitemstring(fl_row,'ap_status')) or len(dw_2.getitemstring(fl_row,'ap_status')) = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Period ID, Ac Year ID,Start Date,End Date,Status, Please Check !!!')
	    return -1
	end if
end if
return 1

end function

public function integer wf_upd_indent_recvqnty (string fs_indent_id, string fs_sp_id, double fd_po_quantity, string fs_rec_old);	select distinct 'x' into :ls_temp from fb_indentdetails b,fb_indent c
  	 where c.INDUNIT_ID=b.INDUNIT_ID and c.INDENT_ID= :fs_indent_id and SP_ID = :fs_sp_id  and
		      exists (select distinct INDENT_ID from fb_indent a where a.INDUNIT_ID=INDUNIT_ID  ); 
 
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error During geting stock detail : ',sqlca.sqlerrtext);
		return -1;
	elseif sqlca.sqlcode = 100 then
		messagebox('Missing Indent/Item','The Indent Detail Not found in Indent Master, Please checck..!');
		return -1;
	end if
	
		if fs_rec_old = 'N' then				
			update fb_indentdetails set ID_RECEIVEDQUANTITY = nvl(ID_RECEIVEDQUANTITY,0) + nvl(:fd_po_quantity,0)
			 where  SP_ID = :fs_sp_id and
			            INDUNIT_ID in (select distinct INDUNIT_ID from fb_indent a where a.INDENT_ID= :fs_indent_id );				
			 
		else 
			update fb_indentdetails set ID_RECEIVEDQUANTITY = nvl(ID_RECEIVEDQUANTITY,0) - nvl(:fd_po_quantity,0) 
			 where SP_ID = :fs_sp_id and
			            INDUNIT_ID in (select distinct INDUNIT_ID from fb_indent a where a.INDENT_ID= :fs_indent_id );
			
		end if;
		
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error During Received Quantity Update : ',sqlca.sqlerrtext);
			return -1;
		end if;	

  return 1;
	
	
end function

public function integer wf_check_duplicate_rec (string fs_ayp_id);long fl_row
string ls_ayp_id1
//datetime ld_run_dt1

dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 1 then
	for fl_row = 1 to (dw_2.rowcount() - 1)
		ls_ayp_id1 = dw_2.getitemstring(fl_row,'ap_period_id')
		
		if ls_ayp_id1 = fs_ayp_id  then
			dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteacf005.create
this.st_1=create st_1
this.em_1=create em_1
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.dw_2=create dw_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.em_1,&
this.cb_6,&
this.cb_5,&
this.cb_7,&
this.cb_8,&
this.cb_9,&
this.dw_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteacf005.destroy
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.dw_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_CO_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

cb_1.enabled =true

//setpointer(hourglass!)
//ddlb_1.additem('ALL')
//declare c1 cursor for
//select distinct initcap(COM_NAME)||' ['||COM_ID||']' 
//from  fb_company 
//order by 1 asc;
//	
//open c1;
//
//IF sqlca.sqlcode = 0 THEN
//	fetch c1 into :ls_company;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_1.additem(string(ls_company))
//		fetch c1 into :ls_company;
//	loop
//	close c1;
//end if
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

lb_query = false	
lb_neworder = false

//gs_CO_ID=left(right(ls_company,2),1)
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF1!) THEN
	cb_1.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if


end event

type st_1 from statictext within w_gteacf005
integer x = 32
integer y = 828
integer width = 352
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "No of Periods"
boolean focusrectangle = false
end type

type em_1 from editmask within w_gteacf005
integer x = 389
integer y = 816
integer width = 155
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
string mask = "##"
string minmax = "12~~16"
end type

type cb_6 from commandbutton within w_gteacf005
integer x = 571
integer y = 808
integer width = 270
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Create"
end type

event clicked;dw_2.SetTransObject(sqlca)
lb_neworder = True
lb_query = False
dw_2.Reset()

// Validate input
IF IsNull(em_1.Text) THEN
    MessageBox("Warning!", "Please select a valid number of periods for this Accounting Year !!!")
    RETURN 1
END IF

// Define variables
STRING ls_acyrst_dt, ls_acyrend_dt, ls_status
LONG ll_acpd

ll_acpd = Long(em_1.Text) - 1  // Get the number of periods

FOR ll_cnt = 0 TO ll_acpd STEP 1
    IF ll_cnt <= 11 THEN
        // Get Start and End Date for periods 1-12 (April to March)
        SELECT ADD_MONTHS(TO_DATE(
                    (DECODE(SIGN(TO_NUMBER(TO_CHAR(SYSDATE, 'MM')) - 4), 
                            -1, TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 1), 
                               TO_CHAR(SYSDATE, 'YYYY')) || '04'
                    ), 'YYYYMM'), :ll_cnt) 
        INTO :ls_acyrst_dt FROM DUAL;

        SELECT LAST_DAY(ADD_MONTHS(TO_DATE(
                    (DECODE(SIGN(TO_NUMBER(TO_CHAR(SYSDATE, 'MM')) - 4), 
                            -1, TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 1), 
                               TO_CHAR(SYSDATE, 'YYYY')) || '04'
                    ), 'YYYYMM'), :ll_cnt)) 
        INTO :ls_acyrend_dt FROM DUAL;

    ELSE
        // Get Last Month (March of the next year)
        SELECT LAST_DAY(TO_DATE(
                    (DECODE(SIGN(TO_NUMBER(TO_CHAR(SYSDATE, 'MM')) - 4), 
                            -1, TO_CHAR(SYSDATE, 'YYYY'), 
                               TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) + 1)) || '03'
                    ), 'YYYYMM')) 
        INTO :ls_acyrst_dt FROM DUAL;

        SELECT LAST_DAY(TO_DATE(
                    (DECODE(SIGN(TO_NUMBER(TO_CHAR(SYSDATE, 'MM')) - 4), 
                            -1, TO_CHAR(SYSDATE, 'YYYY'), 
                               TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) + 1)) || '03'
                    ), 'YYYYMM')) 
        INTO :ls_acyrend_dt FROM DUAL;
    END IF

    ls_status = "O"  // Fixed status

    // Insert row into DataWindow
    dw_2.ScrollToRow(dw_2.InsertRow(0))
    dw_2.SetItem(dw_2.GetRow(), "ap_period_id", ll_cnt + 1)
    dw_2.SetItem(dw_2.GetRow(), "ap_year_id", ll_ayid_no)
    dw_2.SetItem(dw_2.GetRow(), "ap_start_dt", DateTime(ls_acyrst_dt))
    dw_2.SetItem(dw_2.GetRow(), "ap_end_dt", DateTime(ls_acyrend_dt))
    dw_2.SetItem(dw_2.GetRow(), "ap_status", ls_status)
    dw_2.SetItem(dw_2.GetRow(), "ap_entry_by", gs_user)
    dw_2.SetItem(dw_2.GetRow(), "ap_entry_dt", DateTime(Today()))
NEXT

cb_3.Enabled = True

end event

type cb_5 from commandbutton within w_gteacf005
integer x = 2683
integer y = 20
integer width = 123
integer height = 88
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(1)
end if
end event

type cb_7 from commandbutton within w_gteacf005
integer x = 2802
integer y = 20
integer width = 123
integer height = 88
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollPriorRow()
end if
end event

type cb_8 from commandbutton within w_gteacf005
integer x = 2921
integer y = 20
integer width = 123
integer height = 88
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollnextRow()
end if
end event

type cb_9 from commandbutton within w_gteacf005
integer x = 3040
integer y = 20
integer width = 123
integer height = 88
integer taborder = 110
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(dw_1.rowcount())
end if
end event

type dw_2 from datawindow within w_gteacf005
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 18
integer y = 928
integer width = 1970
integer height = 1380
string dataobject = "dw_gteacf005a"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_2.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(dw_2.getrow())
	end if
	if dw_2.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(dw_2.getrow())
	end if
	if dw_2.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;if dwo.name = 'ap_status' then
//	if data = 'C' then
//		ll_ASON_YY = long(string(dw_2.getitemdatetime(row,'ap_start_dt'),'YYYY'))
//		ll_ASON_MM = long(string(dw_2.getitemdatetime(row,'ap_start_dt'),'MM'))
//
//		//select distinct 'x' into :ls_temp from fb_mep_done
//		// where md_month=:ll_ASON_MM and md_year=:ll_ASON_YY  and
//		//	      doc_type='FA' and md_mep='Y' and md_co_cd=:gs_CO_ID;
//		//
//		//if sqlca.sqlcode = -1 then 
//		//	messagebox('Error:','During MEP check for this month.'); 
//		//	rollback using sqlca; 
//		//	return 1; 
//		//elseif sqlca.sqlcode = 100 then 
//		//	messagebox('Check:','MEP Indicator not open for this month.Please Check ...'); 
//		//	rollback using sqlca; 
//		//	return 1; 	
//		//end if
//		
//		
//		setpointer(hourglass!)
//		
//			if ll_ASON_MM = 12 then
//					ll_nexty = ll_ASON_YY + 1;
//					ll_nextm = 1;
//			else
//					ll_nextm = ll_ASON_MM + 1;
//					ll_nexty = ll_ASON_YY ;
//			end if;
//			
//			  
//			update fb_gl_det set gd_mop_bal=0 where gd_year = :ll_nexty and gd_month = :ll_nextm and gd_co_cd = :gs_CO_ID;
//			update fb_gl_det set gd_mep_ind = 'N' where gd_year = :ll_ASON_YY and gd_month = :ll_ASON_MM and gd_co_cd = :gs_CO_ID;
//			update fb_sgl_det set sgd_mop_bal=0 where sgd_year = :ll_nexty and sgd_month = :ll_nextm and sgd_co_cd = :gs_CO_ID;
//			update fb_sgl_det set sgd_mep_ind = 'N' where sgd_year = :ll_ASON_YY and sgd_month = :ll_ASON_MM  and sgd_co_cd = :gs_CO_ID;
//			update fb_sgl_det set SGD_UNIT_ID = :gs_garden_nm where trim(SGD_UNIT_ID) is null;
//			
//			commit using sqlca;
//			
//			declare c1 cursor for 
//						 SELECT nvl(GD_UNIT_ID,:gs_garden_nm) GD_UNIT_ID, gd_gl_cd,(nvl(gd_mop_bal,0) + (nvl(gd_mtd_db,0) - nvl(gd_mtd_cr,0))) clos
//							 FROM  fb_gl_det  WHERE gd_year = :ll_ASON_YY and gd_month = :ll_ASON_MM and gd_co_cd = :gs_CO_ID ;
//				open c1; 
//		
//				if sqlca.sqlcode = -1 then 
//					messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
//					rollback using sqlca; 
//					return 1; 
//				else 
//					setnull(ls_unit_id);setnull(ls_gl_cd);
//					ld_clos= 0;
//					
//					fetch c1 into :ls_unit_id,:ls_gl_cd,:ld_clos;
//							  
//					do while sqlca.sqlcode <> 100      
//						select distinct 'x' into :ls_temp from fb_gl_det
//						 where gd_co_cd = :gs_CO_ID and GD_UNIT_ID = :ls_unit_id and
//									 gd_gl_cd = :ls_gl_cd and gd_year = :ll_nexty and gd_month = :ll_nextm;
//									 
//						if sqlca.sqlcode = -1 then
//							messagebox('Sql Error : Sql Error During GL Select  : ',sqlca.sqlerrtext);
//							return 1;
//						elseif sqlca.sqlcode = 0 then	
//							update fb_gl_det set gd_mop_bal=nvl(:ld_clos,0)
//							 where gd_co_cd = :gs_CO_ID and GD_UNIT_ID=:ls_unit_id and
//											gd_gl_cd = :ls_gl_cd and gd_year = :ll_nexty and gd_month = :ll_nextm;
//					
//							if sqlca.sqlcode = -1 then
//								messagebox('Sql Error : Sql Error During GL Update : ',sqlca.sqlerrtext);
//								return 1;			
//							end if;	
//						elseif sqlca.sqlcode = 100 then	
//							insert into fb_gl_det(GD_CO_CD,GD_UNIT_ID,GD_GL_CD,GD_MONTH,GD_YEAR,GD_MOP_BAL)
//							values (:gs_CO_ID,:ls_unit_id,:ls_gl_cd,:ll_nextm,:ll_nexty,nvl(:ld_clos,0));
//							
//							if sqlca.sqlcode = -1 then
//								messagebox('Sql Error : Sql Error During GL Update : ',sqlca.sqlerrtext);
//								return 1;			
//							end if;	
//						end if; 
//						 setnull(ls_unit_id);setnull(ls_gl_cd);
//						ld_clos= 0;
//					
//					fetch c1 into :ls_unit_id,:ls_gl_cd,:ld_clos;
//				 
//				 loop;	 	
//				close c1;
//			end if;  	
//		
//		declare c2 cursor for 
//			SELECT nvl(SGD_UNIT_ID,:gs_garden_nm) sgd_unit_cd,sgd_gl_cd,(nvl(sgd_mop_bal,0) + (nvl(sgd_mtd_db,0) - nvl(sgd_mtd_cr,0))) clos
//							 FROM  fb_sgl_det  WHERE sgd_year = :ll_ASON_YY and sgd_month = :ll_ASON_MM and sgd_co_cd = :gs_CO_ID;
//		 open c2; 
//				if sqlca.sqlcode = -1 then 
//					messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
//					rollback using sqlca; 
//					return 1; 
//				else 
//					setnull(ls_unit_id);setnull(ls_sgl_cd);
//					ld_clos= 0;
//					
//					fetch c2 into :ls_unit_id,:ls_sgl_cd,:ld_clos;
//							  
//					do while sqlca.sqlcode <> 100  
//				
//						select distinct 'x' into :ls_temp from fb_sgl_det
//						 where sgd_co_cd = :gs_CO_ID and sgd_gl_cd = :ls_sgl_cd and sgd_year = :ll_nexty and sgd_month = :ll_nextm and
//									nvl(SGD_UNIT_ID,:gs_garden_nm) = :ls_unit_id;
//				
//						if sqlca.sqlcode = -1 then
//							messagebox('Sql Error : Sql Error During SGL Select  : ',sqlca.sqlerrtext);
//							return 1;
//						elseif sqlca.sqlcode = 0 then	
//					
//							update fb_sgl_det set sgd_mop_bal=nvl(:ld_clos,0)
//							 where sgd_co_cd = :gs_CO_ID  and 
//										 sgd_gl_cd = :ls_sgl_cd and sgd_year = :ll_nexty and sgd_month = :ll_nextm and
//										 nvl(SGD_UNIT_ID,'00') = :ls_unit_id;
//					
//							if sqlca.sqlcode = -1 then
//								messagebox('Sql Error : Sql Error During SGL Update : ',sqlca.sqlerrtext);
//								return 1;			
//							end if;	
//									 
//					elseif sqlca.sqlcode = 100 then				
//							insert into fb_sgl_det(SGD_CO_CD,SGD_UNIT_ID,SGD_GL_CD,sGD_MONTH,SGD_YEAR,SGD_MOP_BAL)
//							values (:gs_CO_ID ,:ls_unit_id,:ls_sgl_cd,:ll_nextm,:ll_nexty,nvl(:ld_clos,0));
//						if sqlca.sqlcode = -1 then
//							messagebox('Sql Error : Sql Error During SGL Update : ',sqlca.sqlerrtext);
//							return 1;			
//						end if;	
//					end if;  			
//					setnull(ls_unit_id);setnull(ls_sgl_cd);
//					ld_clos= 0;
//					
//					fetch c2 into :ls_unit_id,:ls_sgl_cd,:ld_clos;
//				 
//				 loop;	 	
//				close c2;
//			end if;  	
//		
//		commit using sqlca;
//		messagebox('MEP ','Month End Processing Completed Successfully ');      
//		setpointer(arrow!)
//	end if
end if
cb_3.enabled = true
end event

event updatestart;//
integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid
string ls_columnname,ls_unique_id




// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()


DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_acyear_period');

close c1;
open c1;
if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
		
elseIF sqlca.sqlcode = 0 THEN
	setnull(ll_coumnid);setnull(ls_columnname);
	fetch c1 into :ll_coumnid,:ls_columnname;

		do while sqlca.sqlcode <> 100
 			// Get the old value for the data column
			       ls_old_value = dw_1.GetItemString(li_row, ll_coumnid, Primary!, true)
			 // Get the new value for the data column
			       ls_new_value = This.GetItemString(li_row, ll_coumnid)
			
			// Get the unique Value of Row
			
			ls_unique_id=string(dw_1.GetItemDatetime(li_row, 3, Primary!, true))
					 
					 
					 if ls_old_value <> ls_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_acyear_period',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
						end if
					 
					 
					 
		setnull(ll_coumnid);setnull(ls_columnname);

	fetch c1 into :ll_coumnid,:ls_columnname;
	loop
end if	
NEXT
close c1;

end event

type cb_4 from commandbutton within w_gteacf005
integer x = 791
integer y = 8
integer width = 265
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;if dw_1.modifiedcount() > 0 or dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gteacf005
integer x = 526
integer y = 8
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

if dw_2.rowcount() > 1 then
	if (isnull(dw_2.getitemnumber(dw_2.rowcount(),'ap_period_id')) or dw_2.getitemnumber(dw_2.rowcount(),'ap_period_id') = 0) then 
		dw_2.deleterow(dw_2.rowcount())
	end if;
end if

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

//	for ll_cnt = dw_2.rowcount() to 1 step -1
//		if dw_2.getitemstring(ll_cnt,'del_flag') = 'Y' and dw_2.rowcount() = dw_2.getitemnumber(ll_cnt,'sel_row') then
//			messagebox('Warning!','You Cannot Delete All Records From Detail Section !!!')
//			return 1
//		elseif dw_2.getitemstring(ll_cnt,'del_flag') = 'Y' and dw_2.rowcount() <> dw_2.getitemnumber(ll_cnt,'sel_row') then
//			//old
//			if wf_upd_indent_recvqnty(dw_1.getitemstring(dw_1.getrow(),'indent_id'),dw_2.getitemstring(ll_cnt,'sp_id'),dw_2.getitemnumber(ll_cnt,'old_po_qnty'),'Y') = -1 then 
//				rollback using sqlca;
//				return 1
//			end if;
//			dw_2.deleterow(ll_cnt)
//		end if
//	next	
	
	if dw_2.rowcount() = 0 then
		messagebox('Error','Records Should Be Available In Detail Block')
		return
	end if

	if (isnull(dw_1.getitemnumber(dw_1.getrow(),'ay_fy_year')) or dw_1.getitemnumber(dw_1.getrow(),'ay_fy_year')=0 or &
      	isnull(dw_1.getitemnumber(dw_1.getrow(),'ay_year_id')) or dw_1.getitemnumber(dw_1.getrow(),'ay_year_id') =0 or &
	    isnull(dw_1.getitemstring(dw_1.getrow(),'ay_com_id')) or len(dw_1.getitemstring(dw_1.getrow(),'ay_com_id'))=0 or &
		 isnull(dw_1.getitemstring(dw_1.getrow(),'ay_status')) or len(dw_1.getitemstring(dw_1.getrow(),'ay_status'))=0 or &
		isnull(dw_1.getitemdatetime(dw_1.getrow(),'ay_start_dt')) or &
		isnull(dw_1.getitemdatetime(dw_1.getrow(),'ay_end_dt'))) then
		messagebox('Warning:','One Of The Fields Are Blank : Financial Year,Company,Start date,End date,Year ID, Indent Id, Supplier Id !!!')
		dw_1.setfocus()
		dw_1.setcolumn('ay_status')
		return
	end if
	
	if dw_2.rowcount() > 0 then
		for ll_ctr = 1 to dw_2.rowcount( ) 
			IF wf_check_fillcol(ll_ctr) = -1 THEN 
				return 1
			end if
		next	
	end if
	
		
	if dw_1.update(true,false) = 1 then
		if dw_2.update(true,false) = 1 then
			dw_2.resetupdate();
			dw_1.resetupdate();
			commit using sqlca;
			cb_3.enabled = false
			cb_1.enabled = true
			dw_1.reset()
			dw_2.reset()
		else
			rollback using sqlca;
			return 1
		end if
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
	
//	dw_2.update();
//	dw_1.update();
//	commit using sqlca;
//	cb_3.enabled = false
//	dw_1.reset()
//	dw_2.reset()

else
	return
end if 
end event

type cb_2 from commandbutton within w_gteacf005
integer x = 261
integer y = 8
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Query"
end type

event clicked;if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0 or dw_2.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	dw_2.reset()
   	cb_3.enabled = false
  	cb_5.enabled = false
	cb_7.enabled = false
	cb_8.enabled = false
	cb_9.enabled = false
	cb_1.enabled = false
	cb_6.visible = false
	em_1.visible = false
	dw_1.settaborder('ay_status',10)
	dw_2.settaborder('ap_status',10)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('ay_status')
	cb_2.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
   	cb_5.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
	cb_1.enabled = true	
	cb_6.visible = false
	em_1.visible = false
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gteacf005
integer y = 8
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;string ls_acyrst_dt,ls_acyrend_dt,ls_status
long ll_acfy

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false
dw_1.reset()


setnull(ls_acyrst_dt);setnull(ls_acyrend_dt); setnull(ls_status);
ll_acfy=0;

/// Generate Accounting period no
select nvl(MAX(AY_YEAR_ID),0)   into :ll_ayid_no from fb_ac_year ;
if sqlca.sqlcode = -1 then
	messagebox('Sql Error During Getting Accounting Year : ',sqlca.sqlerrtext);
	return 1;
end if
if isnull(ll_ayid_no) then ll_ayid_no = 0;

ll_ayid_no = ll_ayid_no + 1

declare c1 cursor for
 select (decode(sign(to_number(to_char(sysdate,'mm')) - 04),-1,to_char(to_number(to_char(sysdate,'yyyy'))-1),to_char(sysdate,'yyyy')))ac_fy,
          to_char(to_date((decode(sign(to_number(to_char(sysdate,'mm')) - 04),-1,to_char(to_number(to_char(sysdate,'yyyy'))-1),to_char(sysdate,'yyyy'))||'04'),'yyyymm'),'dd/mm/yyyy')m_yearmon_from,
	    last_day(to_date(to_char(to_date((decode(sign(to_number(to_char(sysdate,'mm')) - 04),-1,to_char(sysdate,'yyyy'),to_char(to_number(to_char(sysdate,'yyyy'))+1))||'03'),'yyyymm'),'dd/mm/yyyy'),'dd/mm/yyyy'))m_yearmon_to,
	      'O' ay_status from dual;

open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ll_acfy,:ls_acyrst_dt,:ls_acyrend_dt,:ls_status;
	
	do while sqlca.sqlcode <> 100
		
	select distinct 'x' into:ls_temp from fb_ac_year where AY_COM_ID=:gs_CO_ID and  AY_FY_YEAR =:ll_acfy;
	
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error During check Accounting Year Present  : ',sqlca.sqlerrtext);
		return 1;
	elseif sqlca.sqlcode = 0 then
		messagebox('Error:','Accounting Year '+string(ll_acfy)+'  Already Present For This Company . Please Check  : ');
		return 1;
	end if;

		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setitem(dw_1.getrow(),'ay_year_id',ll_ayid_no)
		dw_1.setitem(dw_1.getrow(),'AY_FY_YEAR',ll_acfy)
		dw_1.setitem(dw_1.getrow(),'ay_com_id',gs_CO_ID)
		dw_1.setitem(dw_1.getrow(),'ay_start_dt',date(ls_acyrst_dt))
		dw_1.setitem(dw_1.getrow(),'ay_end_dt',date(ls_acyrend_dt))
		dw_1.setitem(dw_1.getrow(),'ay_status',ls_status)
		dw_1.setitem(dw_1.getrow(),'ay_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'ay_entry_dt',datetime(today()))
		
		setnull(ls_acyrst_dt);setnull(ls_acyrend_dt); setnull(ls_status);
		ll_acfy=0;
		
		fetch c1 into  :ll_acfy,:ls_acyrst_dt,:ls_acyrend_dt,:ls_status;
	loop
	close c1;

end if

end event

type dw_1 from datawindow within w_gteacf005
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer y = 116
integer width = 3159
integer height = 688
string dataobject = "dw_gteacf005"
boolean hscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'ay_entry_by',gs_user)
		dw_1.setitem(newrow,'ay_entry_dt',datetime(today()))
		dw_1.setcolumn('AY_COM_ID')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if dwo.name = 'AY_YEAR_ID'  and lb_query = false then
	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_1.setfocus()
		dw_1.setcolumn('AY_YEAR_ID')		
	end if;	
end if

//if dwo.name = 'indent_id'   then	
//	ls_indent_id = data	
//	
//	select distinct b.INDUNIT_ID into :ls_temp from fb_indentdetails b ,fb_indent c 
//	where c.INDUNIT_ID=b.INDUNIT_ID and 
//	           C.INDENT_ID=:ls_indent_id and (id_quantity>(NVL(id_receivedquantity,0)+NVL(ID_CANCELQUANTITY,0)));
//			
//	if sqlca.sqlcode = -1 then 
//	      messagebox('Sql Error','Error During Getting Indent ID  : '+sqlca.sqlerrtext)
//	      rollback using sqlca;
//	      return 1
//	elseif sqlca.sqlcode = 100 then 
//	     messagebox('Error','Indent ID Not Available In Indent Master  : '+sqlca.sqlerrtext)
//		rollback using sqlca;
//		return 1
//	end if;	
//	
//	idw_prod.SetFilter ("indent_id = '"+ls_indent_id+"'") 
//	idw_prod.filter( )
//end if;
//
//if dwo.name = 'sup_id'  then
//	ls_sup_id = data
//	
//	select SUP_ADD into :ls_temp from fb_supplier  where SUP_ID=:ls_sup_id;
//	
//	if sqlca.sqlcode = -1 then
//	   messagebox('Error During Select Of Supplier Address',sqlca.sqlerrtext)
//	   rollback using sqlca;
//	   return 1
//	end if	
//	
//	dw_1.setitem(row,'sup_add',ls_temp)	
//	idw_quot.SetFilter ("sup_id = '"+ls_sup_id+"'") 
//	idw_quot.filter( )
//end if;	

//if dwo.name = 'lpo_deadlinedate'  and lb_query = false then
//	if isnull(data) = true or data='00/00/0000'  then
//		messagebox('Warning!', 'PO End Date Should Be Enter , Please Check !!!')
//		return 1
//	end if
//	
//	if Date(data) < date(string(today(),'dd/mm/yyyy'))  then
//		messagebox('Alert!','PO End Date Should Be >= Current Date  !!!')
//		return 1
//	end if
//end if;

dw_1.setitem(row,'ay_entry_by',gs_user)
dw_1.setitem(row,'ay_entry_dt',datetime(today()))

cb_3.enabled = true
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			dw_2.reset()
			dw_2.retrieve(gs_user,dw_1.getitemnumber(dw_1.getrow(),'ay_year_id'))
		end if
	end if
end if
end event

event updatestart;//
integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid
string ls_columnname,ls_unique_id




// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()


DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_ac_year');

close c1;
open c1;
if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
		
elseIF sqlca.sqlcode = 0 THEN
	setnull(ll_coumnid);setnull(ls_columnname);
	fetch c1 into :ll_coumnid,:ls_columnname;

		do while sqlca.sqlcode <> 100
 			// Get the old value for the data column
			       ls_old_value = dw_1.GetItemString(li_row, ll_coumnid, Primary!, true)
			 // Get the new value for the data column
			       ls_new_value = This.GetItemString(li_row, ll_coumnid)
			
			// Get the unique Value of Row
			
			ls_unique_id=dw_1.GetItemString(li_row, 1, Primary!, true)
					 
					 
					 if ls_old_value <> ls_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_ac_year',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
						end if
					 
					 
					 
		setnull(ll_coumnid);setnull(ls_columnname);

	fetch c1 into :ll_coumnid,:ls_columnname;
	loop
end if	
NEXT
close c1;
end event

