module [age]

Planet : [
    Mercury,
    Venus,
    Earth,
    Mars,
    Jupiter,
    Saturn,
    Uranus,
    Neptune,
]

age : Planet, Dec -> Dec
age = |planet, seconds|
    days = seconds/(365.25*60*60*24) # calc a year in seconds and divide
    when planet is
        Mercury -> days / 0.2408467
        Venus ->  days / 0.61519726
        Earth -> days
        Mars -> days / 1.8808158
        Jupiter -> days / 11.862615
        Saturn -> days / 29.447498
        Uranus -> days / 84.016846
        Neptune -> days / 164.79132
