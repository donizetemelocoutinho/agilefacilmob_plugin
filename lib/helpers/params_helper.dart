import 'dart:convert';
import 'package:flutter/material.dart';


import 'api_helper.dart';

class ParamsHelper{
  static final String FaturamentoContaVenda = '{AF71F345-CE4A-45E8-9451-10A474305BF4}';
  static final String FaturamentoContaDevolucaoVenda = '{043BD2CC-06FF-435C-8467-16BA8A90EFAC}';
  static final String FaturamentoDevolucaoObrigarIdentificarVenda = '{6EB2B34A-3DC2-480D-9900-9F09709DDF7D}';
  static final String FaturamentoDavNumeroFicha = '{AF414A9D-C06E-43E6-B2EE-C6353C3C0E88}';
  static final String FaturamentoDescontoMaximo = '{D5349DEE-65C6-424E-8756-BA1F1A21858F}';
  static final String FaturamentoPgtoAprazoPadrao = '{9132C407-2025-469E-B29D-4B2066E3798B}';
  static final String FaturamentoVendeSemEstoque = '{FAFFC2C7-68AE-43B3-AB08-0B57C83C9F79}';
  static final String FaturamentoCondicionalpPermitir = '{84F26E3B-F62F-45FA-BD59-24E00C985E32}';
  static final String FaturamentoTipoBarRestaurante = '{0AB744FB-47E7-4574-B137-B0A522E5C494}';
  static final String FaturamentoBarRestauranteQtdMesas = '{48D6872A-FC3D-4EFA-BEF8-14B995E20900}';
  static final String FaturamentoBarRestaurMesaImprimirPedido = '{01A597B8-C9E2-4ADD-B764-69C24F6D42D3}';
  static final String FaturamentoImprimirCupomAnexo = '{13A49C2D-A694-4189-ADC7-894DF7F23214}';
  static final String FaturamentoTaxaServico = '{455AA1CF-A051-4ADD-8E07-04BA092F77D2}';
  static final String FaturamentoCreditoDiasEntreParcela = '{0678A26D-C62D-4485-B6CF-1D481C878660}';
  static final String FaturamentoCreditoValidacao = '{DA5FAE03-A517-4EE2-9E69-D2D27E2782E8}';
  static final String FaturamentoCreditoCarencia = '{BA1B4354-73CE-4782-BA85-7FCD884B7449}';
  static final String FaturamentoCreditoTipoArredondamentoParcela = '{C56CD5BF-909C-4C96-9840-22C4DF68D0EF}';
  static final String FaturamentoCreditoNumeroNaximoParcelas = '{02cfc76e-b121-460a-a1a0-4fa63f4cb4e6}';
  static final String FaturamentoCreditoValorMinimoParcelar = '{14673249-4AE8-4BAF-B0FE-9AEB3C66118F}';
  static final String FaturamentoCreditoTabelaJuros = '{CE374C09-5508-4CBB-8525-D050DE89D9C3}';
  static final String FaturamentoComissaoCalcularSobre = '{7D26E2CE-76F3-4BA4-9015-28C10C69E00E}';
  static final String FaturamentoComissaoModeloAprazo = '{89C1B417-179D-4214-A9C8-AE0F442B47B1}';
  static final String FaturamentoComissaoToleranciaAprazo = '{35A9886A-9121-41C6-A4EA-33FBADEA9970}';
  static final String FaturamentoPDVSelecionaVendedor = '{A88CEC72-08EC-4AD5-9A29-ED3C6433ACC5}';
  static final String FaturamentoPDVConfirmaCFe = '{3BE351DA-1F59-41C2-8350-F0CE73FBFCBA}';
  static final String FaturamentoPDVBalanca_TipoRetorno = '{EF7BCA4B-1EB0-45EB-8BF8-A2BDB76D7383}';
  static final String FaturamentoPDVBalanca_DigitosCodigo = '{FCB1A461-BC99-416F-8618-CF15A94DD55F}';
  static final String FaturamentoPDVBalanca_DigitosValor = '{FA3A3556-8314-405A-962A-C9C8561E20FF}';
  static final String FaturamentoPDVBaixaPorCodigoBarra = '{BA138974-0613-427D-B836-4E3C0A98B122}';
  static final String FaturamentoDAVSelecionaVendedor = '{46F551CA-F385-49CB-B7FE-BDD664ACC22A}';
  static final String FaturamentoDAVNumeroUltimoPedidoOrcamento = '{3EF1F4AC-C42C-4E12-9B6D-C1A688AA72FE}';
  static final String FaturamentoDAVPgtoPadrao = '{B79B15E8-3C2B-441B-8C41-57C6BA9EFD54}';
  static final String FaturamentoDAVEmiteCFe = '{5C02C774-E271-4DBD-A362-91FBFB8AE3F7}';
  static final String FaturamentoDAVNFeImprimeCarne = '{F0D410B0-39A1-416A-A806-E66C7542BD75}';
  static final String FaturamentoDAVInformaValorItem = '{FAF9C192-C684-4D55-A52F-B355B6503D73}';
  static final String FaturamentoDAVInformaValorDesconto = '{962B334F-7B0A-4DA9-A7C1-74CBC97216F0}';
  static final String FaturamentoDAVIncluiAutomaticamentePeloCodigo = '{653BFDE7-4A53-45F1-8F84-4404CEFA1BAE}';
  static final String FaturamentoDAVNovoAoSalvarPedido = '{87aeea6b-9453-4a24-bf81-a4aeb35a2a97}';
  static final String FaturamentoDAVOsNumeroUltimaOs = '{6C57028E-6354-4969-A903-B2E9EE952E88}';
  static final String FaturamentoDavOsSmsConclui = '{1F6FDA60-AD92-4515-9609-D2BF1206E83A}';
  static final String FaturamentoDavOsQtdDiasEntrega = '{A75607C3-3C06-4A82-91E0-C343125615BD}';
  static final String FaturamentoDavOsQtdDiasGarantiaPosEntrega = '{61F38125-0C10-43F5-9C03-05F75BBA5A60}';
  static final String FaturamentoEntregaProdutos = '{4F8922BE-AEDB-4DC5-9772-39D2E7D996F5}';
  static final String FaturamentoEntregaValorSemTaxa = 'MikTdQpCW0KgEpykOzn6KQ';
  static final String FaturamentoEntregaTaxa = 'FHPjCvelPEu2mF2H1YxsNQ';
  static final String FaturamentoEntregaTempoMedio = 'iJMYG1kfOEyHfZ_mRwRCig';
  static final String FaturamentoEntregaLimiteHoraPedido = 'q_Arzxov50uNaDweaHS38A';
  static final String ContasReceberPerJuros = '{13095256-A2E2-4BB4-9122-DEE8E66B5967}';
  static final String ContasReceberPerMulta = '{1B1D6CE3-705C-468C-BBE5-70C7D7C2DEA2}';
  static final String ContasReceberDiasCarencia = '{2A642965-0E8B-4857-94E7-304B3CDB469F}';
  static final String ContasReceberContasReceberDescontoMaximo = '{446C512A-82FF-4D4B-8BB0-8223451CA0E1}';
  static final String ContasReceberContasReceberDescontoSobreNominal = '{8146021B-AD4A-4E47-AF3E-1067F26BDA36}';
  static final String ContasReceberSmsCobranca = '{1DCFD112-D87E-4D71-BECC-400D478448DB}';
  static final String ContasReceberBoletoInstrucao_Caixa = '{4A95A400-DBAC-483B-B74D-81913636310E}';
  static final String ContasReceberBoletoDiasProtesto = '{5E97130D-1145-4482-90B6-A3B45A5966DA}';
  static final String ClienteSmsAniversario = '{ADF65F6A-1D86-4718-8328-4E1175ADA12D}';
  static final String ClientePermiteCadastroSemCpfCnpj = '{64140725-7B57-4318-8188-62DB07422EF9}';
  static final String ClientePermiteCadastroSemEndereco = '{F6F37147-C8D6-4B6E-A595-855DD0936880}';
  static final String ClienteLimiteCreditoPadrao = '{254C692C-99AC-4683-8A62-E30375BBA309}';
  static final String ClienteImpedirCpfDuplicado = '{E4CAFD5B-9004-4E85-8FDA-89BA38F59248}';
  static final String CaixaModeloFuncionamento = '{EF24949B-6D1D-4210-AAC3-4A4250B15985}';

