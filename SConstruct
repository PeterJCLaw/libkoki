import os

# Install prefix:
DESTDIR = os.getenv( "DESTDIR", default = "" )

def dest( fname ):
    "Prefix the given filename with DESTDIR"

    return "{0}{1}".format( os.getenv( "DESTDIR", default = "" ),
                            fname )

env = Environment( CPPPATH = "#include",
                   CCFLAGS = "-O3 -g -std=gnu99 -Werror",
                   tools = [ "default", "doxygen" ],
                   toolpath = "." )

env.ParseConfig( "pkg-config --cflags --libs opencv glib-2.0 yaml-0.1" )

# An environment that links against libkoki
lk_env = env.Clone()
lk_env.Append( LIBS = "koki", LIBPATH = "#lib" )

# things that the install target should install
install = []

Export("env lk_env dest install")

SConscript( Glob( "*/SConscript" ) )

env.Alias( "install", install )