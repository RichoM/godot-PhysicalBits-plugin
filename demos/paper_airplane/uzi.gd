extends Label
class_name PhysicalBits

var IP_SERVER = "127.0.0.1"
var PORT_SERVER = 3232
var PORT_CLIENT = 3234
var socket = PacketPeerUDP.new()

var data = {}
var previous_msg_ts = 0

func _ready():
	start_client()

func _process(_delta):
	var packet = get_latest_packet()
	if not packet: return
	
	var msg = packet.get_string_from_utf8()
	var json = JSON.parse(msg).result
	var new_data = {}
	for pin in json["pins"]["elements"]:
		new_data[pin["name"]] = pin["value"]
	for global in json["globals"]["elements"]:
		new_data[global["name"]] = fix_json_floats(global["value"])
	# TODO(Richo): Signal event
	data = new_data
	
	var keys = data.keys()
	keys.sort()
	var new_text = ""
	for key in keys:
		new_text += "%s = %f\n" % [key, data[key]]
		
	var now = OS.get_ticks_msec()
	if previous_msg_ts > 0:
		var diff = now - previous_msg_ts
		new_text += "\n%f ms" % [diff]
	previous_msg_ts = now
	
	text = new_text

func get_latest_packet():
	var packet = null
	while socket.get_available_packet_count() > 0:
		packet = socket.get_packet()
	return packet
	
func fix_json_floats(value):
	if typeof(value) == TYPE_DICTIONARY:
		if value.has("___NAN___"): 
			return NAN;
		if value.has("___INF___"):
			if value["___INF___"] > 0: 
				return INF
			else: 
				return -INF
		
	return value

func start_client():
	if (socket.listen(PORT_CLIENT, IP_SERVER) != OK):
		printt("Error listening on port: " + str(PORT_CLIENT) + " in server: " + IP_SERVER)
	else:
		printt("Listening on port: " + str(PORT_CLIENT) + " in server: " + IP_SERVER)
		socket.set_dest_address(IP_SERVER, PORT_SERVER)
		
func _exit_tree():
	print("Closing socket")
	socket.close()

func get_data(key, default = null):
	if data.has(key): return data[key]
	return default