  static final String ProdutoTabelaPrecoPrincipal = '{AF68BD4F-C885-4841-9ADB-0A9F1BA786DE}';
  static final String ProdutoTabelaPrecoAlternativa = '{0FD92975-6E33-48E2-8415-FA95306667A2}';
  static final String ProdutoTabelaPrecoExibirAlternativa = '{C86F10D7-BA1A-447A-A203-71A36A8CC651}';
  static final String ProdutoTabelaPrecoparcelamento = 'N7zRfH2XMUahOKoyMeJ6RQ';
  static final String ProdutoTemGrade = '{3ED4D20F-E4C9-43BA-ACB4-C492D9828CB8}';
  static final String ProdutoGradeTipo1 = '{27EE2A88-8C39-4F43-BE00-AC22ADAC644C}';
  static final String ProdutoGradeTipo2 = '{AA8FCA70-BE92-421B-9DD4-85D099D3B83F}';
  static final String ProdutoMascaraPreco = '{36675F57-44CB-4EB6-9A2E-EDB6FD48F13B}';


  static final String ProdutoAtacarejo = '{06BD7B7E-1F4F-4F42-8A6D-A23779EBF357}';

  static final String ProdutoestoqueReservaPedido = '{F2C707F1-6CC4-4783-9225-4523C81B4BBE}';
  static final String ProdutoestoqueReservaCondicionais = '{07422AF2-6AA7-48CB-82ED-3380F760AF1E}';
  static final String ProdutoestoqueReservaos = '{414B69E4-9F2C-425F-988D-3C9BDE436B0B}';
  static final String ProdutocategoriaTributariaPadrao = '{CDB40CFA-540E-47E4-9DB0-16A8882D43E3}';
  static final String ProdutoconsultaInativo = '{1B184D1C-35BF-4A54-8BE5-BA29A52E4CE0}';
  static final String ProdutogerarCodigoBarra = '{B1E5C89B-2D30-4BDF-A41A-CB1D8E927ABA}';
  static final String ProdutoarquivoLayout = '{04E30FEE-D9B6-470A-AD72-7E19AA17CE06}';
  static final String ProdutoarquivoNomePadrao = '{03C5701B-F05B-42A4-A1D6-19E514D76D32}';

