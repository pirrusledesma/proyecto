//
//  listaCarrera.m
//  proyecto
//
//  Created by Ileana Padilla on 4/4/14.
//  Copyright (c) 2014 paul. All rights reserved.
//

#import "listaCarrera.h"
#import "Cell_Carrera.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

@interface listaCarrera (){
    NSArray *imagesArray;
    NSMutableArray *array;
    NSString *texto;
    
    NSArray *nomArray;
    
    
}

@end

@implementation listaCarrera

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    nomArray = [[NSArray alloc] initWithObjects:@"Ingenierio en Software",@"Ingenierio Civil",@"Ingeniero en Alimentos",@"Ingeniero en Biotecnología",@"Ingeniero Mecatrónico",@"Ingeniero Quimico", nil];
    imagesArray = [[NSArray alloc] initWithObjects:@"software.jpeg",@"civil.jpeg",@"alimentos.jpg",@"ingeniero_biotecnologia.jpg",@"mecatronico.jpg",@"quimico.jpg", nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detail"]) {
        
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.nombre =  texto;
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return arraImg.count;
    return [nomArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"entro");
    Cell_Carrera *cell;
    static NSString *CellIdentifier = @"Cell_Carrera";
    
    cell = (Cell_Carrera *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[Cell_Carrera alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    
    cell.labelCarrera.text = nomArray[[indexPath row]];
    cell.imageViewCarrera.image = [UIImage imageNamed:imagesArray[[indexPath row]]];
    
    return cell;
    
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    texto=nomArray[indexPath.row];
    NSLog(@"texto: %@", texto);
    
    [self performSegueWithIdentifier:@"detail" sender:texto];
    
}


@end
