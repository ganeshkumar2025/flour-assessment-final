import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatDialogModule } from '@angular/material/dialog';
import { MatButtonModule } from '@angular/material/button';

import { ConfirmDialogComponent } from './confirm-dialog/confirm-dialog.component';

@NgModule({
  
  imports: [CommonModule, MatDialogModule, MatButtonModule]
  
})
export class SharedModule {}