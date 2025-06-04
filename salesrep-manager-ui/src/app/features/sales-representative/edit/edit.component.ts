import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { SalesRepresentativeService } from '../../../core/services/sales-representative.service';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { MatDialog } from '@angular/material/dialog';
import { ConfirmDialogComponent } from '../../../core/shared/confirm-dialog/confirm-dialog.component';
import { CommonModule } from '@angular/common';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatIconModule } from '@angular/material/icon';
import { MatSelectModule } from '@angular/material/select';
import { MatOptionModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatButtonModule } from '@angular/material/button';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';

@Component({
  selector: 'app-edit',
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.scss'],
  standalone:true,
  imports: [
    CommonModule,
    MatTableModule,
    MatPaginatorModule,
    MatSnackBarModule,
    MatIconModule, 
    MatSelectModule,
    MatOptionModule,
    MatDatepickerModule,
    MatButtonModule,
    MatInputModule,
    FormsModule,
    RouterModule,
    MatFormFieldModule,
    ReactiveFormsModule
  ]
})
export class EditComponent implements OnInit {
  form: FormGroup;
  id!: number;

  constructor(
    private route: ActivatedRoute,
    private fb: FormBuilder,
    private service: SalesRepresentativeService,
    private router: Router,
    private snackBar: MatSnackBar,
    private dialog: MatDialog
  ) {
    this.form = this.fb.group({
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      phoneNumber: ['', Validators.required],
      region: ['', Validators.required],
      hireDate: ['', Validators.required],
      status: ['Active', Validators.required]
    });
  }

   ngOnInit(): void {
    this.id = Number(this.route.snapshot.paramMap.get('id'));

    this.form = this.fb.group({
      id: [this.id],
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      phoneNumber: ['', Validators.required],
      region: ['', Validators.required],
      hireDate: ['', Validators.required],
      status: ['Active', Validators.required]
    });

    this.service.getById(this.id).subscribe(data => {
      this.form.patchValue({
        ...data,
        hireDate: new Date(data.hireDate)  
      });
    });
  }

  onSubmit(): void {
  if (this.form.invalid) return;

  const id = this.route.snapshot.paramMap.get('id');
  if (!id) {
    this.snackBar.open('Invalid ID for update.', 'Close', { duration: 3000 });
    return;
  }

  const payload = {
    ...this.form.value,
    hireDate: this.formatDate(this.form.value.hireDate)
  };

  this.service.update(+id, payload).subscribe(() => {
    this.snackBar.open('Sales rep updated.', 'Close', { duration: 3000 });
    this.router.navigate(['/sales-representatives']);
  });
}

private formatDate(date: Date): string {
  const d = new Date(date);
  const month = `${d.getMonth() + 1}`.padStart(2, '0');
  const day = `${d.getDate()}`.padStart(2, '0');
  return `${d.getFullYear()}-${month}-${day}`;
}

  
  onCancel(): void {
  if (this.form.dirty) {
    const dialogRef = this.dialog.open(ConfirmDialogComponent, {
      data: {
        title: 'Discard Changes?',
        message: 'You have unsaved changes. Do you want to cancel?'
      }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result === true) {
        this.router.navigate(['/sales-representatives']);
      }
    });
  } else {
    this.router.navigate(['/sales-representatives']);
  }
}
  
}
