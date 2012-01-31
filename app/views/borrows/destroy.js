$("#").html("<%= escape_javascript(render('users/borrow')) %>")
$("#borrowers").html('<%= "#{@user.borrowers.count} borrowers" %>')