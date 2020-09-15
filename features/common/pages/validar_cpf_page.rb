# MAPEAMENTO DA PAGINA PRINCIPAL DO SITE
class ValidarScreen < SitePrism::Page

    include BaseScreen
    include Helpers

    element :button_login, '#span-arrowDown'
    element :button_entrar, '#a-buttonLogin' 
    element :campo_cpf, '#username'
    element :message_success, '.icon.icon-success'
    element :message_failed, '#cpferrormsg'

end

