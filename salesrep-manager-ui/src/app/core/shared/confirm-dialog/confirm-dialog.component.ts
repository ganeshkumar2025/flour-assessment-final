import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
// Angular Material Modules
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatDialogModule } from '@angular/material/dialog';

@Component({
  selector: 'app-confirm-dialog',
  standalone: true, // ✅ MUST be set
  imports: [MatDialogModule, MatButtonModule, MatIconModule], // whatever you use in its template
  templateUrl: './confirm-dialog.component.html',
  styleUrls: ['./confirm-dialog.component.scss']
})
export class ConfirmDialogComponent {
  public data: { title: string; message: string };

constructor(
  @Inject(MAT_DIALOG_DATA)
  inputData: { title?: string; message?: string } | null,
  public dialogRef: MatDialogRef<ConfirmDialogComponent>
) {
  this.data = {
    title: inputData?.title ?? 'Confirm',
    message: inputData?.message ?? 'Are you sure you want to continue?'
  };
}
}