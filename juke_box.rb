def skip_tracks(playlist, count)
  puts "Skipping #{count} track(s)"
  puts playlist.rotate!(count).join(' -> ')
end

playlist = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
puts "Original Playlist"
puts playlist.join(' -> ')
skip_tracks(playlist, 1)
skip_tracks(playlist, 3)
skip_tracks(playlist, -2)
skip_tracks(playlist, 12)
skip_tracks(playlist, 0)
