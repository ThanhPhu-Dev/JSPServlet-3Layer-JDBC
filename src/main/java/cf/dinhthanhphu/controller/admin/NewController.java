package cf.dinhthanhphu.controller.admin;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cf.dinhthanhphu.constant.SystemConstant;
import cf.dinhthanhphu.model.NewsModel;
import cf.dinhthanhphu.paging.PageRequest;
import cf.dinhthanhphu.paging.pageble;
import cf.dinhthanhphu.service.INewService;
import cf.dinhthanhphu.sort.Sorter;
import cf.dinhthanhphu.utils.FormUtil;

@WebServlet(urlPatterns = { "/admin-new" })
public class NewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Inject
	private INewService newsServive;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    String view="";
		NewsModel model = FormUtil.toModel(NewsModel.class, req);
		if(model.getType().equals(SystemConstant.LIST)) {
		pageble pageble = new PageRequest(model.getPage(), model.getMaxPageItem(), 
										  new Sorter(model.getSortName(), model.getSortBy()));
		model.setListResult(newsServive.findAll(pageble)); 
		//đếm số sượng item trong db.
		model.setTotalItem(newsServive.getTotalItem());
		//tính tổng số trang.
		model.setTotalPage((int) Math.ceil((double) model.getTotalItem() /  model.getMaxPageItem()));
		
		view = "/views/admin/new/list.jsp";
		}else if(model.getType().equals(SystemConstant.EDIT)) {
		    if(model.getId() != null) {
		        model = newsServive.findOne(model.getId());
		    }else {
		        
		    }
		        
		    view = "/views/admin/new/edit.jsp";
		}
		req.setAttribute(SystemConstant.MODEL, model);
		RequestDispatcher rd = req.getRequestDispatcher(view);
        rd.forward(req, resp);
	}
}
