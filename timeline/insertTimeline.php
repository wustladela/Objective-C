<?php

        require "database.php";
        
        $userWords = $_POST['userWords'];
        $user_name = $_POST['user_name'];
        $stmt = $mysqli->prepare("insert into users (user_timeline, user_name) values (?, ?)");
        if(!$stmt){
            echo json_encode(array("status"=>$mysqli->error));
            exit;
        }
        $stmt->bind_param('ss', $userWords, $user_name); 
        $stmt->execute();
        $stmt->close();
        echo json_encode(array("status"=>"success!!!"));
        ?>
        </p>    
    </body>
</html>