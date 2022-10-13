//
//  main.swift
//  plannerComH
//
//  Created by Helaine Pontes on 30/03/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import Foundation

enum MesesAno: String, CaseIterable {
   case janeiro 
   case feveireiro
   case marco
   case abril
   case maio
   case junho
   case julho
   case agosto
   case setembro
   case outubro
   case novembro
   case dezembro
}
struct AtividadeDia: Equatable{
    var nomeAtividade: String
    var horarioAtividade: String
    // var categoria: String
}
struct Dias{
    var data: String
    var atividadesDoDia: [AtividadeDia]
    var nomeDiaSemana: String //sabado, domingo, segunda...
}
func verificarQntdDias(mesEscolhido: Int) -> Int{
    let mesesCom30: Set = [3,5,8,10] //Set é uma lista não ordenada de elementos únicos
    if mesesCom30.contains(mesEscolhido) {
        return 30
    }
    else if mesEscolhido == 1{
        return 29 // É um ano bissexto
    }
    else{
        return 31
    }
}
var mes: [Dias] = []
var ano = [mes]
var dia = 0
for i in 0...11{ //inserção dos meses no ano
    let diasDaSemana=[ "Quarta", "Quinta", "Sexta", "Sábado", "Domingo", "Segunda", "Terça"]
    mes = []
    for j in 1...verificarQntdDias(mesEscolhido: i) {
        mes.append(Dias(data: String(j-1), atividadesDoDia: [], nomeDiaSemana: diasDaSemana[dia]))
        dia+=1
        if(dia>6){
          dia = 0
        }
        
    }
    ano.insert(mes,at: i)
    //print("\n mês \(i)\n\(ano[i])")
}
func escolheMes() -> Int{
    print("\nEm qual mês você deseja operar? 1 - Janeiro ... 12 - Dezembro")
    var entradaMes = Int(readLine() ?? "") ?? 13
    entradaMes-=1
    if(entradaMes>=0 && entradaMes<12){
        for i in 0...11{
            if i==entradaMes{
                return i
            }
        }
    }
    print("\nEsse mês não existe!")
    return escolheMes()
}

func transformaMes(mesEscolhido: Int) -> String {
    return MesesAno.allCases[mesEscolhido].rawValue
}

func verificaHorario() -> String{
    print("\nQual o horário da atividade? HH:MM ")
    let horarioAtividade = readLine() ?? "Vazio"
    if horarioAtividade.contains(":") && horarioAtividade.count == 5 {
        let horarioNovo = horarioAtividade.split(separator: ":")
        let horas=Int(horarioNovo[0]) ?? -1
        let minutos=Int(horarioNovo[1]) ?? -1
        if(horas>=0 && horas<=23 && minutos>=0 && minutos<=59){
            return horarioAtividade
        }
    }
    print("\nHorário inválido!")
    return verificaHorario()
}
func sortHorario(dia: inout Dias) -> [AtividadeDia]{
  var diaSorted: [AtividadeDia] = []
  if dia.atividadesDoDia.count != 0{
    for _ in 1...dia.atividadesDoDia.count{
      var menorAtividade = dia.atividadesDoDia[0]
      for atividade in dia.atividadesDoDia{
        let horario = atividade.horarioAtividade.split(separator: ":")
        let horas=Int(horario[0]) ?? -1
        let minutos=Int(horario[1]) ?? -1
        let horarioMenorAtividade = menorAtividade.horarioAtividade.split(separator: ":")
        let horasMenorAtividade=Int(horarioMenorAtividade[0]) ?? -1
        let minutosMenorAtividade=Int(horarioMenorAtividade[1]) ?? -1
        if horas<horasMenorAtividade{
          menorAtividade = atividade
        }
        else if horas == horasMenorAtividade && minutos<minutosMenorAtividade{
          menorAtividade = atividade
        }
      }
      diaSorted.append(menorAtividade)
      if let index = dia.atividadesDoDia.firstIndex(of: menorAtividade) {
        dia.atividadesDoDia.remove(at: index)
    }
    }
  }
  return diaSorted
}
func verificaDia(diaMax: Int)->Int{
    print("\nEm qual dia a atividade se realizará?")
    let diaAtividade = readLine() ?? "Vazio"
    for i in 1...diaMax{
        if i == Int(diaAtividade) ?? -1{
            return i
        }
    }
    print("Dia iválido")
    return verificaDia(diaMax: diaMax)
}
func opcoesPlanner() -> String? {
    //print (ano[0])
    print("\n--------------------------------\nO que faremos hoje?\n1-Visualizar seu Planner\n2-Adicionar uma atividade\n3-Remover uma atividade\n4-Alterar uma atividade")
    let opcao: String? = readLine()
    guard let opcaoR = opcao else{
        return nil
        }
    switch(opcaoR){
    case("1"):
        _ = visualizarAtividades()    //funcao de visualizar
    case("2"):
        _ = adicionarAtividade()      //funcao de adicionar
    case("3"):
        _ = removerAtividade()        //funcao de remover
    case("4"):
        _ = alterarAtividade()        //funcao de alterar
    default:
        print("\nTá louco? Essa opção nem existe!!!")
    }
    return nil //não preciso dele :)
    }

