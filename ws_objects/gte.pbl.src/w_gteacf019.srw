$PBExportHeader$w_gteacf019.srw
forward
global type w_gteacf019 from window
end type
type st_2 from statictext within w_gteacf019
end type
type st_1 from statictext within w_gteacf019
end type
type st_5 from statictext within w_gteacf019
end type
type st_4 from statictext within w_gteacf019
end type
type em_5 from editmask within w_gteacf019
end type
type em_4 from editmask within w_gteacf019
end type
type cb_2 from commandbutton within w_gteacf019
end type
type cb_1 from commandbutton within w_gteacf019
end type
end forward

global type w_gteacf019 from window
integer width = 1865
integer height = 1020
boolean titlebar = true
string title = "(w_gteacf019) JV Posting"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_2 st_2
st_1 st_1
st_5 st_5
st_4 st_4
em_5 em_5
em_4 em_4
cb_2 cb_2
cb_1 cb_1
end type
global w_gteacf019 w_gteacf019

type variables
long ll_ASON_YY,ll_ASON_MM,ll_nexty,ll_nextm
string ls_gl,ls_unit_id,ls_gl_cd,ls_temp,ls_sgl_cd
double ld_clos
end variables

on w_gteacf019.create
this.st_2=create st_2
this.st_1=create st_1
this.st_5=create st_5
this.st_4=create st_4
this.em_5=create em_5
this.em_4=create em_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_2,&
this.st_1,&
this.st_5,&
this.st_4,&
this.em_5,&
this.em_4,&
this.cb_2,&
this.cb_1}
end on

on w_gteacf019.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.em_5)
destroy(this.em_4)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;
f_center(this)
em_5.setfocus()

em_5.text = string(year(today()))
em_4.text = string(month(today()))

end event

type st_2 from statictext within w_gteacf019
integer width = 402
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Gteacf019"
boolean focusrectangle = false
end type

type st_1 from statictext within w_gteacf019
integer x = 640
integer y = 28
integer width = 558
integer height = 100
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "JV Posting"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_gteacf019
integer x = 649
integer y = 272
integer width = 183
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Month "
boolean focusrectangle = false
end type

type st_4 from statictext within w_gteacf019
integer x = 681
integer y = 196
integer width = 151
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year "
boolean focusrectangle = false
end type

type em_5 from editmask within w_gteacf019
integer x = 841
integer y = 192
integer width = 233
integer height = 76
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
end type

type em_4 from editmask within w_gteacf019
integer x = 837
integer y = 268
integer width = 274
integer height = 76
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "00"
boolean spin = true
string displaydata = "Jan~t01/Feb~t02/Mar~t03/Apr~t04/May~t05/Jun~t06/Jul~t07/Aug~t08/Sep~t09/Oct~t10/Nov~t11/Dec~t12/"
double increment = 1
string minmax = "01~~12"
end type

type cb_2 from commandbutton within w_gteacf019
integer x = 914
integer y = 408
integer width = 265
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gteacf019
integer x = 581
integer y = 404
integer width = 242
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&MEP"
end type

event clicked;
if isnull(em_5.text) or len(em_5.text) = 0 or em_5.text = '0000'  then 
	messagebox('Year Error','Invalid Year Entered, Please Correct This .....!')
	em_5.setfocus()
	return 1
end if

if isnull(em_4.text) or len(em_4.text) = 0 or em_4.text = '00' then 
	messagebox('Month Error','Invalid Month Entered, Please Correct This .....!')
	em_4.setfocus()
	return 1
end if

if long(em_4.text) < 1 or long(em_4.text) > 12 then 
	messagebox('Month Error','Month Should Be Between (1-12), Please Check.....!')
	em_4.setfocus()
	return 1
end if


ll_ASON_YY =long(em_5.text)
ll_ASON_MM =long(em_4.text)

//select distinct 'x' into :ls_temp from fb_mep_done
// where md_month=:ll_ASON_MM and md_year=:ll_ASON_YY  and
//	      doc_type='FA' and md_mep='Y' and md_co_cd=:gs_CO_ID;
//
//if sqlca.sqlcode = -1 then 
//	messagebox('Error:','During MEP check for this month.'); 
//	rollback using sqlca; 
//	return 1; 
//elseif sqlca.sqlcode = 100 then 
//	messagebox('Check:','MEP Indicator not open for this month.Please Check ...'); 
//	rollback using sqlca; 
//	return 1; 	
//end if


