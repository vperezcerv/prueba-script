#!/bin/bash

# Lista de ramas permitidas
allowed_branches=("HEAD" "laboratory" "main")

# Obtener la lista de todas las ramas remotas
all_remote_branches=$(git ls-remote --heads origin | cut -f2 | sed 's#refs/heads/##')

# Eliminar ramas remotas que no están permitidas
for branch in $all_remote_branches; do
  if ! [[ " ${allowed_branches[@]} " =~ " $branch " ]]; then
    if [ "$branch" != "HEAD" ]; then
      git push origin --delete $branch
      echo "Rama remota eliminada: $branch"
    else
      echo "ADVERTENCIA: No se puede eliminar la rama HEAD directamente."
    fi
  fi
done

