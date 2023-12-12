# Mercado Libre

## SwiftUI / Clean Architecture / POP

Para este challenge, intenté implementar una arquitectura 'Clean Architecture' usando también MVVM para gestionar las interacciones del usuario donde se mantuvo la estricta interacción de cada capa con su simil correspondiente, por ejemplo: la capa de presentación no debería tener contacto con la capa de datos. En la app se cumple con los requerimientos mínimos como son la búsqueda de productos por nombre, la visualización de resultados y el detalle de producto, como también el manejo de errores y la responsividad. Para la prueba, se intentó al máximo mantener la limpieza del código mediante la inyección de dependencias, manejo del acoplamiento y cohesión, programación orientada a protocolos y encapsulamiento.

Como oportunidad de mejora, se intentó adherir servicios de almacenamiento local con CoreData que se encuentran inconclusos, donde se podría añadir servicios a las pestañas de navegación de la App, asegurar aún más el funcionamiento correcto de la App con más pruebas unitarias y agregar algunas vistas de vacío.  

![evidence](https://github.com/soyedy/Mercado-Libre/assets/152434253/4b439d5e-7651-4c8f-91eb-39ec329a389e)
