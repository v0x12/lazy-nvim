---@diagnostic disable: lowercase-global

ignore = {
	"111", -- setting non-standard global variable
	"212/_.*", -- unusued argument, for vars with "_" prefix
	"214", -- unusued variable with unusued hint ("_" prefix)
	"121", -- setting read-only global variable 'vim'
	"122", -- setting read-only field of global variable 'vim'
}

-- Global objects defined by the C code
read_globals = {
	"vim",
}
