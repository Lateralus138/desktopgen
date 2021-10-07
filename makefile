# This is a general template and not all of the sections
# may apply to the project.

CC=g++-9
ACC=arm-linux-gnueabi-g++-9

SRCDIR=src
TSTDIR=test
DBGDIR=debug
RELDIR=release
LINRELDIR=$(RELDIR)/linux
ANDRELDIR=$(RELDIR)/android
MACRELDIR=$(RELDIR)/macos
LINDBGDIR=$(DBGDIR)/linux
ANDDBGDIR=$(DBGDIR)/android
MACDBGDIR=$(DBGDIR)/macos
LINTSTDIR=$(TSTDIR)/linux
ANDTSTDIR=$(TSTDIR)/android
MACTSTDIR=$(TSTDIR)/macos
LINTSTDYNDIR=$(LINTSTDIR)/dynamic
LINTSTSTTDIR=$(LINTSTDIR)/static
ANDTSTDYNDIR=$(ANDTSTDIR)/dynamic
ANDTSTSTTDIR=$(ANDTSTDIR)/static
MACTSTDYNDIR=$(MACTSTDIR)/dynamic
MACTSTSTTDIR=$(MACTSTDIR)/static
LINDBGDYNDIR=$(LINDBGDIR)/dynamic
LINDBGSTTDIR=$(LINDBGDIR)/static
ANDDBGDYNDIR=$(ANDDBGDIR)/dynamic
ANDDBGSTTDIR=$(ANDDBGDIR)/static
MACDBGDYNDIR=$(MACDBGDIR)/dynamic
MACDBGSTTDIR=$(MACDBGDIR)/static
LINRELDYNDIR=$(LINRELDIR)/dynamic
LINRELSTTDIR=$(LINRELDIR)/static
ANDRELDYNDIR=$(ANDRELDIR)/dynamic
ANDRELSTTDIR=$(ANDRELDIR)/static
MACRELDYNDIR=$(MACRELDIR)/dynamic
MACRELSTTDIR=$(MACRELDIR)/static
LIBDIR=$(SRCDIR)/lib
INCDIR=$(SRCDIR)/include

# LIBS=-lProgramErrors -lfunctions

BIN=desktopgen

SRCNAM=main
SRCEXT=cpp
SRC=$(SRCNAM).$(SRCEXT)

