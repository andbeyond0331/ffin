<%@ page import="com.ffin.service.domain.Catering" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <link href='../../resources/fullcalendar/core/main.css' rel='stylesheet' />
    <link href='../../resources/fullcalendar/daygrid/main.css' rel='stylesheet' />
    <link href='../../resources/fullcalendar/timegrid/main.min.css' rel='stylesheet' />
    <script src='../../resources/fullcalendar/core/main.js'></script>
    <script src='../../resources/fullcalendar/daygrid/main.js'></script>
    <script src="../../resources/fullcalendar/interaction/main.min.js"></script>
    <script src="../../resources/fullcalendar/timegrid/main.min.js"></script>
    <script src='../../resources/fullcalendar/core/locales/ko.js'></script>
    <%
        List<Catering> list = (List<Catering>) request.getAttribute("list");
    %>





    <style>

        html, body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
            font-size: 14px;
        }

        #calendar-container {
            position: relative;
            z-index: 1;
            margin-left: 200px;
        }

        #calendar {
            max-width: 900px;
            margin: 20px auto;
        }

    </style>

</head>


<body>

<div id="calendar-container">
    <div id="calendar"></div>
</div>


<script>


    document.addEventListener('DOMContentLoaded', function() {
       // alert("야호")
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            height: 600,
            plugins: [ 'interaction', 'dayGrid', 'timeGrid' ],
            defaultView: 'dayGridMonth',
            defaultDate: new Date(),
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
            },
            eventLimit: true,
            eventLimitText: "more",
            eventLimitClick: "popover",
            editable: false,
            droppable: false,
            dayPopoverFormat: { year: 'numeric', month: 'long', day: 'numeric' },
            locale: 'ko',
            events: [
                <%
  	  for (int i = 0; i < list.size(); i++) {
            Catering ct = (Catering)list.get(i);

%>
                {
                    title : '<%= ct.getCtNo() %>',
                    start : '<%= ct.getCtDate() %>',
                    end : '<%= ct.getCtDate() %>'
                },
                <%
                    }
                %>
                {
                    title : 'default',
                    start : "2019-01-01",
                    end : "2019-01-01"
                }
            ]
             //events:function end
        });//new FullCalendar end

        calendar.render();

    });

</script>


</body>
</html>