func visualizarAtividades() -> String?{
    print("\nQual modo de visualização você deseja?\n1-Diária\n2-Semanal\n3-Mensal")
    let opcaoV = readLine() ?? "Vazio"
    switch(opcaoV){
    case "1":
        _ = visualizarAtividadesDiarias()
    case "2":
        _ = visualizarAtividadesSemanais()
    case "3":
        _ = visualizarAtividadesMensais()
    default:
        print("\nNão existe essa opção!")
    }
    return nil
}
func visualizarAtividadesDiarias() -> String?{
    let mesEscolhido = escolheMes()
    let diaEscolhido = verificaDia(diaMax:verificarQntdDias(mesEscolhido: mesEscolhido))
    ano[mesEscolhido][diaEscolhido-1].atividadesDoDia = sortHorario(dia: &ano[mesEscolhido][diaEscolhido-1])
    if ano[mesEscolhido][diaEscolhido-1].atividadesDoDia.count == 0{
        print("\nNão há atividades no dia \(diaEscolhido) do mês \(transformaMes(mesEscolhido: mesEscolhido))")
    }
    else{
        let mesTrans = transformaMes(mesEscolhido: mesEscolhido)//Transforma 0 em Janeiro, 1 em Fevereiro...
        print("\nMês \(mesTrans), dia \(diaEscolhido), \(ano[mesEscolhido][diaEscolhido-1].nomeDiaSemana)")
        for atividade in ano[mesEscolhido][diaEscolhido-1].atividadesDoDia{
            print("Atividade:\(atividade.nomeAtividade)      Horário:\(atividade.horarioAtividade) ")
        }
    }
   return nil
}
func visualizarAtividadesSemanais() -> String?{
  var mesEscolhido = escolheMes()
  var diaEscolhido = verificaDia(diaMax:verificarQntdDias(mesEscolhido: mesEscolhido))
  for _ in 0...6{
    if ano[mesEscolhido][diaEscolhido-1].nomeDiaSemana == "Domingo"{
      var i = 0
      for _ in 0...6{
          if((diaEscolhido+i) > verificarQntdDias(mesEscolhido: mesEscolhido)){
            mesEscolhido+=1
            diaEscolhido=1
            i=0
        }
        if(mesEscolhido == 12){
            return nil
        }
        ano[mesEscolhido][diaEscolhido-1].atividadesDoDia = sortHorario(dia: &ano[mesEscolhido][diaEscolhido-1])
        print("\nMês: \(transformaMes(mesEscolhido: mesEscolhido))    Dia: \(diaEscolhido+i) , \(ano[mesEscolhido][diaEscolhido-1+i].nomeDiaSemana)")
          for atividade in ano[mesEscolhido][diaEscolhido-1+i].atividadesDoDia{
            print("Atividade:\(atividade.nomeAtividade)      Horário:\(atividade.horarioAtividade) ")
            }
          i+=1
          
          
        }
      break
    }
    else{
      diaEscolhido-=1
      if diaEscolhido==0{
        mesEscolhido-=1
        diaEscolhido = verificarQntdDias(mesEscolhido: mesEscolhido)
      }
    }
  }
  return nil
  }
func visualizarAtividadesMensais() -> String?{
  let mesEscolhido = escolheMes()
    let diaMax = verificarQntdDias(mesEscolhido: mesEscolhido)
    let mesTrans = transformaMes(mesEscolhido: mesEscolhido) //Transforma 0 em Janeiro, 1 em Fevereiro...
    print("\nMês \(mesTrans)")
    for diaEscolhido in 1...diaMax{
      ano[mesEscolhido][diaEscolhido-1].atividadesDoDia = sortHorario(dia: &ano[mesEscolhido][diaEscolhido-1])
    if ano[mesEscolhido][diaEscolhido-1].atividadesDoDia.count == 0{
        print("\nNão há atividades no dia \(diaEscolhido), \(ano[mesEscolhido][diaEscolhido-1].nomeDiaSemana)")
    }
    else{
        ano[mesEscolhido][diaEscolhido-1].atividadesDoDia = sortHorario(dia: &ano[mesEscolhido][diaEscolhido-1])
        print("\nDia \(diaEscolhido), \(ano[mesEscolhido][diaEscolhido-1].nomeDiaSemana)")//alterar o 0 por variável
        for atividade in ano[mesEscolhido][diaEscolhido-1].atividadesDoDia{
            print("Atividade:\(atividade.nomeAtividade)      Horário:\(atividade.horarioAtividade)")
        }
    }
    }
  return nil
  }
