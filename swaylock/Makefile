WALLPAPER = ../sway/wallpaper
LOCK_BG = lock-bg

all: $(LOCK_BG)

$(LOCK_BG): $(WALLPAPER)
	gm convert $(WALLPAPER) -colorspace Gray -blur 0x8 $(LOCK_BG)

clean:
	rm -f $(LOCK_BG)

.PHONY: all clean
