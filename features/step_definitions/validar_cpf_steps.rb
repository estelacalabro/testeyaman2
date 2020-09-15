Dado('que estou na tela de login') do
  #binding.pry

  @validar.button_login.hover
  @validar.button_entrar.click
end

Quando('preencho com cpf válido') do
  sleep 6
  @validar.campo_cpf.send_keys "343.774.690-10"
end

Quando('preencho com cpf inválido') do
  sleep 6
  @validar.campo_cpf.send_keys "21548745898"
end

Entao('valido a mensagem de cpf inválido') do
  @validar.message_failed.visible?
end   

Entao('valido cpf válido') do
  @validar.message_success.visible?
end  

  