func adicionarAtividade() -> String?{
        let mesEscolhido = escolheMes()//lê o número do mês e verifica se o mes é valido 0-11
        let i = verificaDia(diaMax: verificarQntdDias(mesEscolhido: mesEscolhido))//lê o valor do dia e verifica se é válido, por exemplo dia 30 de fevereiro(inválido)
        print("\nO que você pretende fazer?")
        let nomeAtividade = readLine() ?? "Vazio"
        let horarioAtividade = verificaHorario()//lê o horário e verifica se é válido e está dentro do formato escolhido(HH:MM)
        ano[mesEscolhido][i-1].atividadesDoDia.append(AtividadeDia(nomeAtividade: nomeAtividade, horarioAtividade: horarioAtividade))// a variável ano é um array de meses, meses é um array de dias e dias é uma struct que possui um número e um array de atividades e AtividadeDia é uma struct que possui um nome e um horário.
        print("\nVocê adicionou a atividade '\(nomeAtividade)' com sucesso\n")
    return nil
}
func removerAtividade() -> String?{
    let mesEscolhido = escolheMes()
    let diaVerificado = verificaDia(diaMax: verificarQntdDias(mesEscolhido: mesEscolhido))
    if ano[mesEscolhido][diaVerificado-1].atividadesDoDia.count == 0 {
        print("\nVocê não tem atividades nesse dia\n")
        return nil
    }
    print("\nAtividades do Dia:")
    var id=0
    for atividade in ano[mesEscolhido][diaVerificado-1].atividadesDoDia{
        print ("ID: \(id)   Atividade:\(atividade.nomeAtividade)   Horário:\(atividade.horarioAtividade)")
        id+=1
    }
    print("\nQual o ID da atividade que você pretende remover?")
    let idAtividade = Int(readLine() ?? "Vazio") ?? -1
    if(idAtividade>=0 && idAtividade<ano[mesEscolhido][diaVerificado-1].atividadesDoDia.count){
        let atividadeRemovida = ano[mesEscolhido][diaVerificado-1].atividadesDoDia[idAtividade].nomeAtividade
        ano[mesEscolhido][diaVerificado-1].atividadesDoDia.remove(at:idAtividade)
        print("Você removeu a atividade \(atividadeRemovida) com sucesso!")
    }
    return nil
}
func alterarAtividade() -> String?{
    let mesEscolhido = escolheMes()
    let diaVerificado = verificaDia(diaMax: verificarQntdDias(mesEscolhido: mesEscolhido))
    if ano[mesEscolhido][diaVerificado-1].atividadesDoDia.count == 0 {
        print("\nVocê não tem atividades nesse dia")
        return nil
        }
    print("\nAtividades do Dia:")
    var id=0
    for atividade in ano[mesEscolhido][diaVerificado-1].atividadesDoDia{
        print ("ID: \(id)   Atividade:\(atividade.nomeAtividade)   Horário:\(atividade.horarioAtividade)")
        id+=1
    }
    print("\nQual o ID da atividade a ser alterada?")
    let idAtividade = Int(readLine() ?? "Vazio") ?? -1
    if(idAtividade>=0 && idAtividade<ano[mesEscolhido][diaVerificado-1].atividadesDoDia.count){
        print("\nVocê deseja alterar o nome da atividade? 1 - Sim")
        let decisaoNome = Int(readLine() ?? "Vazio") ?? -1
        if(decisaoNome == 1){
          print("Qual o novo nome da atividade?")
          let novoNomeAtividade = readLine() ?? "Vazio"
          print("Você alterou o nome da atividade de: \(ano[mesEscolhido][diaVerificado-1].atividadesDoDia[idAtividade].nomeAtividade) para \(novoNomeAtividade)")
          ano[mesEscolhido][diaVerificado-1].atividadesDoDia[idAtividade].nomeAtividade = novoNomeAtividade
        }
        print("\nVocê deseja alterar o horário da atividade? 1 - Sim")
        let decisaoHorario = Int(readLine() ?? "Vazio") ?? -1
        if(decisaoHorario == 1){
          let novoHorarioAtividade = verificaHorario()
          print("Você alterou o horario da atividade de: \(ano[mesEscolhido][diaVerificado-1].atividadesDoDia[idAtividade].horarioAtividade) para \(novoHorarioAtividade)")
          ano[mesEscolhido][diaVerificado-1].atividadesDoDia[idAtividade].horarioAtividade = novoHorarioAtividade
        }
    }
    return nil
    }

while(true) {
    print("Deseja criar um planner? 1-Sim 2-Não")
    let criarPlanner: String?
    criarPlanner = readLine()
    if let criarPlannerR = criarPlanner, !criarPlannerR.isEmpty, criarPlannerR == "1" {
        print("\nBem-vindo ao Planner com H!")
        while(true){
            _ = opcoesPlanner()//insira a funcao opcoesPlanner() aqui
        }
        break
    }
    else if let criarPlannerR = criarPlanner, criarPlannerR == "2" {
        print("\nTá bom, tchau")
        break
    }
    else {
        print("\nEntrada inválida")
    }
}
