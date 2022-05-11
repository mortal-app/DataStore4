<?php

require_once __DIR__ . './vendor/prototype/autoload.php';

$ini = parse_ini_file("config.ini");
$key = $ini['KEY'];

route('test', '/api/test', function () {
    global $key;
    if (isset($_POST['key']) and $_POST['key'] == $key) {
        return json_encode(['ReturnCode' => 1]);
    } else {
        return json_encode(['message' => 'Key is not valid', 'ReturnCode' => 0]);
    }
}, ['POST']);

route('table', '/api/tables', function () {
    global $key;
    if (isset($_POST['key']) and $_POST['key'] == $key) {
        $ini = parse_ini_file("config.ini");
        $conn = connectSql($ini['SQL_HOST'], $ini['SQL_USER'], $ini['SQL_PASS'], $ini['SQL_DB']);
        $result = $conn->query("SHOW TABLES");

        if ($result == TRUE) {
            $assocArr = array();
            while ( $db_field = $result->fetch_assoc() ) {
                $assocArr[] = $db_field;
            }
    
            $valueArr = array();
            foreach ($assocArr as $key => $value) {
                array_push($valueArr, array_values($value)[0]);
            }
            return json_encode(['response' => $valueArr, 'size' => $result->num_rows, 'message' => 'success', 'ReturnCode' => 1]);
        } else {
            return json_encode(['message' => 'Sql Error: '.$conn->error, 'ReturnCode' => 0]);
        }

    } else {
        return json_encode(['message' => 'Key is not valid', 'ReturnCode' => 0]);
    }
}, ['POST']);

route('rows', '/api/rows', function () {
    global $key;
    if (isset($_POST['key']) and $_POST['key'] == $key) {
        $ini = parse_ini_file("config.ini");
        $conn = connectSql($ini['SQL_HOST'], $ini['SQL_USER'], $ini['SQL_PASS'], $ini['SQL_DB']);
        $result = $conn->query("SELECT * FROM " . $_POST['table'] . " LIMIT " . $_POST['limit'] . " OFFSET " . $_POST['offset']);

        if ($result == TRUE) {
            $assocArr = array();
            while ( $db_field = $result->fetch_assoc() ) {
                $assocArr[] = $db_field;
            }
            return json_encode(['response' => $assocArr, 'size' => $result->num_rows, 'message' => 'success', 'ReturnCode' => 1]);
        } else {
            return json_encode(['message' => 'Sql Error: '.$conn->error, 'ReturnCode' => 0]);
        }

    } else {
        return json_encode(['message' => 'Key is not valid', 'ReturnCode' => 0]);
    }
}, ['POST']);


route('post', '/api/post', function () {
    global $key;
    if (isset($_POST['key']) and $_POST['key'] == $key) {
        $ini = parse_ini_file("config.ini");
        $conn = connectSql($ini['SQL_HOST'], $ini['SQL_USER'], $ini['SQL_PASS'], $ini['SQL_DB']);

        if ($conn->query($_POST["payload"]) === TRUE) {
            return json_encode(['message' => 'success', 'ReturnCode' => 1]);
        } else {
            return json_encode(['message' => 'Sql Error: '.$conn->error, 'ReturnCode' => 0]);
        }

    } else {
        return json_encode(['message' => 'Key is not valid', 'ReturnCode' => 0]);
    }
}, ['POST']);


route('get', '/api/get', function () {
    global $key;
    if (isset($_POST['key']) and $_POST['key'] == $key) {
        $ini = parse_ini_file("config.ini");
        $conn = connectSql($ini['SQL_HOST'], $ini['SQL_USER'], $ini['SQL_PASS'], $ini['SQL_DB']);
        $result = $conn->query($_POST["payload"]);

        if ($result == TRUE) {
            return json_encode(['response' => json_encode($result->fetch_assoc()), 'size' => $result->num_rows, 'message' => 'success', 'ReturnCode' => 1]);
        } else {
            return json_encode(['message' => 'Sql Error: '.$conn->error, 'ReturnCode' => 0]);
        }

    } else {
        return json_encode(['message' => 'Key is not valid', 'ReturnCode' => 0]);
    }
}, ['POST']);

serve([
    'host' => $ini['HOST'],
    'port' => $ini['PORT'],
    'header' => $prototype_header_secure
]);
