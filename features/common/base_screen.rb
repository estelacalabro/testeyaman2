module BaseScreen

  #metodo para destacar um elemento e setar um texto
  def set_text(element, text)
    highlight_element(element)
    element.set text
  end

  #metodo para clicar em qualquer menu da lista de opçoes do site
  def select_element_for_text(element, text)
    a = element, :text, text
    a.click
  end

  #metodo usado para fazer o scroll da tela caso o elemento nao esteja na mesma, ate encontralo
  def scroll_element(element)
    execute_script("arguments[0].scrollIntoView(true);", element)
    highlight_element(element)
  end

  #metodo usado para detacar o elemento interagido
  def highlight_element(element)
    execute_script("arguments[0].style.border='3px solid red'", element)
  end

  #metodo para selecionar opçoes em combobox
  def select_combobox(element,list,option)
    find(element).click
    find(list, :text => option).click
  rescue 'Element not exist'
  end

  # valida a URL de uma pagina que foi aberta a partir de uma ação.
  # passa a url e ele verifica se essa url esta certa
  def validate_url(compare)
    sleep 10
    switch_to_window(windows.last)
    url = current_url
    if url != compare
      raise "The information not match. Please, check the received url: " + url
    end
  end

  def verify_match_text(title, title2)
    if title != title2
      raise "The text not match. #{title} / Title home news #{title2}"
    end
  end

  def verify_text_include(element, text)
    highlight_element(element)
    raise "Text not include in the string. Element text #{element} / text validation #{text}" unless element.include? text
  end

  def validate_popup(message)
    accept_confirm message do
      evaluate_script('window.confirm = function() { return true; }')
    end    
  end
  
end