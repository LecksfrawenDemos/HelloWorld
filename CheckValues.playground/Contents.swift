import UIKit

let minRange: Double = 0.1
let maxRange: Double = 0.40
var originalPitchRange: ClosedRange = minRange...maxRange
var pitchValues: [Double] = [
  0.0045,
  0.0044,
  0.0047,
  0.0043,
  1.5169,
  0.7984,
  0.0074,
  0.0068,
  0.0069,
  0.0059,
  0.0057,
  0.0054,
  0.0050,
  0.0051,
  0.0045,
  0.0050,
  0.0046,
  0.0047,
  0.0050,
  0.0049,
  0.0048,
  0.0048,
  0.0047,
  0.0047,
  0.0047,
  0.0047,
  0.0047,
  0.0046,
  0.0048,
  0.0049,
  0.0048,
  0.0050,
  0.0048,
  0.0048,
  0.0050,
  0.0050,
  0.0050,
  0.0050,
  0.0050,
  0.0050,
  0.0050,
  0.0047,
  0.0048
]
var currentPitchValue: Double = 0.3
var hasMoved: Bool = false
switch currentPitchValue {
  case originalPitchRange: hasMoved = false
  default: hasMoved = true
}

// Obtener el rango minimo permitido
// Revisar que el valor actual no se salga del rango permitodo
// Si se sale, mostrar en el print que se haya salido o no del rango permitido

//let currentPitchIsHigher = pitchValues > originalPitch
//let currentPitchIsLower = pitchValues < originalPitch
//hasMoved = currentPitchIsHigher || currentPitchIsLower

print("Has moved: \(hasMoved ? "YES" : "NO")")
