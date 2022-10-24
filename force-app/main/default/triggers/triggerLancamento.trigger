trigger triggerLancamento on Lancamento__c (before insert, before update) {
    //
    if(Trigger.isBefore && Trigger.isInsert){
        LancamentoBO.atualizaSaldoDevedor(Trigger.new);
    }
        //tudo como lista
}