  static final String ProdutoAutoestmim_max = '{02BDBEE0-935D-4F51-946A-115DCF0DDD4C}';
  static final String ProdutoAutoConsiderarNumeroVendas = '{FAE2C273-867A-4C42-B747-411A34C8C4D4}';
  static final String ProdutoAutoInativarProdutos = '{FF8B0670-6CDA-48E9-8DF2-552363AFD472}';
  static final String ProdutoAutoInativarProdutosMeses = '{7F5A98F0-C0FA-4F13-B656-F4DB9FAB97F1}';
  static final String ProdutoLimiteRegistrosConsulta = '{91561197-F364-4AC1-B4E2-A2AA5D73D5E7}';

  static final String ProdutoPeriodoCurvaABC = '{E95E21FC-5BF7-406C-B590-02268B2ACFF8}';
  static final String ProdutoTabelaPromocao = '{6D7E12A0-E84B-494A-9BCE-833960759273}';
  static final String ProdutoExibirDadosAdicionais = 'lcwz4qPQNEK_q866RAHhJw';

  static final String DREReceitas = '{CEED0429-8568-4F00-B29F-050E0E867BAE}';
  static final String DREFaturamento = '{7C16EE48-B305-4F6D-AC6D-84F53EC5F588}';
  static final String DREDespesas = '{E81330AE-485B-4880-8738-CD2A69E5A26F}';
  static final String DREDespesasVariavel = '{A1F40842-93A7-4FD2-B82F-4A983AC01B50}';
  static final String DREInvestimento = '{F7C6B70E-344C-4357-9401-E9719D5FEC3A}';

  static final String CTELoteTransmissao = '{240DDE8B-0F36-4262-ACD5-4C20E07F6DC2}';
  static final String DAVStoreConfigtvItens = '{2C15157E-650B-47D3-999B-C4BEA17F362B}';

  static final String DFeCertificadoNumero='{22C014DA-636F-446C-9C7D-8C32CF206F7E}';
  static final String DFeCertificadoSenha='{0038FDE1-05D5-41C2-92D3-F034FC71F53D}';
  static final String DFeCertificadoArquivo_Base64='{EA940FB4-C50E-4AA0-BADE-4B7A85471F7E}';
  static final String DFeCertificadoValidade='{E78E7E7F-DC41-4D33-BE7E-4E84BE2B4129}';
  static final String DFeProxyServidor='{4FF43FB8-56AF-459F-9A3A-BC2E47BD08CA}';
  static final String DFeProxyPorta='{813C756F-5411-41FE-BC53-AFF6D8D053AA}';
  static final String DFeProxyUsuario='{8649EA43-EC4E-474A-BE05-5C2337D22201}';
  static final String DFeProxySenha='{EBC991C6-7676-4770-8720-C29FEC45665C}';
  static final String DFeAmbiente='{8BB4E987-C1EF-4099-A580-79BA8843CF76}';
  static final String DFeSSLCrypt='{7CF179BF-4CC9-4578-BDBC-D9B7D3851A4A}';
  static final String DFeSSLType='{10CB64DA-E16C-4CE0-82C4-69B1D52D7C93}';

