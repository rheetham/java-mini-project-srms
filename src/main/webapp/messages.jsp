<%-- messages.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
    String message = (String) session.getAttribute("message");
    String error = (String) session.getAttribute("error");
    
    if (message != null) {
%>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <%= message %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<%
        session.removeAttribute("message");
    }
    
    if (error != null) {
%>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <%= error %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<%
        session.removeAttribute("error");
    }
%>