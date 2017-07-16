class MusicPlayer
	def initialize(no_of_songs, save_changes_setting)
		@songs = []
		@save_changes = save_changes_setting
		no_of_songs.times do |song|
			@songs.push(song+1)
		end
	end
	
	def skip_from_to(skip_from , skip_to)
		@new_list = @songs.slice(0, skip_from - 1)
		@new_list += @songs.slice(skip_to, @songs.length - skip_to)
		@new_list += @songs.slice(skip_from - 1, skip_to - skip_from + 1)

		@songs = @new_list if @save_changes
		printSongs
	end
	
	def play
		skip_tracks(0)
	end

	def skip_tracks(count = 1)
		count += @songs.length if count.negative?
		skip_from_to(1, count)
	end

	def shuffle
		@new_list = @songs.shuffle
		
		@songs = @new_list if @save_changes
		printSongs	
	end

	def printSongs
		print "PlayList: "
		
		@new_list.each do |song|
			print "#{song} " 
		end
		
		puts
	end
end

ipod = MusicPlayer.new(10, false)
ipod.play
ipod.skip_tracks
ipod.skip_tracks(3)
ipod.skip_tracks(-5)
ipod.skip_from_to(3, 5)
ipod.shuffle
ipod.skip_tracks(2)
