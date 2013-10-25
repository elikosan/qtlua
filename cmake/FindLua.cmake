# - Find lua
# this module looks for Lua
#
#  LUA_EXECUTABLE - the full path to lua
#  LUA_LIBRARIES - the lua shared library
#  LUA_INCLUDE_DIR - directory for lua includes
#  LUA_PACKAGE_PATH - where Lua searches for Lua packages
#  LUA_PACKAGE_CPATH - where Lua searches for library packages
#  LUA_FOUND      - If false, don't attempt to use lua.

INCLUDE(CheckLibraryExists)

SET(LUA_EXECUTABLE "${LUA}")

FIND_LIBRARY(LUA_LIBRARIES
  NAMES lua liblua luajit libluajit lua-5.1 luajit-5.1 liblua-5.1 libluajit-5.1
  PATHS ${LUA_LIBDIR}
  ${LUA_BINDIR}
  NO_DEFAULT_PATH)

IF(LUA_LIBRARIES)
  CHECK_LIBRARY_EXISTS(${LUA_LIBRARIES} luaJIT_setmode "" LUA_JIT)
ENDIF()

SET(LUA_INCLUDE_DIR "${LUA_INCDIR}")

SET(LUA_PACKAGE_PATH "${LUADIR}")
SET(LUA_PACKAGE_CPATH "${LIBDIR}")

MARK_AS_ADVANCED(
  LUA_EXECUTABLE
  LUA_LIBRARIES
  LUA_INCLUDE_DIR
  LUA_PACKAGE_PATH
  LUA_PACKAGE_CPATH
  )

IF(LUA_EXECUTABLE)
  IF(LUA_LIBRARIES)
    IF(LUA_INCLUDE_DIR)
      SET(LUA_FOUND 1)
    ENDIF(LUA_INCLUDE_DIR)
  ENDIF(LUA_LIBRARIES)
ENDIF(LUA_EXECUTABLE)

IF (NOT LUA_FOUND AND Lua_FIND_REQUIRED)
  MESSAGE(FATAL_ERROR "Could not find Lua")
ENDIF (NOT LUA_FOUND AND Lua_FIND_REQUIRED)

IF(NOT Lua_FIND_QUIETLY)
  IF(LUA_FOUND)
    MESSAGE(STATUS "Lua found ${LUA_EXECUTABLE}")
  ELSE(LUA_FOUND)
    MESSAGE(STATUS "Lua not found. Please specify location")
  ENDIF(LUA_FOUND)
ENDIF(NOT Lua_FIND_QUIETLY)
