extends Node2D

# Configurar manualmente os dados de login

var dataToSend = {
	"type": "login",
	"user": "edsonmsouza",
	"password": "edson123"
}

func _ready():
	# configurar o envio e recebimento de dados
	var varPost = JSON.print(dataToSend)
	var header = ["Content-Type: application/json"]
	var url = "https://apigames.000webhostapp.com/user.php"
	var useSSL = false
	$HTTPRequest.request(url, header, useSSL,HTTPClient.METHOD_POST, varPost)

func _on_Timer_timeout():
	get_tree().change_scene("res://Cena2.tscn")


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	# pega os dados retornados pela API
	
	var json = JSON.parse(body.get_string_from_utf8())
	
	print('id: ', json.result['id'])
	print('user: ', json.result['user'])
	print('name: ', json.result['name'])
	#print(json.result['value'])

	#testando erro
	if(json.result['data'] == 'err'):
		if(json.result['value'] == "Dados inválidos"):
			# $erro.set_text(json.result['value']) - LABEL
			print(json.result['value'])
			return #para de executar
		
		if(json.result['value'] == "Usuário não localizado"):
			print(json.result['value'])
			return #para de executar
	
	get_tree().change_scene("res://Cena2.tscn")
