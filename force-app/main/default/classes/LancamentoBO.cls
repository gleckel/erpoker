public class LancamentoBO {
    public static void atualizaSaldoDevedor(List<Lancamento__c> lancamento_lst){
        List<Lancamento__c> lancamentoPago = new List<Lancamento__c>();
        Set<id> lancamento_id = new Set<id>();
        for(Lancamento__c lancamento:lancamento_lst){
            if(lancamento.Pago__c == True){
                lancamentoPago.add(lancamento);
                System.debug(lancamentoPago);
                lancamento_id.add(lancamento.Usuario__c);
                 System.debug(lancamento_id);
            }
        }
        
        // agente, comprador
        // comprador -> comprador->saldo++
        List<Usuario__c> usuario = [SELECT id, Name,ValorTotalVendido__c, LimiteDeCredito__c FROM Usuario__c WHERE Usuario__c.Id =: lancamento_id LIMIT 1];
        System.debug(+usuario);
        
        usuario[0].ValorTotalVendido__c = usuario[0].ValorTotalVendido__c + lancamentoPago[0].Valor__c;
        update usuario;
        
    } 
}