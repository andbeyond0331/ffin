package com.ffin.common.web;

import com.ffin.service.domain.User;
import com.ffin.service.user.UserService;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

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

		System.out.println("LogonCheckInterceptor.preHandle");
		//Cookie autoLogin = WebUtils.getCookie(request, "loginCookie");
		HttpSession session = request.getSession();
		Object user = session.getAttribute("user");

		// login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
		//Object obj = session.getAttribute("loginCookie");
		//System.out.println("***********************cookie = " + autoLogin);

		// 로그인된 세션이 없는 경우...
		if ( user == null ) {
			// 우리가 만들어 논 쿠키를 꺼내온다.
			Cookie autoLogin = WebUtils.getCookie(request, "loginCookie");


			// 쿠키가 존재하는 경우(이전에 로그인때 생성된 쿠키가 존재한다는 것)
			if ( autoLogin != null )
			{

				// autoLogin의 값을 꺼내오고 -> 즉, 저장해논 세션Id를 꺼내오고
				String SESSIONKEY = autoLogin.getValue();
				user = userService.sessionKeyAuth(SESSIONKEY);
				if(user != null)
				{
					session.setAttribute("user", user);
					session.setAttribute("role", "user");
					return true;
				}

			}

			// 이제 아래는 로그인도 안되있고 쿠키도 존재하지 않는 경우니까 다시 로그인 폼으로 돌려보내면 된다.
			// 로그인이 안되어 있는 상태임으로 로그인 폼으로 다시 돌려보냄(redirect)

			return true;

		}

		return true;

/*
		Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");
		System.out.println("loginCookie = " + loginCookie);
		if( loginCookie != null ){

			String sessionKey = loginCookie.getValue();
			User user = userService.sessionKeyAuth(sessionKey);
			System.out.println("!!!!!"+user);

			if(user != null){

				System.out.println("LogonCheckInterceptor.preHandle ***** : "+user);

				HttpSession session = request.getSession();
				session.setAttribute("user", user);
			}
		}
			return true;*/
	}



/*		public boolean preHandle(	HttpServletRequest request, HttpSession session,
									 HttpServletResponse response, Object handler) throws Exception {

		System.out.println("\n[ LogonCheckInterceptor start........]");

		//로그인 유무 확인
		HttpSession session = request.getSession(true);
		User user = (User)session.getAttribute("user");

		//로그인
		if(   user != null   )  {
			// 로그인 상태에서 접근X
			String uri = request.getRequestURI();

			if(		uri.indexOf("addUser") != -1 ||	uri.indexOf("login") != -1 		||
					uri.indexOf("checkDuplication") != -1 ){
				request.getRequestDispatcher("/views/home.jsp").forward(request, response);
				System.out.println("[ >>> 로그인 상태 :: 접근 불가 <<< ]");
				System.out.println("[ LogonCheckInterceptor end]\n");
				return false;
			}

			if(user == null)

			System.out.println("[ 로그인 상태]");
			System.out.println("[ LogonCheckInterceptor end]\n");
			return true;
		//미로그인
		}else{
			//로그인 시도중
			String uri = request.getRequestURI();

			if(		uri.indexOf("addUser") != -1 ||	uri.indexOf("login") != -1 		||
					uri.indexOf("checkDuplication") != -1 ){
				System.out.println("[ >>> log 시도 중 <<< ]");
				System.out.println("[ LogonCheckInterceptor end]\n");

				Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");

				if( loginCookie != null ){

					String sessionKey = loginCookie.getValue();
					User user = userService.SessionKeyAuth(sessionKey);

					if(user != null){
						HttpSession session = request.getSession();
						session.setAttribute("user", user);
					}
				}
				return true;

				return true;
			}

			request.getRequestDispatcher("/views/home.jsp").forward(request, response);
			System.out.println("[ wow ]");
			System.out.println("[ LogonCheckInterceptor end]\n");
			return false;
		}
	}*/

/*	public void postHandle(HttpServletRequest request, HttpServletResponse response,
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