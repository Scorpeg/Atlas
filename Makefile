SRCDIR                = .
EXES                  = atlas

### atlas sources and settings

ATLAS_MODULE          = atlas
ATLAS_CXX_SRCS        = AtlasCore.cpp \
			AtlasExtension.cpp \
			AtlasFile.cpp \
			AtlasLogger.cpp \
			AtlasMain.cpp \
			AtlasParser.cpp \
			AtlasStats.cpp \
			AtlasTypes.cpp \
			GenericVariable.cpp \
			Pointer.cpp \
			PointerHandler.cpp \
			Table.cpp

ATLAS_LIBRARIES       = dl \
                        ncurses

ATLAS_OBJS            = $(ATLAS_CXX_SRCS:.cpp=.o)

### Global source lists

CXX_SRCS              = $(ATLAS_CXX_SRCS)

### Tools

CXX = g++

### Generic targets

all: $(EXES)

### Build rules

.PHONY: all clean dummy

$(SUBDIRS): dummy
	@cd $@ && $(MAKE)

# Implicit rules

.SUFFIXES: .cpp
DEFINCL = $(INCLUDE_PATH) $(DEFINES) $(OPTIONS)

.cpp.o:
	$(CXX) -c $(CXXFLAGS) $(CXXEXTRA) $(DEFINCL) -o $@ $<

# Rules for cleaning

CLEAN_FILES     = y.tab.c y.tab.h lex.yy.c core *.orig *.rej \
                  \\\#*\\\# *~ *% .\\\#*

clean::
	$(RM) $(CLEAN_FILES) $(CXX_SRCS:.cpp=.o)
	$(RM) $(LIBS) $(EXES)

$(SUBDIRS:%=%/__clean__): dummy
	cd `dirname $@` && $(MAKE) clean

$(EXTRASUBDIRS:%=%/__clean__): dummy
	-cd `dirname $@` && $(RM) $(CLEAN_FILES)

### Target specific build rules
$(ATLAS_MODULE): $(ATLAS_OBJS)
	$(CXX) $(ATLAS_LDFLAGS) -o $@ $(ATLAS_OBJS) $(ATLAS_LIBRARIES:%=-l%)