  static final String NFeOrientacaoDanfe='{88137DC5-793E-4EDD-AF1F-679AF55297CD}';
  static final String NFeTipoEmissao='{B0EAED5F-AE65-4B32-96E7-0407AE48DCDF}';
  static final String NFeLoteTransmissao='{AC39760F-E2EC-44BA-A8DB-4456944D671B}';
  static final String NFeInformacaoComplementar='{2F1B86B2-D1DE-4641-9813-AF67DF3BEFC2}';
  static final String NFeIDTDFSeriePadrao='{A970B336-A10D-4CC5-9D54-7A08F3945F46}';
  static final String NFeIDEmailEnvio='{AB7D45DD-6FEB-4BF6-AF13-CF2F4FA68A5A}';
  static final String NFeTemplateNotaEmitida='{DDF9735A-AA37-4B9E-ADF5-B69760911CAF}';
  static final String NFeObservacaoPadrao='{6E1EC2DE-B6DD-4E2C-895C-C0A5F5329E66}';
  static final String NFeTipoFretePadrao='{BA96865F-40C8-4E14-B408-E6915FB06994}';
  static final String NFeTipoCodigoItens='{145C74FE-0597-44FC-A346-3D0F74535924}';
  static final String NFeTipoDesconto = '{864475D9-FACB-43B5-874B-E18EF1812D3F}'; //0: $ 1: %
  static final String NFeNSUDistribuicao = '{66EBE92A-D987-4C19-866B-39252EE7ED54}';

  static final String MDFeSerie='{9D62AE35-48FF-4F99-9451-B7CE3A9D551F}';
  static final String MDFeNumero='{EE7C5AB9-1665-4130-A231-B29975A5BA10}';
  static final String MDFeLoteTransmissao='{F8E53FED-51B4-49B7-8490-7B4B28D63F28}';

  static final String NFCeIdCSC = '{2FC69763-ED91-4FC7-BF67-7E7659CCAD46}';
  static final String NFCeCSC = '{1733968B-7292-4D9E-8F3B-05120ABDCDF6}';

  static final String CompraPrecocustoCompraConsideraCreditos = '{32B1C58F-826A-4289-A388-E774D9FCE032}';
  static final String CompraPrecoCustoVendaConsideraTributos = '{10FA1B42-01BC-4110-9F3D-017EFCBF64FF}';
  static final String CompraSugerirPrecoCompraMarkup = '{6CE97BD1-CBF3-43E1-BAC9-48B14919FF12}';
  static final String CompraModoAplicacaoMargemLucro = '{BFCBD0E0-6611-4B55-A1F6-5F238BE1DD2D}';
  static final String EmpresaHorarioFuncionamento = 'nquhl9FVDUKmjvdeYxLBRQ';

  static dynamic params;


  Future<dynamic> getList({required List<String> paramsList, required String api_token,required int codloja}) async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> params = {"codloja": codloja.toString(),"api_token":api_token,"params" : jsonEncode(paramsList)};
    dynamic r = await api.get("loja/parametros/list", params: params);
    return r;
  }

  Future<Map> get({required String param, required String api_token,required int codloja}) async{
    ApiHelper api = ApiHelper();
    Map<String,dynamic> params = {"codloja": codloja.toString(),"api_token":api_token,"id" : param};
    Map r = await api.get("loja/parametros/get", params: params);
    return r;
  }

  static String getStringFromList({@required dynamic params, required String param,required String defaultValue}){
    String ret = defaultValue;
    for (var i = 0; i < params.length -1; i++) {
      if (params[i]["id"].toString().toUpperCase() == param.toUpperCase()){
        ret = params[i]["valor"];
        break;
      }
    }
    return ret;
  }

  static bool getBoolFromList({required dynamic params, required String param}){
    bool ret = false;
    ret = getStringFromList(params:params,param: param,defaultValue: "N") == "S";
    return ret;
  }

  static int getIntFromList({required dynamic params,required String param}){
    int ret = 0;
    ret = int.parse(getStringFromList(params: params,param: param,defaultValue: "0"));
    return ret;
  }

  static double getDouleFromList({required dynamic params, required String param}){
    double ret = 0;
    ret = double.parse(getStringFromList(params:params,param: param,defaultValue: "0.00"));
    return ret;
  }

}