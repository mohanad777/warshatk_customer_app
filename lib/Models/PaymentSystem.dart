
import 'package:firebase_database/firebase_database.dart';
import 'package:warshatkcustomerapp/main.dart';

class PaymentSystem{

var iban="";
int amount=0;

 Future<void>  calculateAndUpdatePaymentSystem(var serviceProviderId) async{
  int discount=(this.amount *0.20).toInt() ;

 await FirebaseDatabase.instance
      .reference()
      .child('Payment/$serviceProviderId').update({

    "amount":ServerValue.increment(amount-discount),
  });

  //totalPayment
await   FirebaseDatabase.instance
          .reference()
          .child('users/ApplicationUsers/CarServiceProvider/$serviceProviderId').update({
        "totalPayment":ServerValue.increment(amount-discount),

      });

  await FirebaseDatabase.instance
      .reference()
      .child('Payment/Warshatk').update({

    "amount":ServerValue.increment(discount),
  });


  updateCustomerPaymentSystem();


}
Future<void>  updateCustomerPaymentSystem() async{
   // if i added the iban before and i use the same iban that i added it before
  if(cust.cardInfo.iban!=""&&cust.cardInfo.iban==this.iban){
    await userRef.child(cust.id).update({
//i increase the totalPayment by amount
      "totalPayment":ServerValue.increment(amount)

    });
//i decrease the total amount from my bank account
    await FirebaseDatabase.instance
        .reference()
        .child('Payment/${cust.id}').update({

      "amount":(cust.cardInfo.amount-amount),
    });
  }else{
    
    await userRef.child(cust.id).update({
      "IBAN":this.iban,

      "totalPayment":ServerValue.increment(amount),

    });

    await FirebaseDatabase.instance
        .reference()
        .child('Payment/${cust.id}').update({
      "IBAN":this.iban,
      "amount":(10000-amount),
    });

  }

  cust.cardInfo.amount=(cust.cardInfo.amount-amount);
  cust.totalPayment=amount;

}






}