
<%@include file="/common/taglib.jsp"%>
<c:url var="APIurl" value="/api-admin-new"/>
<c:url var ="NewURL" value="/admin-new"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Danh sách bài viết</title>
</head>

<body>
	<div class="main-content">
		<form action="<c:url value='/admin-new'/>" id="formSubmit" method="get">
			<div class="main-content-inner">
				<div class="breadcrumbs ace-save-state" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="ace-icon fa fa-home home-icon"></i> <a href="#">Trang
								chủ</a></li>
					</ul>
					<!-- /.breadcrumb -->
				</div>
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							<c:if test="${not empty messageResponse}">
									<div class="alert alert-${alter}">
  										${messageResponse}
									</div>
								</c:if>
							<div class="widget-box table-filter">
								<div class="table-btn-controls">
									<div class="pull-right tableTools-container">
										<div class="dt-buttons btn-overlap btn-group">
											<a flag="info" 
												class="dt-button buttons-colvis btn btn-white btn-primary btn-bold" data-toggle="tooltip" 
												title='Thêm bài viết' href='<c:url value="/admin-new?type=edit"/>'> 
													<span>
														<i class="fa fa-plus-circle bigger-110 purple"></i>
													</span>
											</a>
											<button id="btnDelete" type="button"
												class="dt-button buttons-html5 btn btn-white btn-primary btn-bold"
												data-toggle="tooltip" title='Xóa bài viết'>
												<span> <i class="fa fa-trash-o bigger-110 pink"></i>
												</span>
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<div class="table-responsive">
										<table class="table">
											<thead>
												<tr>
													<th><input type="checkbox" id="checkAll"></th>
													<th scope="col">Tên Bài Viết</th>
													<th scope="col">hình Ảnh</th>
													<th scope="col">Mô Tả Ngắn</th>
													<th scope="col">Nội Dung</th>
													<th scope="col">Mã Danh Mục</th>
													<th scope="col">Thao Tác</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach var = "item" items= "${model.listResult}">
												<tr>
													<td><input type="checkbox" id="checkbox_${item.id}" value="${item.id}"></td>
													<td>${item.title}</td>
													<td>${item.thumbnail}</td>
													<td>${item.shortDescription}</td>
													<td>${item.content}</td>
													<td>${item.categoryId}</td>
													<td>
														<c:url var="editURL" value="./admin-new">
															<c:param name="type" value="edit"></c:param>
															<c:param name="id" value="${item.id}"></c:param>
														</c:url>
														<a class="btn btn-sm btn-primary btn-edit" data-toggle="tooltip"
															title="Cập nhật bài viết" href='<c:url value="${editURL}"></c:url>'><i class="fa fa-pencil-square-o" aria-hidden="true"></i>
														</a>
													</td>
												</tr>
											
											</c:forEach>
											</tbody>
										</table>
										<ul class="pagination" id="pagination"></ul>

										<input type="hidden" value="" id="page" name="page" />
										<input type="hidden" value="" id="maxPageItem" name="maxPageItem" />
										<input type="hidden" value="" id="sortName" name="sortName" />
										<input type="hidden" value="" id="sortBy" name="sortBy" /> 
										<input type="hidden" value="" id="type" name="type" />
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- /.main-content -->
<script>
	$(document).ready(function(){
		var totalPages = ${model.totalPage};
		var currentPage = ${model.page};
		/* var visiblePages = ${model.maxPageItem}; */
		var limit = 5;
		 $( document ).ready(function () {
		        window.pagObj = $('#pagination').twbsPagination({
		            totalPages: totalPages,
		            visiblePages: 4,
		            startPage: currentPage,
		            onPageClick: function (event, page) {
		            	if (currentPage != page){
			                // console.info(page + ' (from options)');
			                $('#maxPageItem').val(limit);
			                $('#page').val(page);
			                $('#sortName').val('title');
			                $('#sortBy').val('desc');
			                $('#type').val('list');
			                $('#formSubmit').submit();
		            	}
		            }
		        });
		    });
			

			$("#btnDelete").click(function(){
				var data={};
				var ids = $('tbody input[type=checkbox]:checked').map(function(){
					return $(this).val();
				}).get();
				data['ids'] = ids;
				
				deleteNews(data);
			});
			
			function deleteNews(data){
				$.ajax({
					url: '${APIurl}',
					type: 'DELETE',
					contentType: 'application/json',
					data: JSON.stringify(data),
					success: function(result){
						window.location.href = "${NewURL}?type=list&maxPageItem=5&page=1&message=delete_success&alter=success";
					},
					error: function(error){
						window.location.href = "${NewURL}?type=list&maxPageItem=5&page=1&message=error_system&alter=danger";
					}
				});
			}
	});
</script>
</body>

</html>