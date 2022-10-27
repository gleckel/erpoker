public class LancamentoBO {
    public static void atualizaValorTotalVendido(List<Lancamento__c> lancamentoLst){

        List<Lancamento__c> lancamentoPagoLst = new List<Lancamento__c>();
        Set<id> lancamentoSetId = new Set<id>();

        for(Lancamento__c lancamento: lancamentoLst){
            if(lancamento.Pago__c == True || lancamento.RecordTypeId == '0128a000000CT6kAAG' ){
                lancamentoPagoLst.add(lancamento);
                lancamentoSetId.add(lancamento.Usuario__c);
            }
        }
        
        List<Usuario__c> usuario = [SELECT id, Name,ValorTotalVendido__c, LimiteDeCredito__c FROM Usuario__c WHERE Usuario__c.Id =: lancamentoSetId LIMIT 1];
       
        for(Lancamento__c lancamento: lancamentoLst){
            for(Usuario__c user: usuario){
                user.ValorTotalVendido__c = user.ValorTotalVendido__c + lancamento.Valor__c;
            }
        }
        
        update usuario;
        
    } 
    public static void atualizaSaldoDevedor(List<Lancamento__c> lancamentoLst){

        List<Lancamento__c> lancamentoDevedor = new List<Lancamento__c>();
        Set<id> lancamentoSetId = new Set<id>();

        for(Lancamento__c lancamento:lancamentoLst){
             if(lancamento.RecordTypeId == '0128a000000CT6kAAG'){
                atualizaSaldoDevedorPagamento(lancamentoLst);
            }//&& lancamento.RecordTypeId != '0128a000000CT6kAAG'?
            else if(lancamento.Pago__c == FALSE){
                lancamentoDevedor.add(lancamento);
                lancamentoSetId.add(lancamento.Usuario__c);
            }
        }
        
        List<Usuario__c> usuario = [SELECT id, Name,ValorTotalVendido__c, LimiteDeCredito__c, SaldoDevedor__c FROM Usuario__c WHERE Usuario__c.Id =: lancamentoSetId LIMIT 1];

        for(Lancamento__c lancamento : lancamentoDevedor){
            for(Usuario__c user : usuario){
                 user.SaldoDevedor__c = user.SaldoDevedor__c + lancamento.Valor__c;
                 user.LimiteDeCredito__c = user.LimiteDeCredito__c	- lancamento.Valor__c;    
            }
        }

        update usuario;
    }
        public static void atualizaSaldoDevedorPagamento(List<Lancamento__c> lancamento){
        Set<id> lancamentoSetId = new Set<id>();
        for(Lancamento__c lanca : lancamento){
            lancamentoSetId.add(lanca.Usuario__c);
        }
       
        List<Usuario__c> usuario = [SELECT id, Name,ValorTotalVendido__c, 
                                    LimiteDeCredito__c, SaldoDevedor__c 
                                    FROM Usuario__c 
                                    WHERE Usuario__c.Id =: lancamentoSetId];
        for(Lancamento__c lanca : lancamento){        
           for(Usuario__c user : usuario){//Quando o pagamento for maior que a divida (Saldo Devedor) a diferença deve ir para o Valor Total Vendido.
               if(user.SaldoDevedor__c <= lanca.Valor__c)    {
                    user.ValorTotalVendido__c = user.ValorTotalVendido__c + (lanca.Valor__c - user.SaldoDevedor__c);
                    user.LimiteDeCredito__c = user.LimiteDeCredito__c + user.SaldoDevedor__c ;
                    user.SaldoDevedor__c = 0;
               }else{
                   user.SaldoDevedor__c = user.SaldoDevedor__c - lanca.Valor__c;
                   user.LimiteDeCredito__c = user.LimiteDeCredito__c +  lanca.Valor__c;
               }
            }
        }
        update usuario;
    }
}
