#language: pt
@testeyaman
Funcionalidade: validar campo cpf

@CT01
Cenário: cpf válido
Dado que estou na tela de login
Quando preencho com cpf válido
Entao valido cpf válido

@CT02
Cenário: cpf inválido
Dado que estou na tela de login
Quando preencho com cpf inválido
Entao valido a mensagem de cpf inválido
