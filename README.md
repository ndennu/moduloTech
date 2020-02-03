# moduloTech

Test technique réalisé par Nicolas DENNU pour ModuloTech.
Langage utilisé: Swift

## Outils utilisés

- CoreData
- URLSession, URLURLRequest
- Codable
- carthage

## Achitecture

Utilisation du parttern MVVM

## Carthage - Framework

### Installation

```
Dans le dossier TestModuloTech, lancer la commande suivante:
$ carthage update --platform iOS
```

### Dépendance

```
ninjaprox/NVActivityIndicatorView -> loader
hackiftekhar/IQKeyboardManager -> pour gérer les textfields
AssistoLab/DropDown -> pour les filtres
```

## Fonctionnalités disponible

### Page d'accueil
Visualiser tous mes appareils disponibles
Maintenir le doigt sur sur l'appareil pour avoir la possibilité de le supprimer

### Page utilisateur
Permet de modifier les informations de l'utilisateur

### Page de détail pour chaque équipment
Gestions des intensités, températures et les positions des vollets rollants
