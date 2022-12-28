<?php


function show_piece($x,$y) {
	global $mysqli;
	
	$sql = 'select * from board where x=? and y=?';
	$st = $mysqli->prepare($sql);
	$st->bind_param('ii',$x,$y);
	$st->execute();
	$res = $st->get_result();
	header('Content-type: application/json');
	print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);
}
function move_piece($x,$y,$x2,$y2,$token) {
	
	if($token==null || $token=='') {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"token is not set."]);
		exit;
	}
	
	$color = current_color($token);
	if($color==null ) {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"You are not a player of this game."]);
		exit;
	}
	$status = read_status();
	if($status['status']!='started') {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"Game is not in action."]);
		exit;
	}
	if($status['p_turn']!=$color) {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"It is not your turn."]);
		exit;
	}
	$orig_board=read_board();
	$board=convert_board($orig_board);
	$n = add_valid_moves_to_piece($board,$color,$x,$y);
	
	do_move($x,$y,$x2,$y2);
			exit;
	if($n==0) {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"This piece cannot move."]);
		exit;
	}
	foreach($board[$x][$y]['moves'] as $i=>$move) {
		if($x2==$move['x'] && $y2==$move['y']) {
			do_move($x,$y,$x2,$y2);
			exit;
		}
	}
	header("HTTP/1.1 400 Bad Request");
	print json_encode(['errormesg'=>"This move is illegal."]);
	exit;
}
function show_board($input) {
	global $mysqli;
	
	$b=current_color($input['token']);
	if($b) {
		show_board_by_player($b);
	} else {
		header('Content-type: application/json');
		print json_encode(read_board(), JSON_PRETTY_PRINT);
	}
}

function reset_board() {
	global $mysqli;
	$sql = $mysqli->prepare("CALL clean_board();");
	$sql->execute();
	$sql1 = $mysqli->prepare("UPDATE players SET username = NULL, token = NULL");
	$sql1->execute();	
}

function read_board() {
	global $mysqli;
	$sql = 'select * from board';
	$st = $mysqli->prepare($sql);
	$st->execute();
	$res = $st->get_result();
	return($res->fetch_all(MYSQLI_ASSOC));
}

function convert_board(&$orig_board) {
	$board=[];
	foreach($orig_board as $i=>&$row) {
		$board[$row['x']][$row['y']] = &$row;
	} 
	return($board);
}
function show_board_by_player($b) {

	global $mysqli;

	$orig_board=read_board();
	$board=convert_board($orig_board);
	$status = read_status();
	if($status['status']=='started' && $status['p_turn']==$b && $b!=null) {

		$n = add_valid_moves_to_board($board,$b);
	}
	header('Content-type: application/json');
	print json_encode($orig_board, JSON_PRETTY_PRINT);
}



function add_valid_moves_to_piece(&$board,$b,$x,$y) {
	$number_of_moves=0;
	switch($board[$x][$y]['piece']){
		case 'P1': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P2': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P3': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P4': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P5': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P6': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P7': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P8': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P9': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P10': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P11': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P12': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P13': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P14': $number_of_moves+=knight_moves($board,$b,$x,$y);
		case 'P15': $number_of_moves+=knight_moves($board,$b,$x,$y);
	}
	return($number_of_moves);
}

function add_valid_moves_to_board(&$board,$b) {
	$number_of_moves=0;
	for($x=1;$x<12;$x++) {
		for($y=1;$y<33;$y++) {
			$number_of_moves+=add_valid_moves_to_piece($board,$b,$x,$y);
		}
	}
		$number_of_moves+=add_valid_moves_to_piece($board,$b,$x,$y);
		
	
	return($number_of_moves);
}

function knight_moves(&$board,$b,$x,$y) {
	$m = [
		[1,0],
		[1,1],
		[1,2],
		[1,3],
		[2,0],
		[2,0],
		[2,1],
		[2,2],
		[2,3],
		[0,1],
		[0,2],
		[0,3],
		[0,4],
	];
	$moves=[];
	foreach($m as $k=>$t) {
		$x2=$x+$t[0];
		$y2=$y+$t[1];
		
		$move=['x'=>$x2, 'y'=>$y2];
		$moves[]=$move;
	}
	$board[$x][$y]['moves'] = $moves;
	return(sizeof($moves));
}

function do_move($x,$y,$x2,$y2) {
    
	global $mysqli;
	
	$sql = 'call `move_piece1`(?,?,?,?);';
	$st = $mysqli->prepare($sql);
	$st->bind_param('iiii',$x,$y,$x2,$y2 );
	$st->execute();
	header('Content-type: application/json');
	print json_encode(read_board(), JSON_PRETTY_PRINT);

}

function rollDice(){
	$zariEna = rand(1, 6);
    $zariDyo = rand(1, 6);
   
    echo $zariEna . " " . $zariDyo;
}


?>