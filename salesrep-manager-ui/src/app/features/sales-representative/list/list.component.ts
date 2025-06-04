import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource, MatTableModule } from '@angular/material/table';
import { MatPaginator, MatPaginatorModule } from '@angular/material/paginator';
import { SalesRepresentativeService } from '../../../core/services/sales-representative.service';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { SalesRepresentative } from '../sales-representative.model';
import { CommonModule } from '@angular/common';
import { MatIconModule } from '@angular/material/icon';
import { MatSelectModule } from '@angular/material/select';
import { MatOptionModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatButtonModule } from '@angular/material/button';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { ConfirmDialogComponent } from '../../../core/shared/confirm-dialog/confirm-dialog.component';



@Component({
  selector: 'app-list',
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.scss'],
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
    ReactiveFormsModule,
    MatDialogModule
  ]
})
export class ListComponent implements OnInit {
  displayedColumns: string[] = ['id', 'fullName', 'region', 'email', 'phoneNumber', 'status', 'actions'];
  dataSource = new MatTableDataSource<SalesRepresentative>();

  @ViewChild(MatPaginator) paginator!: MatPaginator;

  constructor(
    private salesRepService: SalesRepresentativeService,
    private snackBar: MatSnackBar,
    private dialog: MatDialog
  ) {}

  ngOnInit(): void {
  this.salesRepService.getAll().subscribe({
    next: (data) => {
      this.dataSource = new MatTableDataSource(data);
      this.dataSource.paginator = this.paginator;

      this.dataSource.filterPredicate = (rep: SalesRepresentative, filter: string) => {
        const fullName = (rep.firstName + ' ' + rep.lastName).toLowerCase();
        const email = rep.email?.toLowerCase() || '';
        const phone = rep.phoneNumber || '';
        const region = rep.region?.toLowerCase() || '';
        const status = rep.status?.toLowerCase() || '';
        return (
          fullName.includes(filter) ||
          email.includes(filter) ||
          phone.includes(filter) ||
          region.includes(filter) ||
          status.includes(filter)
        );
      };
    },
    error: (err) => console.error('API Error:', err)
  });
}

  applyFilter(event: Event): void {
    const filterValue = (event.target as HTMLInputElement).value.trim().toLowerCase();
    this.dataSource.filter = filterValue;
  }

  delete(id: number): void {
  const dialogRef = this.dialog.open(ConfirmDialogComponent, {
    data: {
      title: 'Delete Sales Representative',
      message: 'Are you sure you want to delete this sales representative?'
    }
  });

  dialogRef.afterClosed().subscribe(result => {
    if (result === true) {
      this.salesRepService.delete(id).subscribe({
        next: () => {
          this.dataSource.data = this.dataSource.data.filter(rep => rep.id !== id);
          this.snackBar.open('Sales representative deleted successfully.', 'Close', { duration: 3000 });
        },
        error: (err) => {
          const errorMsg = err?.error || 'Failed to delete record.';
          this.snackBar.open(errorMsg, 'Close', { duration: 3000 });
        }
      });
    }
  });
}
}