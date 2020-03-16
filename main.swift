//  main.swift
//  plannercomH
//
//  Created by Dupla com H on 09/03/20.
//  Copyright © 2020 Dupla com H. All rights reserved.
//

import Foundation

struct AtividadeDia{
    var nomeAtividade: String
    var horarioAtividade: String
    // var categoria: String
}
struct Dias{
    var data: String
    var atividadesDoDia: [AtividadeDia]
    //var nomeDia: String //sabado, domingo, segunda...
}
func verificarQntdDias(mesEscolhido: Int) -> Int{
    let mesesCom30: Set = [3,5,8,10] //Set é uma lista não ordenada de elementos únicos
    if mesesCom30.contains(mesEscolhido) {
        return 30
    }
    else if mesEscolhido == 1{
        return 28
    }
    else{
        return 31
    }
}
var mes: [Dias] = []
var ano = [mes]
for i in 0...11{ //inserção dos meses no ano
    mes = []
    let x = verificarQntdDias(mesEscolhido: i)
    for j in 1...x {
        mes.append(Dias(data: String(j), atividadesDoDia: []))
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

func transformaMes(mesEscolhido: Int) -> String{
    switch(mesEscolhido){
    case 0:
        return "Janeiro"
    case 1:
        return "Fevereiro"
    case 2:
        return "Março"
    case 3:
        return "Abril"
    case 4:
        return "Maio"
    case 5:
        return "Junho"
    case 6:
        return "Julho"
    case 7:
        return "Agosto"
    case 8:
        return "Setembro"
    case 9:
        return "Outubro"
    case 10:
        return "Novembro"
    case 11:
        return "Dezembro"
    default:
        return "Tá errado kk" //mudar esse return
    
    }
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
    print("\nQual dia deseja visualizar?")
    let diaEscolhido = readLine() ?? "Vazio"
    var verificacaoDia = 0
    for i in 1...verificarQntdDias(mesEscolhido: mesEscolhido){
        if i == Int(diaEscolhido){
            verificacaoDia=1
            if ano[mesEscolhido][i-1].atividadesDoDia.count == 0{
                print("\nNão há atividades no dia \(i)")
            }
            else{
                let mesTrans = transformaMes(mesEscolhido: mesEscolhido)
                print("\nMês \(mesTrans), dia \(diaEscolhido)")//alterar o 0 por variável
                for atividade in ano[mesEscolhido][i-1].atividadesDoDia{
                    print("Atividade:\(atividade.nomeAtividade)      Horário:\(atividade.horarioAtividade)")
                }
            }
        }
    }
    if(verificacaoDia==0){
        print("\nEsse dia '\(diaEscolhido)' não existe!")
    }
    return nil
}
func visualizarAtividadesSemanais() -> String?{return nil}
func visualizarAtividadesMensais() -> String?{return nil}


func adicionarAtividade() -> String?{
        let mesEscolhido = escolheMes()
        let i = verificaDia(diaMax: verificarQntdDias(mesEscolhido: mesEscolhido))
        print("\nO que você pretende fazer?")
        let nomeAtividade = readLine() ?? "Vazio"
        let horarioAtividade = verificaHorario()
        ano[mesEscolhido][i-1].atividadesDoDia.append(AtividadeDia(nomeAtividade: nomeAtividade, horarioAtividade: horarioAtividade))
        print("\nVocê adicionou a atividade '\(nomeAtividade)' com sucesso\n")
    return nil
}

func removerAtividade() -> String?{
    let mesEscolhido = escolheMes()
    let i = verificaDia(diaMax: verificarQntdDias(mesEscolhido: mesEscolhido))
    if ano[mesEscolhido][i-1].atividadesDoDia.count == 0 {
        print("\nVocê não tem atividades nesse dia\n")
        return nil
    }
    print("\nAtividades do Dia:")
    var idAtividade=0
    for atividade in ano[mesEscolhido][i-1].atividadesDoDia{
        print ("ID: \(idAtividade)   Atividade:\(atividade.nomeAtividade)   Horário:\(atividade.horarioAtividade)")
        idAtividade+=1
    }
    print("\nQual o ID da atividade que você pretende remover?")
    let nomeAtividade = readLine() ?? "Vazio"
    var j = 0
    var verificacaoAtividade=0
    for atividade in ano[mesEscolhido][i-1].atividadesDoDia{
        if atividade.nomeAtividade == nomeAtividade{
            verificacaoAtividade=1
            ano[mesEscolhido][i-1].atividadesDoDia.remove(at:j)
            print("\nVocê removeu a atividade \(nomeAtividade) com sucesso!\n")
        }
        j+=1
    }
    if verificacaoAtividade == 0{
        print("\nNão existem atividades com o nome: \(nomeAtividade)\n")
    }
    return nil
}
func alterarAtividade() -> String?{
    let mesEscolhido = escolheMes()
    let i = verificaDia(diaMax: verificarQntdDias(mesEscolhido: mesEscolhido))
    if ano[mesEscolhido][i-1].atividadesDoDia.count == 0 {
        print("\nVocê não tem atividades nesse dia")
        return nil
        }
    print("\nO que você pretende alterar?")
    let nomeAtividade = readLine() ?? "Vazio"
    var j = 0
    var verificacaoAtividade=0
    for atividade in ano[mesEscolhido][i-1].atividadesDoDia{
        if atividade.nomeAtividade == nomeAtividade{
            verificacaoAtividade=1
            print("\nQual o novo nome da atividade?")
            let novoNomeAtividade = readLine() ?? "Vazio"
            ano[mesEscolhido][i-1].atividadesDoDia[j].nomeAtividade = novoNomeAtividade
            let novoHorarioAtividade = verificaHorario()
            ano[mesEscolhido][i-1].atividadesDoDia[j].horarioAtividade = novoHorarioAtividade
            print("\nVocê alterou a atividade '\(nomeAtividade)' com sucesso")
        }
        j+=1
    }
    if verificacaoAtividade==0{
            print("\nNão existem atividades com o nome: \(nomeAtividade)")
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
