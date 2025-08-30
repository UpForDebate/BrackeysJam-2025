extends Node

const SFX_FOLDER: String = "res://resources/audio/sfx/"
const BGM_FOLDER: String = "res://resources/audio/bgm/"

const HIT_SFX = SFX_FOLDER + "bump.wav"
const DIE_SFX = SFX_FOLDER + "lose.wav"
const VICTORY_JINGLE = BGM_FOLDER + "victory.wav"
const GAME_BGM = BGM_FOLDER + "game.wav"
const MENU_BGM = BGM_FOLDER + "menu.wav"

# Dictionary of preloaded sounds
var sfx = {
	"stab": preload(HIT_SFX),
	"bounce": preload(HIT_SFX),
	"hit": preload(HIT_SFX),
	"die": preload(DIE_SFX)
}

var music = {
	"menu": preload(MENU_BGM),
	"battle": preload(GAME_BGM),
	"victory": preload(VICTORY_JINGLE)
}

# --- Pool Settings ---
const MAX_SFX_PLAYERS = 4   # How many simultaneous SFX you allow
var sfx_pool: Array[AudioStreamPlayer] = []
var music_player: AudioStreamPlayer

func _ready():
	# Create SFX pool
	for i in MAX_SFX_PLAYERS:
		var p = AudioStreamPlayer.new()
		p.bus = "SFX"
		add_child(p)
		sfx_pool.append(p)

	# Create dedicated music player
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music"
	add_child(music_player)

# --- Play a sound effect ---
func play_sfx(name: String):
	if name in sfx:
		var stream = sfx[name]
		var player = _get_free_sfx_player()
		if player:
			player.stream = stream
			player.play()
		else:
			push_warning("No free SFX players available for '%s'!" % name)
	else:
		push_warning("SFX '%s' not found in dictionary!" % name)

# --- Play background music (loops) ---
func play_music(name: String):
	if name in music:
		music_player.stream = music[name]
		music_player.stream.loop = true
		music_player.play()
	else:
		push_warning("Music '%s' not found in dictionary!" % name)

# --- Stop music ---
func stop_music():
	music_player.stop()

func stop_all_sfx():
	for p in sfx_pool:
		if p.playing:
			p.stop()
			
func set_mute(bus_name: String, mute: bool):
	var bus_idx = AudioServer.get_bus_index(bus_name)
	if bus_idx == -1:
		push_warning("Bus '%s' not found!" % bus_name)
		return
	AudioServer.set_bus_mute(bus_idx, mute)

# --- Find a free SFX player ---
func _get_free_sfx_player() -> AudioStreamPlayer:
	for p in sfx_pool:
		if not p.playing:
			return p
	return null  # all are busy
