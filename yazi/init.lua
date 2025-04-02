function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)

	local time_str

	if time == 0 then
		time_str = ''
	elseif os.date('%Y', time) == os.date '%Y' then
		time_str = os.date('%b %d %H:%M', time)
	else
		time_str = os.date('%b %d  %Y', time)
	end

	local size = self._file:size()

	return string.format('%s %s', size and ya.readable_size(size) or '', time_str)
end
