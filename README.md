# MA1508E Matlab Toolkit

MATLAB Script that runs in Command Window, offers a number of helper functions to help do linear algebra calculations faster, this was specifically designed to help students taking MA1508E Linear Algebra for Engineering, also helpful for MA1522 Linear Algebra for Computing but the final topic for 1508 is different to 1522. 


## File

Main script:

```text
MA1508E_Toolkit_copy.m
```

## Requirements

- MATLAB
- Symbolic Math Toolbox for symbolic features, especially:
  - symbolic RREF and parameter conditions
  - symbolic inverse conditions
  - symbolic eigenvalue calculations
  - polynomial factorisation
  - ODE solution formatting using symbolic expressions

Most numeric matrix operations can run with standard MATLAB functions.

## How to Run

1. Open MATLAB.
2. Set the current folder to the folder containing `MA1508E_Toolkit.m`.
3. In the MATLAB Command Window, run:

```matlab
MA1508E_Toolkit
```

4. A menu will appear in the Command Window.
5. Type the number of the operation you want and press Enter.
6. Follow the prompts to enter matrices, vectors, or symbolic expressions.
7. After each operation, press Enter to return to the main menu.
8. Enter `0` to quit.
```matlab
╔══════════════════════════════════════════════════════╗
║      MA1508E Complete Toolkit — All 7 Chapters       ║
╠══════════════════════════════════════════════════════╣
║  CHAPTER 1 — Linear Systems                          ║
║    1.  Row reduce to RREF                            ║
║    2.  Solve linear system Ax = b                    ║
║    3.  Symbolic RREF / consistency conditions        ║
╠══════════════════════════════════════════════════════╣
║  CHAPTER 2 — Matrix Algebra                          ║
║    4.  Matrix operations (add / multiply / transpose)║
║    5.  Matrix inverse A⁻¹                            ║
║    6.  Symbolic inverse and invertibility            ║
║    7.  Determinant                                   ║
╠══════════════════════════════════════════════════════╣
║  CHAPTERS 3–4 — Vector Spaces & Subspaces            ║
║    8.  Check span relations between S and T          ║
║    9.  Check linear independence of vector set       ║
║   10.  Four fundamental subspaces                    ║
║   11.  Basis and dimension of a subspace             ║
║   12.  Rank–Nullity check                            ║
║   26.  Check if a set is a subspace                  ║
║   27.  General vector from basis matrix              ║
║   28.  Intersection of two subspaces                 ║
╠══════════════════════════════════════════════════════╣
║  CHAPTER 5 — Orthogonality                           ║
║   13.  Gram–Schmidt orthogonalisation                ║
║   14.  Orthogonal projection onto a subspace         ║
║   15.  General form of orthogonal projection         ║
║   16.  Least squares solution of Ax = b              ║
║   17.  Check if matrix is orthogonal                 ║
╠══════════════════════════════════════════════════════╣
║  CHAPTER 6 — Eigenanalysis                           ║
║   18.  Eigenvalues, eigenvectors & multiplicities    ║
║   19.  Diagonalise A = PDP⁻¹                         ║
║   20.  Orthogonally diagonalise (symmetric A)        ║
║   21.  Matrix power Aᵏ via diagonalisation           ║
║   22.  Markov chain — steady-state vector            ║
║   25.  Characteristic polynomial linear factors      ║
╠══════════════════════════════════════════════════════╣
║  CHAPTER 7 — Linear ODE Systems                      ║
║   23.  Solve y'(t) = Ay(t) [general + IVP]           ║
║   24.  Higher-order constant-coefficient ODE         ║
╠══════════════════════════════════════════════════════╣
║   0.  Quit                                           ║
╚══════════════════════════════════════════════════════╝
Enter choice (0 to quit): 
```


## Features

### Chapter 1: Linear Systems

- Row reduce a matrix to reduced row echelon form, or RREF.
- Solve linear systems of the form `Ax = b`.
- Detect unique solutions, infinitely many solutions, and inconsistent systems.
- Identify pivot columns, free columns, and rank.
- Handle symbolic augmented matrices and report parameter conditions for consistency.

### Chapter 2: Matrix Algebra

- Add, subtract, scale, multiply, and transpose matrices.
- Compute matrix inverses.
- Check whether a matrix is invertible.
- Compute determinants.
- Show determinant-related properties.
- Compute symbolic inverses and symbolic invertibility conditions.

### Chapters 3-4: Vector Spaces and Subspaces

- Check span relations between two sets of vectors.
- Test linear independence.
- Find bases and dimensions for spans.
- Compute the four fundamental subspaces:
  - column space
  - null space
  - row space
  - left null space
- Verify the rank-nullity theorem.
- Check whether a set is a subspace.
- Convert a basis matrix into a general vector form.
- Find the intersection of two subspaces.

### Chapter 5: Orthogonality

- Perform Gram-Schmidt orthogonalisation.
- Produce an orthonormal basis.
- Compute orthogonal projections onto a subspace.
- Produce the general projection matrix `P`.
- Solve least-squares problems.
- Check whether a matrix is orthogonal.

### Chapter 6: Eigenvectors, Eigenvalues & Diagonalization

- Find eigenvalues and eigenvectors.
- Report algebraic and geometric multiplicities.
- Check diagonalizability over the real numbers.
- Diagonalise matrices as `A = P D P^-1`.
- Orthogonally diagonalise symmetric matrices.
- Compute matrix powers using diagonalisation.
- Find steady-state vectors for Markov chains.
- Factor characteristic polynomials into linear factors where possible.

### Chapter 7: Linear ODE Systems

- Solve first-order linear systems of the form:

```matlab
y'(t) = A y(t)
```

- Solve initial value problems when an initial condition is provided.
- Display real solution modes from eigenvalues and eigenvectors.
- Handle real and complex eigenvalue cases.
- Solve higher-order constant-coefficient homogeneous ODEs by converting them into first-order systems.
- Optionally display the matrix exponential `Phi(t) = exp(A t)`.
- Plot IVP solutions in MATLAB figure windows.

## Output

The program prints results directly in the MATLAB Command Window. Many outputs include:

- a readable displayed form
- a MATLAB-copyable form
- verification checks
- rank, dimension, and pivot information
- general solution forms with parameters

For some ODE features, MATLAB may also open figure windows showing solution curves.

## Notes

- The script is interactive and is not written as a function that returns values to another program. You should save outputs by copy pasting it into another script.
- Inputs must follow MATLAB syntax.
- Some symbolic results may depend on the Symbolic Math Toolbox and on MATLAB's ability to simplify the given expression.
- Numerical routines use tolerances to clean very small floating-point errors.
- For best results, enter exact integers or fractions where possible instead of long decimals.
