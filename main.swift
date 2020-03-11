//
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
var mes: [Dias] = []
for i in 1...31{
    mes.append(Dias(data: String(i), atividadesDoDia: []))
}
var ano = [mes]
for i in 1...12{
    ano.append(mes)
}

func opcoesPlanner() -> String? {
    print("O que faremos hoje?\n1-Visualizar seu Planner\n2-Adicionar uma atividade\n3-Remover uma atividade\n4-Alterar uma atividade")
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
        print("Tá louco? Essa opção nem existe!!!")
    }
    return nil //não preciso dele :)
    }

func visualizarAtividades() -> String?{
    print("Qual modo de visualização você deseja?\n1-Diária\n2-Semanal\n3-Mensal")
    let opcaoV = readLine() ?? "Vazio"
    switch(opcaoV){
    case "1":
        _ = visualizarAtividadesDiarias()
    case "2":
        _ = visualizarAtividadesSemanais()
    case "3":
        _ = visualizarAtividadesMensais()
    default:
        print("Não existe essa opção!")
    }
    return nil
}
func visualizarAtividadesDiarias() -> String?{
    print("Qual dia deseja visualizar?")
    let diaEscolhido = readLine() ?? "Vazio"
    var verificacaoDia = 0
    for i in 1...31{
        if i == Int(diaEscolhido){
            verificacaoDia=1
            if mes[i-1].atividadesDoDia.count == 0{
                print("Não há atividades no dia \(i)")
            }
            else{
                print("Mês 0, dia \(diaEscolhido)")//alterar o 0 por variável
                for atividade in mes[i-1].atividadesDoDia{
                    print("Atividade:\(atividade.nomeAtividade)      Horário:\(atividade.horarioAtividade)")
                }
            }
        }
    }
    if(verificacaoDia==0){
        print("Esse dia '\(diaEscolhido)' não existe!")
    }

    
    
    
    
    return nil
}
func visualizarAtividadesSemanais() -> String?{return nil}
func visualizarAtividadesMensais() -> String?{return nil}


func adicionarAtividade() -> String?{
    print("Em qual dia a atividade se realizará?")
    let diaAtividade = readLine() ?? "Vazio"
    var verificacaoA=0
    for i in 1...31{
        if i == Int(diaAtividade){
            verificacaoA=1
            print("O que você pretende fazer?")
            let nomeAtividade = readLine() ?? "Vazio"
            print("Qual o horário da atividade?")
            let horarioAtividade = readLine() ?? "Vazio"
            mes[i-1].atividadesDoDia.append(AtividadeDia(nomeAtividade: nomeAtividade, horarioAtividade: horarioAtividade))
            print("Você adicionou a atividade '\(nomeAtividade)' com sucesso")
        }
    }
    if(verificacaoA==0){
        print("Esse dia '\(diaAtividade)' não existe!")
    }
    print(mes)
    return nil
}

func removerAtividade() -> String?{
    print("Qual dia da atividade que será removida")
    let diaAtividade = readLine() ?? "Vazio"
    var verificacaoDia = 0
    for i in 1...31{
        if i == Int(diaAtividade){
            verificacaoDia=1
            print("O que você pretende remover?")
            let nomeAtividade = readLine() ?? "Vazio"
            var j = 0
            var verificacaoAtividade=0
            for atividade in mes[i-1].atividadesDoDia{
                if atividade.nomeAtividade == nomeAtividade{
                    verificacaoAtividade=1
                    mes[i-1].atividadesDoDia.remove(at:j)
                    print("Você removeu a atividade \(nomeAtividade) com sucesso")
                }
                j+=1
            }
            if verificacaoAtividade==0{
                print("Não existem atividades com o nome: \(nomeAtividade)")
            }
        }
    }
    if (verificacaoDia==0){
        print("Esse dia '\(diaAtividade)' não existe!")
    }
    //print(mes)
    return nil
}
func alterarAtividade() -> String?{
    print("Qual dia da atividade que será alterada?")
    let diaAtividade = readLine() ?? "Vazio"
    var verificacaoDia = 0
    for i in 1...31{
        if i == Int(diaAtividade){
            verificacaoDia=1
            print("O que você pretende alterar?")
            let nomeAtividade = readLine() ?? "Vazio"
            var j = 0
            var verificacaoAtividade=0
            for atividade in mes[i-1].atividadesDoDia{
                if atividade.nomeAtividade == nomeAtividade{
                    verificacaoAtividade=1
                    print("Qual o novo nome da atividade?")
                    let novoNomeAtividade = readLine() ?? "Vazio"
                    mes[i-1].atividadesDoDia[j].nomeAtividade = novoNomeAtividade
                    print("Qual o novo horário da atividade?")
                    let novoHorarioAtividade = readLine() ?? "Vazio"
                    mes[i-1].atividadesDoDia[j].horarioAtividade = novoHorarioAtividade
                    
                    print("Você alterou a atividade '\(nomeAtividade)' com sucesso")
                }
                j+=1
            }
            if verificacaoAtividade==0{
                print("Não existem atividades com o nome: \(nomeAtividade)")
            }
        }
    }
    if (verificacaoDia==0){
        print("Esse dia '\(diaAtividade)' não existe!")
    }
    print(mes)
    return nil

}



while(true) {
    print("Deseja criar um planner? 1-Sim 2-Não")
    let criarPlanner: String?
    criarPlanner = readLine()
    if let criarPlannerR = criarPlanner, !criarPlannerR.isEmpty, criarPlannerR == "1" {
        print("Bem-vindo ao planner")
        while(true){
            opcoesPlanner()//insira a funcao opcoesPlanner() aqui
        }
        break
    }
    else if let criarPlannerR = criarPlanner, criarPlannerR == "2" {
        print("Tá bom, tchau")
        break
    }
    else {
        print("Entrada inválida")
    }
}
