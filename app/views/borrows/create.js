$("#").html("<%= escape_javascript(render('users/unborrow')) %>")
$("#borrowers").html('<%= "#{@user.borrowers.count} borrowers" %>')