setpointer(hourglass!)

	if ll_ASON_MM = 12 then
			ll_nexty = ll_ASON_YY + 1;
			ll_nextm = 1;
	else
			ll_nextm = ll_ASON_MM + 1;
			ll_nexty = ll_ASON_YY ;
	end if;
	
     
	update fb_gl_det set gd_mop_bal=0 where gd_year = :ll_nexty and gd_month = :ll_nextm and gd_co_cd = :gs_CO_ID;
	update fb_gl_det set gd_mep_ind = 'N' where gd_year = :ll_ASON_YY and gd_month = :ll_ASON_MM and gd_co_cd = :gs_CO_ID;
	update fb_sgl_det set sgd_mop_bal=0 where sgd_year = :ll_nexty and sgd_month = :ll_nextm and sgd_co_cd = :gs_CO_ID;
	update fb_sgl_det set sgd_mep_ind = 'N' where sgd_year = :ll_ASON_YY and sgd_month = :ll_ASON_MM  and sgd_co_cd = :gs_CO_ID;
	update fb_sgl_det set SGD_UNIT_ID = :gs_garden_nm where trim(SGD_UNIT_ID) is null;
	
	commit using sqlca;
	
	declare c1 cursor for 
			    SELECT nvl(GD_UNIT_ID,:gs_garden_nm) GD_UNIT_ID, gd_gl_cd,(nvl(gd_mop_bal,0) + (nvl(gd_mtd_db,0) - nvl(gd_mtd_cr,0))) clos
       			 FROM  fb_gl_det  WHERE gd_year = :ll_ASON_YY and gd_month = :ll_ASON_MM and gd_co_cd = :gs_CO_ID ;
  		open c1; 

		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
			rollback using sqlca; 
			return 1; 
		else 
			setnull(ls_unit_id);setnull(ls_gl_cd);
			ld_clos= 0;
			
			fetch c1 into :ls_unit_id,:ls_gl_cd,:ld_clos;
					  
			do while sqlca.sqlcode <> 100      
				select distinct 'x' into :ls_temp from fb_gl_det
				 where gd_co_cd = :gs_CO_ID and GD_UNIT_ID = :ls_unit_id and
					       gd_gl_cd = :ls_gl_cd and gd_year = :ll_nexty and gd_month = :ll_nextm;
							 
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : Sql Error During GL Select  : ',sqlca.sqlerrtext);
					return 1;
				elseif sqlca.sqlcode = 0 then	
					update fb_gl_det set gd_mop_bal=nvl(:ld_clos,0)
					 where gd_co_cd = :gs_CO_ID and GD_UNIT_ID=:ls_unit_id and
					            gd_gl_cd = :ls_gl_cd and gd_year = :ll_nexty and gd_month = :ll_nextm;
			
					if sqlca.sqlcode = -1 then
						messagebox('Sql Error : Sql Error During GL Update : ',sqlca.sqlerrtext);
						return 1;			
					end if;	
				elseif sqlca.sqlcode = 100 then	
					insert into fb_gl_det(GD_CO_CD,GD_UNIT_ID,GD_GL_CD,GD_MONTH,GD_YEAR,GD_MOP_BAL)
					values (:gs_CO_ID,:ls_unit_id,:ls_gl_cd,:ll_nextm,:ll_nexty,nvl(:ld_clos,0));
					
					if sqlca.sqlcode = -1 then
						messagebox('Sql Error : Sql Error During GL Update : ',sqlca.sqlerrtext);
						return 1;			
					end if;	
				end if; 
				 setnull(ls_unit_id);setnull(ls_gl_cd);
				ld_clos= 0;
			
			fetch c1 into :ls_unit_id,:ls_gl_cd,:ld_clos;
		 
		 loop;	 	
		close c1;
	end if;  	

declare c2 cursor for 
	SELECT nvl(SGD_UNIT_ID,:gs_garden_nm) sgd_unit_cd,sgd_gl_cd,(nvl(sgd_mop_bal,0) + (nvl(sgd_mtd_db,0) - nvl(sgd_mtd_cr,0))) clos
		        	 FROM  fb_sgl_det  WHERE sgd_year = :ll_ASON_YY and sgd_month = :ll_ASON_MM and sgd_co_cd = :gs_CO_ID;
 open c2; 
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
			rollback using sqlca; 
			return 1; 
		else 
			setnull(ls_unit_id);setnull(ls_sgl_cd);
			ld_clos= 0;
			
			fetch c2 into :ls_unit_id,:ls_sgl_cd,:ld_clos;
					  
			do while sqlca.sqlcode <> 100  
		
				select distinct 'x' into :ls_temp from fb_sgl_det
				 where sgd_co_cd = :gs_CO_ID and sgd_gl_cd = :ls_sgl_cd and sgd_year = :ll_nexty and sgd_month = :ll_nextm and
					      nvl(SGD_UNIT_ID,:gs_garden_nm) = :ls_unit_id;
		
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : Sql Error During SGL Select  : ',sqlca.sqlerrtext);
					return 1;
				elseif sqlca.sqlcode = 0 then	
			
					update fb_sgl_det set sgd_mop_bal=nvl(:ld_clos,0)
					 where sgd_co_cd = :gs_CO_ID  and 
					       	 sgd_gl_cd = :ls_sgl_cd and sgd_year = :ll_nexty and sgd_month = :ll_nextm and
					       	 nvl(SGD_UNIT_ID,'00') = :ls_unit_id;
			
					if sqlca.sqlcode = -1 then
						messagebox('Sql Error : Sql Error During SGL Update : ',sqlca.sqlerrtext);
						return 1;			
					end if;	
					       
			elseif sqlca.sqlcode = 100 then				
					insert into fb_sgl_det(SGD_CO_CD,SGD_UNIT_ID,SGD_GL_CD,sGD_MONTH,SGD_YEAR,SGD_MOP_BAL)
					values (:gs_CO_ID ,:ls_unit_id,:ls_sgl_cd,:ll_nextm,:ll_nexty,nvl(:ld_clos,0));
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : Sql Error During SGL Update : ',sqlca.sqlerrtext);
					return 1;			
				end if;	
			end if;  			
 			setnull(ls_unit_id);setnull(ls_sgl_cd);
			ld_clos= 0;
			
			fetch c2 into :ls_unit_id,:ls_sgl_cd,:ld_clos;
		 
		 loop;	 	
		close c2;
	end if;  	

commit using sqlca;
messagebox('MEP ','Month End Processing Completed Successfully ');      
setpointer(arrow!)
end event

