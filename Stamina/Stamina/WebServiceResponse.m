//
//  WebServiceResponse.m
//  TesteServidor
//
//  Created by João Lucas Sisanoski on 17/09/14.
//  Copyright (c) 2014 João Lucas Sisanoski. All rights reserved.
//

#import "WebServiceResponse.h"

@implementation WebServiceResponse
+(NSString*)cadastrarComNome: (NSString *)nome eSenha: (NSString *)password email: (NSString *)email sexo:(BOOL) sexo nickName: (NSString *)nickName {
    NSString *url = @"http://equipemoacir.com.br/servidor/cadastro.php";
    NSString *post = [NSString stringWithFormat:@"password=%@&nome=%@&email=%@&sexo=%d&nickname=%@",password, nome, email, sexo, nickName];
    return [WebServiceResponse doTheRequest:post andUrl:url];
}
+(NSString*)loginComEmailOuNickName: (NSString *)anything eSenha: (NSString *)password{
    NSString *url = @"http://equipemoacir.com.br/servidor/login.php";
    NSString *post = [NSString stringWithFormat:@"password=%@&emailOrNick=%@",password, anything];
    return [WebServiceResponse doTheRequest:post andUrl:url];
}
+(NSString*)getJsonComNickName: (NSString *)anything eSenha: (NSString *)password{
    NSString *url = @"http://equipemoacir.com.br/servidor/getJson.php";
    NSString *post = [NSString stringWithFormat:@"password=%@&emailOrNick=%@",password, anything];
    return [WebServiceResponse doTheRequest:post andUrl:url];
}
+(NSString*)inserirExercicioComId: (int )idExercicio serie: (int )serie repeticoes: (int )repeticoes treino: (int )treino emailOrNickName: (NSString *)anything{
    NSString *url = @"http://equipemoacir.com.br/servidor/insereExercicio.php";
    NSString *post = [NSString stringWithFormat:@"emailOrNick=%@&id_exercicio=%d&series=%d&repeticoes=%d&treino=%d",anything, idExercicio,serie,repeticoes,treino];
    return [WebServiceResponse doTheRequest:post andUrl:url];
}

+(NSString *)doTheRequest :(NSString *)post andUrl: (NSString *)url{
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [[ NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"context-type"];
    [request setHTTPBody:postData];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString* s = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    return s;
}


+(NSString *)upToServerTraining: (UserTraining *) newTraining withLogin: (NSString *)login withPassword: (NSString *)password {
    UserTraining *temp = newTraining;
    NSArray *array = [temp exercisesArray];
    NSMutableArray *trainingsArray = [NSMutableArray array];
    for (int x = 0; x < [array count]; x++) {
        TrainingExercises *temp = [array objectAtIndex:x];
        NSDictionary *trainingDictionary =[NSDictionary dictionaryWithObjectsAndKeys:
                                                                               [temp id_exercise], @"id_exercise",
                                                                               [temp training_name], @"trainingName",
                                                                              [temp series], @"series",
                                                                                [temp repetitions], @"repetitions",
                                                                               nil];
        [trainingsArray addObject:trainingDictionary];
    }
    NSError *error = nil;
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:trainingsArray options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    NSData *jsonData = [jsonString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

    return [WebServiceResponse cadastrar:jsonData :login :password];
}
+(NSString*)cadastrar:(NSData*)jsonCadastro : (NSString *)strUser : (NSString *)password{
    NSString *url = @"http://equipemoacir.com.br/servidor/teste.php";
    NSString *strJson = [[NSString alloc] initWithData:jsonCadastro encoding:NSUTF8StringEncoding];
    NSString *post = [NSString stringWithFormat:@"emailOrNick=%@&password=%@&json=%@", strUser, password, strJson];
    return [self doTheRequest:post andUrl:url];
}
+(NSString*)checkStart: (NSString *)email eSenha: (NSString *)password{
    NSString *url = @"http://equipemoacir.com.br/servidor/startCheck.php";
    
    NSString *post = [NSString stringWithFormat:@"email=%@&password=%@", email, password];
    return [self doTheRequest:post andUrl:url];

}
+(NSString*)atualizaComEmail: (NSString *)email peso: (float )peso_atual sexo: (BOOL )sexo altura: (int )altura idade: (int )idade{
    NSString *url = @"http://equipemoacir.com.br/servidor/atualiza.php";
    
    NSString *post = [NSString stringWithFormat:@"email=%@&sexo=%d&idade=%d&peso_atual=%f&altura=%d", email, sexo, idade, peso_atual,altura];
    return [self doTheRequest:post andUrl:url];
    
}
+(NSString*)criaComEmail: (NSString *)email peso: (float )peso_atual sexo: (BOOL )sexo altura: (int )altura idade: (int )idade{
    NSString *url = @"http://equipemoacir.com.br/servidor/cadastra.php";
    
    NSString *post = [NSString stringWithFormat:@"email=%@&sexo=%d&idade=%d&peso_atual=%f&altura=%d", email, sexo, idade, peso_atual,altura];
    return [self doTheRequest:post andUrl:url];
    
}
//$email = $_REQUEST["nome"];
//$sexo = $_REQUEST["sexo"];
//$peso_atual = $_REQUEST["peso_atual"];
//$idade = $_REQUEST["idade"];
//$altura = $_REQUEST["altura"];
@end
