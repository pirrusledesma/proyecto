//
//  DetailViewController.m
//  proyecto
//
//  Created by Ileana Padilla on 4/4/14.
//  Copyright (c) 2014 paul. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController (){
    NSString *seleccionado;
    NSArray *imagesArray;
    NSString *images;
    
    NSArray *nomArray;
}

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //AppDelegate *dato = (AppDelegate*)([[UIApplication sharedApplication]delegate]);
    //seleccionado=dato.nombre;
    
    nomArray = [[NSArray alloc] initWithObjects:@"Ingenierio en Software",@"Ingenierio Civil",@"Ingeniero en Alimentos",@"Ingeniero en Biotecnología",@"Ingeniero Mecatrónico",@"Ingeniero Quimico", nil];
    imagesArray = [[NSArray alloc] initWithObjects:@"software.jpeg",@"civil.jpeg",@"alimentos.jpg",@"ingeniero_biotecnologia.jpg",@"mecatronico.jpg",@"quimico.jpg", nil];
    
     seleccionado=self.nombre;
     NSLog(@"Nombre: %@",seleccionado);
    
    if([seleccionado isEqualToString:@"Ingenierio en Software"]){
        self.labeld.text=@"Estudiar Ingeniería en Software en la UAG\nEstudia en la mejor universidad de Guadalajara\n\n Un ingeniero con el conocimiento en las tecnologías de desarrollo y aplicación de software podrá crear una nueva empresa o laborar para una importante empresa de TI.";
     }else if([seleccionado isEqualToString:@"Ingenierio Civil"]){
         self.labeld.text=@"Estudiar Ingeniería Civil en la UAG\nAprende Ingeniería civil en la mejor universidad de Guadalajara\n\n Podrás desempeñarte en el sector público y en el privado como empresario, director de empresa, promotor de desarrollos y administrador de empresas constructoras.";
     }else if([seleccionado isEqualToString:@"Ingeniero en Alimentos"]){
         self.labeld.text=@"Estudiar Ingeniería en Alimentos en la UAG\nEstudia en la mejor universidad de Guadalajara\n\n Formación profesional científica y tecnológica aplicada a la ingeniería en alimentos.";
     }else if([seleccionado isEqualToString:@"Ingeniero en Biotecnología"]){
         self.labeld.text=@"Estudiar Ingeniería en Biotecnología en la UAG\nAprende Ingeniería en Biotecnología en la mejor Universidad de Guadalajara\n\n Podrás realizar tu actividad profesional en el área de producción, investigación, desarrollo, innovación y control de productos biotecnológicos.";
     }else if([seleccionado isEqualToString:@"Ingeniero Mecatrónico"]){
         self.labeld.text=@"Estudiar Ingeniería Mecatrónica\nAprende ingeniería mecatrónica en la mejor universidad de Guadalajara\n\n Serás capaz de manejar y optimizar los procesos de fabricación que incluyan elementos electrónicos y mecánicos.";
     }else if([seleccionado isEqualToString:@"Ingeniero Quimico"]){
         self.labeld.text=@"Estudiar Ingeniería Química en la UAG\nEstudia en la mejor universidad de Guadalajara\n\n El Ingeniero Químico es un profesional que ayuda a hacer más eficientes el uso de recursos naturales y la transformación de materias primas en beneficio de la comunidad.";
     }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCompartir:(id)sender {
    NSString                  *message;
    message = self.labeld.text;
    
    NSString                  *initialTextString;
    NSArray                   *activityItems;
    UIImage                   *imagesScreen;
    UIActivityViewController  *activityViewController;
    
    
    imagesScreen = [UIImage imageNamed:@"uag.jpeg"];
    initialTextString = message;
    
    //INIT ACTIVITY VIEW CONTROLLES
    
    activityItems = @[message,imagesScreen];
    
    activityViewController = [[UIActivityViewController alloc]
                              initWithActivityItems:activityItems applicationActivities:nil];
    
    activityViewController.excludedActivityTypes=[NSArray arrayWithObjects:UIActivityTypeAssignToContact,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAirDrop,nil];
    
    [self presentViewController:activityViewController animated: YES completion:nil];
}
@end
