
-- login

SELECT U.Email, U.Fullname, R.Name as Role, S.Name as Status
FROM Users U, Status S, Role R
WHERE U.RoleId = R.Id and U.StatusId = S.Id and  U.Email = 'lethanhvan@fpt.com' AND U.Password = '123' and U.StatusId = '2'

--get commemt by postId
SELECT c.CommentID, c.Content, c.Date, c.Email, u.Fullname as Author 
FROM Comments c , Users u 
WHERE c.Email = u.Email and PostID = 3


-- get all artcle
select A.PostID, A.Title, A.Description, A.Image, A.Date, S.Name as Status, U.Fullname as Author, COUNT(C.PostID) As CommentCount 
from  Users U, Status S,  Articles A FULL OUTER JOIN Comments C ON A.PostID = C.PostID  AND  A.StatusId = '2' 
where A.Email = U.Email  and S.Id = A.StatusId
GROUP BY A.PostID, A.Title, A.Description, A.Image, A.Date, S.Name, U.Fullname 
ORDER BY A.Date ASC 
OFFSET 0 ROWS 
FETCH NEXT 20 ROWS ONLY

SELECT COUNT(A.PostID) as totalRows FROM Articles A 
WHERE A.StatusId = '2'

select A.PostID, A.Title, A.Description, A.Image, A.Date, S.Name as Status, U.Fullname as Author, COUNT(C.PostID) As CommentCount 
from Users U,  Status S, Articles A 
FULL OUTER JOIN Comments C ON A.PostID = C.PostID  
where A.Email = U.Email  and S.Id = A.StatusId and  A.StatusId = '2' and A.Title like N'%Good or bad%'
GROUP BY A.PostID, A.Title, A.Description, A.Image, A.Date,  S.Name , U.Fullname


select A.PostID, A.Title, A.Description, A.Image, A.Date ,U.Fullname as Author, COUNT(C.PostId) As CommentCount 
from Users U, Articles A FULL OUTER JOIN Comments C ON A.PostID = C.PostID  
where A.Email = U.Email AND A.StatusId = '2' 
GROUP BY A.PostID, A.Title, A.Description, A.Image, A.Date, U.Fullname

ORDER BY A.Date ASC 
OFFSET 0 ROWS 
FETCH NEXT 20 ROWS ONLY

SELECT A.Title, A.Description, A.Image, COUNT(C.PostId) As CommentCount 
FROM Articles A
FULL OUTER JOIN Comments C ON A.PostID = C.PostID 
GROUP BY A.Title, A.Description, A.Image;

SELECT COUNT(A.PostID) as totalRows FROM Articles A where A.StatusId = '2'

SELECT a.PostID, a.Title, a.Description, a.Image, a.Date, s.Name as Status, u.Fullname as Author 
FROM Articles a , Status s, Users u 
where a.Email = u.Email and u.StatusId = s.Id  and a.StatusId= '2' and a.PostID = 4



-- get all comment by Email

SELECT TOP 13  A.Title, C.Content, U.FullName as Author
FROM Articles A , Comments C,Users U
where  A.PostID = C.PostID AND C.Email = U.Email and C.Email = 'nhumap@gmail.com'
ORDER BY NEWID()



SELECT top 5 A.Title, C.Content, C.Date, U.FullName as Author
FROM Articles A , Comments C,Users U
where  A.PostID = C.PostID AND C.Email = U.Email and C.Email = 'lanlnhse140961@fpt.edu.vn'
ORDER BY  DATEDIFF(day, GETDATE(), C.Date ) DESC
