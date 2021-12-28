package com.ffin.common.web;

import com.ffin.service.domain.User;
import com.ffin.service.user.UserService;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogonCheckInterceptor extends HandlerInterceptorAdapter {

	///Field
	private ModelAndView modelAndView;
	private static final String authLogin = "authLogin";

	@Inject
	UserService userService;

	///Constructor
	public LogonCheckInterceptor(){
		System.out.println("\nCommon :: "+this.getClass()+"\n");		
	}

	///Method
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		if( user == null ){
			Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");
			if(loginCookie != null) {
				String sessionKey = loginCookie.getValue();
				User cookieUser = userService.SessionKeyAuth(sessionKey);

				if(cookieUser != null){
					session.setAttribute("user", cookieUser);
					return true;
				}
			}
			response.sendRedirect("/user/login.jsp");
			return false;
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

	//	public boolean preHandle(	HttpServletRequest request,
//														HttpServletResponse response,
//														Object handler) throws Exception {
//
//		System.out.println("\n[ LogonCheckInterceptor start........]");
//
//		//로그인 유무 확인
//		HttpSession session = request.getSession(true);
//		User user = (User)session.getAttribute("user");
//0
//		//로그인
//		if(   user != null   )  {
//			// 로그인 상태에서 접근X
//			String uri = request.getRequestURI();
//
//			if(		uri.indexOf("addUser") != -1 ||	uri.indexOf("login") != -1 		||
//					uri.indexOf("checkDuplication") != -1 ){
//				request.getRequestDispatcher("/views/home.jsp").forward(request, response);
//				System.out.println("[ >>> 로그인 상태 :: 접근 불가 <<< ]");
//				System.out.println("[ LogonCheckInterceptor end]\n");
//				return false;
//			}
//
//			if(user == null)
//
//			System.out.println("[ 로그인 상태]");
//			System.out.println("[ LogonCheckInterceptor end]\n");
//			return true;
//		//미로그인
//		}else{
//			//로그인 시도중
//			String uri = request.getRequestURI();
//
//			if(		uri.indexOf("addUser") != -1 ||	uri.indexOf("login") != -1 		||
//					uri.indexOf("checkDuplication") != -1 ){
//				System.out.println("[ >>> log 시도 중 <<< ]");
//				System.out.println("[ LogonCheckInterceptor end]\n");
//				return true;
//			}
//
//			request.getRequestDispatcher("/views/home.jsp").forward(request, response);
//			System.out.println("[ wow ]");
//			System.out.println("[ LogonCheckInterceptor end]\n");
//			return false;
//		}
//	}

	/*public void postHandle(HttpServletRequest request, HttpServletResponse response,
						   Object handler, Model model) throws Exception {
		HttpSession session = request.getSession();
		ModelMap modelMap = modelAndView.getModelMap();
		Object user = modelMap.get("user");

		if(user != null) {
			System.out.println("new login success");
			session.setAttribute(authLogin, user);

			if(request.getParameter("useCoolie") != null){
				System.out.println("autoLogin");
				Cookie loginCookie = new Cookie("loginCookie", session.getId());
				loginCookie.setPath("/");
				loginCookie.setMaxAge(60*60*24*7);

				response.addCookie(loginCookie);
			}

			Object destination = session.getAttribute("destination");
			response.sendRedirect(destination != null ? (String) destination : "/");
		}
	}*/
}//end of class