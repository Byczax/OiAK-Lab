#!/bin/bash
make && echo {a..z} {A..Z} {0..9} '!@#$%^&*(){|}[]<>,./\;:"' | tr -d ' ' | out/lab01
# to jest plik testujący wszystkie symbole które zostaną zamienione