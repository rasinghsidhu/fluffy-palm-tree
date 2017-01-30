
    function dist = quatdist(q1, q2)
       dist = 1 - abs(dot(q1./norm(q1), q2./norm(q2))); 
    end