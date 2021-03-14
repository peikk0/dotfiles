"""
Load ipython-nord-theme
"""

try:
    from ipython_nord_theme.startup import load
    load()
    del load  # don't pollute global namespace!!
except ModuleNotFoundError:
    pass