EXTRA_SOURCE=$(LIBDIR)/*.o
EXTRA_SOURCE_A=$(LIBDIR)/*.ao
SRCPTH=$(SRCDIR)/$(SRC)

CF_STATIC=-static -static-libgcc -static-libstdc++
# CF_GTK=`pkg-config --cflags --libs gtk+-3.0`
CF_DBG=-g -Wall -Wextra -fsanitize=address -fsanitize=undefined -fno-sanitize-recover=all -fsanitize=float-divide-by-zero -fsanitize=float-cast-overflow -fno-sanitize=null -fno-sanitize=alignment -std=c++17
CF_DBG_STATIC=$(CF_STATIC) $(CF_DBG)
CF_REL=-O3 -std=c++17
CF_REL_STATIC=$(CF_STATIC) $(CF_REL)
CF_AND=$(CF_REL) -march=armv8-a
CF_AND_STATIC=$(CF_STATIC) $(CF_AND)

TSTARG=--help

$(SRCNAM): $(SRCPTH) $(EXTRA_SOURCE)
	@echo Removing Release directory.
	@rm -rf $(LINRELDYNDIR)
	@echo Creating Release directory.
	@mkdir -p $(LINRELDYNDIR)
	@echo "Compiling ${SRCPTH} and ${EXTRA_SOURCE} to ${LINRELDYNDIR}/${BIN}"
	@$(CC) $(CF_REL) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(LINRELDYNDIR)/$(BIN) $(LIBS) $(CF_GTK)

buildfunctions: $(INCDIR)/functions.cpp
	@echo "Compiling $(INCDIR)/functions.cpp and ${EXTRA_SOURCE} to $(LIBDIR)/functions.o"
	@$(CC) $(CF_REL) -c $(INCDIR)/functions.cpp -o $(LIBDIR)/functions.o

buildprogramerrors: $(INCDIR)/ProgramErrors.cpp
	@echo "Compiling $(INCDIR)/ProgramErrors.cpp to $(LIBDIR)/ProgramErrors.o"
	@$(CC) $(CF_REL) -c $(INCDIR)/ProgramErrors.cpp -o $(LIBDIR)/ProgramErrors.o

buildpe: $(INCDIR)/pe.cpp
	@echo "Compiling $(INCDIR)/pe.cpp to $(LIBDIR)/pe.o"
	@$(CC) $(CF_REL) -c $(INCDIR)/pe.cpp -o $(LIBDIR)/pe.o

buildlibs:
	@echo "Compiling $(INCDIR)/functions.cpp and ${EXTRA_SOURCE} to $(LIBDIR)/functions.o"
	@$(CC) $(CF_REL) -c $(INCDIR)/functions.cpp -o $(LIBDIR)/functions.o
	@echo "Compiling $(INCDIR)/ProgramErrors.cpp to $(LIBDIR)/ProgramErrors.o"
	@$(CC) $(CF_REL) -c $(INCDIR)/ProgramErrors.cpp -o $(LIBDIR)/ProgramErrors.o
	@echo "Compiling $(INCDIR)/pe.cpp to $(LIBDIR)/pe.o"
	@$(CC) $(CF_REL) -c $(INCDIR)/pe.cpp -o $(LIBDIR)/pe.o


buildfunctions_a: $(INCDIR)/functions.cpp
	@echo "Compiling $(INCDIR)/functions.cpp and ${EXTRA_SOURCE_A} to $(LIBDIR)/functions.ao"
	@$(ACC) $(CF_REL) -c $(INCDIR)/functions.cpp -o $(LIBDIR)/functions.ao

buildprogramerrors_a: $(INCDIR)/ProgramErrors.cpp
	@echo "Compiling $(INCDIR)/ProgramErrors.cpp to $(LIBDIR)/ProgramErrors.ao"
	@$(ACC) $(CF_REL) -c $(INCDIR)/ProgramErrors.cpp -o $(LIBDIR)/ProgramErrors.ao

buildpe_a: $(INCDIR)/pe.cpp
	@echo "Compiling $(INCDIR)/pe.cpp to $(LIBDIR)/pe.ao"
	@$(ACC) $(CF_REL) -c $(INCDIR)/pe.cpp -o $(LIBDIR)/pe.ao

buildlibs_a:
	@echo "Compiling $(INCDIR)/functions.cpp and ${EXTRA_SOURCE} to $(LIBDIR)/functions.ao"
	@$(ACC) $(CF_REL) -c $(INCDIR)/functions.cpp -o $(LIBDIR)/functions.ao
	@echo "Compiling $(INCDIR)/ProgramErrors.cpp to $(LIBDIR)/ProgramErrors.ao"
	@$(ACC) $(CF_REL) -c $(INCDIR)/ProgramErrors.cpp -o $(LIBDIR)/ProgramErrors.ao
	@echo "Compiling $(INCDIR)/pe.cpp to $(LIBDIR)/pe.ao"
	@$(ACC) $(CF_REL) -c $(INCDIR)/pe.cpp -o $(LIBDIR)/pe.ao


static: $(SRCPTH) $(EXTRA_SOURCE)
	@echo Removing Release Static directory.
	@rm -rf $(LINRELSTTDIR)
	@echo Creating Release Static directory.
	@mkdir -p $(LINRELSTTDIR)
	@echo "Compiling $SRCPTH and $EXTRA_SOURCE to ${LINRELSTTDIR}/${BIN}"
	@$(CC) $(CF_REL_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(LINRELSTTDIR)/$(BIN) $(LIBS) $(CF_GTK)

android: $(SRCPTH) $(EXTRA_SOURCE)
	@echo Removing Android Dynamic directory.
	@rm -rf $(ANDRELDYNDIR)
	@echo Creating Android Dynamic directory.
	@mkdir -p $(ANDRELDYNDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE_A} to $(ANDRELDYNDIR)/$(BIN)"
	@$(ACC) $(CF_AND) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE_A) -o $(ANDRELDYNDIR)/$(BIN) $(LIBS) $(CF_GTK)

androidstatic: $(SRCPTH) $(EXTRA_SOURCE)
	@echo Removing Android Dynamic directory.
	@rm -rf $(ANDRELSTTDIR)
	@echo Creating Android Dynamic directory.
	@mkdir -p $(ANDRELSTTDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE_A} to $(ANDRELSTTDIR)/$(BIN)"
	@$(ACC) $(CF_AND_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE_A) -o $(ANDRELSTTDIR)/$(BIN) $(LIBS) $(CF_GTK)

macos:
	@echo Removing MacOs Release Dynamic directory.
	@rm -rf $(MACRELDYNDIR)
	@echo Creating MacOs Release Dynamic directory.
	@mkdir -p $(MACRELDYNDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE} to $(MACRELDYNDIR)/$(BIN)"
	@$(CC) $(CF_REL) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(MACRELDYNDIR)/$(BIN) $(LIBS) $(CF_GTK)

macosstatic:
	@echo Removing MacOs Release Static directory.
	@rm -rf $(MACRELSTTDIR)
	@echo Creating MacOs Release Static directory.
	@mkdir -p $(MACRELSTTDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE} to $(MACRELSTTDIR)/$(BIN)"
	@$(CC) $(CF_REL_STATIC) -I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/include -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(MACRELSTTDIR)/$(BIN)

debug:
	@echo Removing Debug Dynamic directory.
	@rm -rf $(LINDBGDYNDIR)
	@echo Creating Debug Dynamic directory.
	@mkdir -p $(LINDBGDYNDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE} to $(LINDBGDYNDIR)/$(BIN)"
	@$(CC) $(CF_DBG) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(LINDBGDYNDIR)/$(BIN) $(LIBS) $(CF_GTK)

debugstatic:
	@echo Removing Debug Static directory.
	@rm -rf $(LINDBGSTTDIR)
	@echo Creating Debug Static directory.
	@mkdir -p $(LINDBGSTTDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE} to $(LINDBGSTTDIR)/$(BIN)"
	@$(CC) $(CF_DBG_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(LINDBGSTTDIR)/$(BIN) $(LIBS) $(CF_GTK)

debugandroid:
	@echo Removing Android Debug Dynamic directory.
	@rm -rf $(ANDDBGDYNDIR)
	@echo Creating Android Debug Dynamic directory.
	@mkdir -p $(ANDDBGDYNDIR)
	@echo "Compiling $(SRCDIR)/main.cppand ${EXTRA_SOURCE} to $(ANDDBGDYNDIR)/$(BIN)"
	@$(ACC) $(CF_AND) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(ANDDBGDYNDIR)/$(BIN) $(LIBS) $(CF_GTK)

debugandroidstatic:
	@echo Removing Android Debug Static directory.
	@rm -rf $(ANDDBGSTTDIR)
	@echo Creating Android Debug Static directory.
	@mkdir -p $(ANDDBGSTTDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE} to $(ANDDBGSTTDIR)/$(BIN)"
	@$(ACC) $(CF_AND_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(ANDDBGSTTDIR)/$(BIN) $(LIBS) $(CF_GTK)

debugmacos:
	@echo Removing MacOs Debug Dynamic directory.
	@rm -rf $(MACDBGDYNDIR)
	@echo Creating MacOs Debug Dynamic directory.
	@mkdir -p $(MACDBGDYNDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE} to $(MACDBGDYNDIR)/$(BIN)"
	@$(CC) $(CF_DBG) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(MACDBGDYNDIR)/$(BIN) $(LIBS) $(CF_GTK)

debugmacosstatic:
	@echo Removing MacOs Debug Static directory.
	@rm -rf $(MACDBGSTTDIR)
	@echo Creating MacOs Debug Static directory.
	@mkdir -p $(MACDBGSTTDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE} to $(MACDBGSTTDIR)/$(BIN)"
	@$(CC) $(CF_DBG_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(MACDBGSTTDIR)/$(BIN) $(LIBS) $(CF_GTK)

test:
	@echo Removing Test Dynamic directory.
	@rm -rf $(LINTSTDYNDIR)
	@echo Creating Test Dynamic directory.
	@mkdir -p $(LINTSTDYNDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE} to $(LINTSTDYNDIR)/$(BIN)"
	@$(CC) $(CF_DBG) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(LINTSTDYNDIR)/$(BIN) $(LIBS) $(CF_GTK)
	@echo "Running Debug Dynamic test"
	./$(LINTSTDYNDIR)/$(BIN) $(TSTARG)

teststatic:
	@echo Removing Test Static directory.
	@rm -rf $(LINTSTSTTDIR)
	@echo Creating Test Static directory.
	@mkdir -p $(LINTSTSTTDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE} to $(LINTSTSTTDIR)/$(BIN)"
	@$(CC) $(CF_DBG_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(LINTSTSTTDIR)/$(BIN) $(LIBS) $(CF_GTK)
	@echo "Running Debug Static test"
	./$(LINTSTSTTDIR)/$(BIN) $(TSTARG)

testandroid:
	@echo Removing Android Test Dynamic directory.
	@rm -rf $(ANDTSTDYNDIR)
	@echo Creating Android Test Dynamic directory.
	@mkdir -p $(ANDTSTDYNDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE_A} to $(ANDTSTDYNDIR)/$(BIN)"
	@$(ACC) $(CF_AND) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE_A) -o $(ANDTSTDYNDIR)/$(BIN)
	@echo "Running Android Dynamic test"
	./$(ANDTSTDYNDIR)/$(BIN) $(TSTARG)

testandroidstatic:
	@echo Removing Android Test Static directory.
	@rm -rf $(ANDTSTDYNDIR)
	@echo Creating Android Test Static directory.
	@mkdir -p $(ANDTSTDYNDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE_A} to $(ANDTSTDYNDIR)/$(BIN)"
	@$(ACC) $(CF_AND) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE_A) -o $(ANDTSTDYNDIR)/$(BIN)
	@echo "Running Android Static test"
	./$(ANDTSTDYNDIR)/$(BIN) $(TSTARG)

testmacos:
	@echo Removing MacOs Test Dynamic directory.
	@rm -rf $(MACTSTDYNDIR)
	@echo Creating MacOs Test Dynamic directory.
	@mkdir -p $(MACTSTDYNDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE} to $(MACTSTDYNDIR)/$(BIN)"
	@$(CC) $(CF_DBG) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(MACTSTDYNDIR)/$(BIN)
	@echo "Running MacOs Dynamic test"
	./$(MACTSTDYNDIR)/$(BIN) $(TSTARG)

testmacosstatic:
	@echo Removing MacOs Test Static directory.
	@rm -rf $(MACTSTSTTDIR)
	@echo Creating MacOs Test Static directory.
	@mkdir -p $(MACTSTSTTDIR)
	@echo "Compiling $(SRCDIR)/main.cpp and ${EXTRA_SOURCE} to $(MACTSTSTTDIR)/$(BIN)"
	@$(CC) $(CF_DBG_STATIC) -I$(INCDIR) -L$(LIBDIR) $(SRCPTH) $(EXTRA_SOURCE) -o $(MACTSTSTTDIR)/$(BIN)
	@echo "Running MacOs Static test"
	./$(MACTSTSTTDIR)/$(BIN) $(TSTARG)

install: $(SRCNAM)
	@echo "Installing $(LINRELDYNDIR)/$(BIN) to /usr/bin/$(BIN)"
	@cp -f "$(LINRELDYNDIR)/$(BIN)" "/usr/bin/$(BIN)"

installstatic: static
	@echo "Installing $(LINRELSTTDIR)/$(BIN) to /usr/bin/$(BIN)"
	@cp -f "$(LINRELSTTDIR)/$(BIN)" "/usr/bin/$(BIN)"

clean:
	@echo Removing Release directory.
	@rm -rf $(RELDIR)
	@echo Removing Test directory.
	@rm -rf $(TSTDIR)
	@echo Removing Debug directory.
	@rm -rf $(DBGDIR)

cleanrelease:
	@echo Removing Release directory.
	@rm -rf $(RELDIR)

cleantest:
	@echo Removing Test directory.
	@rm -rf $(TSTDIR)

cleandebug:
	@echo Removing Debug directory.
	@rm -rf $(DBGDIR)

cleanlibs:
	@echo Removing lib directory.
	@rm -rf $(LIBDIR)/*
