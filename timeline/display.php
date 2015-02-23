 <?php
        require "database.php";
        $user = $_POST['user_name']);
        $stmt = $mysqli->prepare("select user_timeline from users where user_name = ?");
        if(!$stmt){
            printf("Query Prep Failed: %s\n", $mysqli->error);
            exit;
        } 
        $stmt->bind_param('s', $user); 
        $stmt->execute();
        $result = $stmt->get_result();
        $stmt->close();
        //$row = $result->fetch_assoc()
        $i=0;
        $allTimeline=array();
        while($row = $result->fetch_assoc()){
            $allTimeline[$i]=$row['user_timeline'];
            $i++;
        }
        if($allTimeline!=null){
            echo json_encode(array("status"=>"yay!~~~~~~~~~~"));
            //exit;
        }

        else{
        	echo json_encode(array("status"=>"nothing"));
            //exit;
        }
       ?>

