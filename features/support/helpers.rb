# frozen_string_literal: true

module Helpers
  # metodo para destacar um elemento e setar um texto
  def set_text(element, text)
    highlight_element(element)
    element.set(text)
  end

  # metodo para clicar em qualquer menu da lista de opçoes do site
  def select_element_for_text(element, text)
    a = element, :text, text
    a.click
  end

  # metodo para clicar num elemento da lista
  # recebe o index do item ou o valor a ser buscado na lista
  def click_item_list(text)
    if text.is_a?(Numeric)
      list_item[text].click
    elsif text.is_a?(String)
      list_item.each do |item|
        if item.text.include?(text)
          item.click
          return
        end
      end
      raise "Opção não encontrada na lista: #{text}"
    end
  end

  # retorna a lista de itens ao abrir os optins genéricos do site
  def list_item
    return all('div[class$="-menu"] > div > div')
  end

  # metodo usado para fazer o scroll da tela caso o elemento nao esteja na mesma, ate encontralo
  def scroll_element(element)
    execute_script('arguments[0].scrollIntoView(true);', element)
    highlight_element(element)
  end

  # metodo usado para detacar o elemento interagido
  def highlight_element(element)
    execute_script("arguments[0].style.border='3px solid red'", element)
  end

  # metodo usado para esconder o elemento
  def hide_element(element)
    execute_script("arguments[0].style.display='none'", element)
  end

  # metodo usado para capturar o último texto copiado
  def paste_clipboard_text
    page.driver.browser.execute_cdp('Browser.grantPermissions', origin: $LOGGED_URL, permissions: ['clipboardReadWrite'])
    page.evaluate_async_script('navigator.clipboard.readText().then(arguments[0])')
  end

  # metodo para selecionar opçoes em combobox
  def select_combobox(element, list, option)
    find(element).click
    find(list, text: option).click
  end

  # valida a URL de uma pagina que foi aberta a partir de uma ação.
  # passa a url e ele verifica se essa url esta certa
  def validate_url(compare)
    sleep(10)
    switch_to_window(windows.last)
    url = current_url
    raise 'The information not match. Please, check the received url: ' + url if url != compare
  end

  def verify_match_text(title, title2)
    raise "The text not match. #{title} / Title home news #{title2}" if title != title2
  end

  def verify_text_include(element, text)
    highlight_element(element)
    unless element.include?(text)
      raise "Text not include in the string. Element text #{element} / text validation #{text}"
    end
  end

  def validate_popup(message)
    sleep 6
    accept_alert(message)
  end

  def validate_modal(message)
    modal = find('.content > div')
    raise "Message wrong. Check the received message: #{modal.text}" unless modal.text.include?(message)

    sleep(1)
    modal.find('button').click
  end
end
