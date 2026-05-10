%% MA1508E: Linear Algebra for Engineering — Complete MATLAB Toolkit
%  Covers all operations from Chapters 1–7 of the cheat sheet.
%
%  HOW TO USE:
%    1. Run the script.
%    2. A menu will appear — enter the number for the operation you want.
%    3. Follow the prompts to enter your matrix / vectors.
%
%  REQUIREMENTS: Symbolic Math Toolbox (for Ch 5–7 symbolic output).
%
% =========================================================================

clc; clear; close all;

while true
    print_menu();
    choice = input('Enter choice (0 to quit): ', 's');
    choice = strtrim(choice);
    fprintf('\n');

    switch choice
        % ---- Chapter 1 --------------------------------------------------
        case '1',  ch1_rref();
        case '2',  ch1_solve_system();
        case '3',  ch1_symbolic_rref();

        % ---- Chapter 2 --------------------------------------------------
        case '4',  ch2_matrix_ops();
        case '5',  ch2_inverse();
        case '6',  ch2_symbolic_inverse();
        case '7',  ch2_determinant();

        % ---- Chapter 3 & 4 ----------------------------------------------
        case '8',  ch3_check_span_relations();
        case '9',  ch3_linear_independence_checker();
        case '10', ch34_four_subspaces();
        case '11', ch34_basis_dimension();
        case '12', ch34_rank_nullity();
        case '26', ch3_subspace_checker();
        case '27', ch3_general_vector_from_basis();
        case '28', ch3_intersection_of_subspaces();

        % ---- Chapter 5 --------------------------------------------------
        case '13', ch5_gram_schmidt();
        case '14', ch5_projection();
        case '15', ch5_general_form_of_orthogonal_projection_onto_subspace();
        case '16', ch5_least_squares();
        case '17', ch5_orthogonal_matrix_check();

        % ---- Chapter 6 --------------------------------------------------
        case '18', ch6_eigenanalysis();
        case '19', ch6_diagonalize();
        case '20', ch6_orthogonal_diagonalize();
        case '21', ch6_matrix_power();
        case '22', ch6_markov();
        case '25', ch6_polynomial_factorisation();

        % ---- Chapter 7 --------------------------------------------------
        case '23', ch7_ode_solver();
        case '24', ch7_higher_order_ode_solver();

        case '0'
            fprintf('Goodbye!\n');
            break;
        otherwise
            fprintf('Invalid choice. Please try again.\n');
    end
    fprintf('\nPress Enter to return to menu...');
    input('', 's');
    clc;
end

% =========================================================================
%% MENU
% =========================================================================
function print_menu()
    fprintf('╔══════════════════════════════════════════════════════╗\n');
    fprintf('║      MA1508E Complete Toolkit — All 7 Chapters       ║\n');
    fprintf('╠══════════════════════════════════════════════════════╣\n');
    fprintf('║  CHAPTER 1 — Linear Systems                          ║\n');
    fprintf('║    1.  Row reduce to RREF                            ║\n');
    fprintf('║    2.  Solve linear system Ax = b                    ║\n');
    fprintf('║    3.  Symbolic RREF / consistency conditions        ║\n');
    fprintf('╠══════════════════════════════════════════════════════╣\n');
    fprintf('║  CHAPTER 2 — Matrix Algebra                          ║\n');
    fprintf('║    4.  Matrix operations (add / multiply / transpose)║\n');
    fprintf('║    5.  Matrix inverse A⁻¹                            ║\n');
    fprintf('║    6.  Symbolic inverse and invertibility            ║\n');
    fprintf('║    7.  Determinant                                   ║\n');
    fprintf('╠══════════════════════════════════════════════════════╣\n');
    fprintf('║  CHAPTERS 3–4 — Vector Spaces & Subspaces            ║\n');
    fprintf('║    8.  Check span relations between S and T          ║\n');
    fprintf('║    9.  Check linear independence of vector set       ║\n');
    fprintf('║   10.  Four fundamental subspaces                    ║\n');
    fprintf('║   11.  Basis and dimension of a subspace             ║\n');
    fprintf('║   12.  Rank–Nullity check                            ║\n');
    fprintf('║   26.  Check if a set is a subspace                  ║\n');
    fprintf('║   27.  General vector from basis matrix              ║\n');
    fprintf('║   28.  Intersection of two subspaces                 ║\n');
    fprintf('╠══════════════════════════════════════════════════════╣\n');
    fprintf('║  CHAPTER 5 — Orthogonality                           ║\n');
    fprintf('║   13.  Gram–Schmidt orthogonalisation                ║\n');
    fprintf('║   14.  Orthogonal projection onto a subspace         ║\n');
    fprintf('║   15.  General form of orthogonal projection         ║\n');
    fprintf('║   16.  Least squares solution of Ax = b              ║\n');
    fprintf('║   17.  Check if matrix is orthogonal                 ║\n');
    fprintf('╠══════════════════════════════════════════════════════╣\n');
    fprintf('║  CHAPTER 6 — Eigenanalysis                           ║\n');
    fprintf('║   18.  Eigenvalues, eigenvectors & multiplicities    ║\n');
    fprintf('║   19.  Diagonalise A = PDP⁻¹                         ║\n');
    fprintf('║   20.  Orthogonally diagonalise (symmetric A)        ║\n');
    fprintf('║   21.  Matrix power Aᵏ via diagonalisation           ║\n');
    fprintf('║   22.  Markov chain — steady-state vector            ║\n');
    fprintf('║   25.  Characteristic polynomial linear factors      ║\n');
    fprintf('╠══════════════════════════════════════════════════════╣\n');
    fprintf('║  CHAPTER 7 — Linear ODE Systems                      ║\n');
    fprintf('║   23.  Solve y''(t) = Ay(t) [general + IVP]           ║\n');
    fprintf('║   24.  Higher-order constant-coefficient ODE         ║\n');
    fprintf('╠══════════════════════════════════════════════════════╣\n');
    fprintf('║   0.  Quit                                           ║\n');
    fprintf('╚══════════════════════════════════════════════════════╝\n');
end

% =========================================================================
%% HELPERS
% =========================================================================
function A = input_matrix(prompt)
    fprintf('%s\n', prompt);
    fprintf('Enter as MATLAB syntax, e.g.  [1 2 3; 4 5 6]  then press Enter:\n');
    A = input('  > ');
end

function v = input_vector(prompt)
    fprintf('%s\n', prompt);
    fprintf('Enter as column vector, e.g.  [1; 2; 3]  then press Enter:\n');
    v = input('  > ');
    v = v(:);
end

function print_section(title)
    fprintf('\n------------------------------------------\n');
    fprintf('  %s\n', title);
    fprintf('------------------------------------------\n');
end

function print_result(label, value)
    fprintf('%s\n', label);
    display_value = clean_output_value(value);
    disp(display_value);
    fprintf('MATLAB form:\n  %s\n', matlab_form(value));
end

function txt = matlab_form(value)
    display_value = clean_output_value(value);
    if isa(display_value, 'sym')
        txt = char(display_value);
    elseif isnumeric(display_value) || islogical(display_value)
        txt = mat2str(display_value, 12);
    else
        try
            txt = mat2str(display_value);
        catch
            txt = '<MATLAB form unavailable>';
        end
    end
end

function out = clean_output_value(value)
    tol = 1e-12;

    if isnumeric(value)
        out = value;
        if isempty(value) || ~all(isfinite(value(:)))
            return;
        end

        real_part = real(value);
        imag_part = imag(value);
        real_part(abs(real_part) < tol) = 0;
        imag_part(abs(imag_part) < tol) = 0;
        out = real_part + 1i*imag_part;

        try
            out = simplify(sym(out, 'r'));
        catch
            % Keep the original numeric value if Symbolic Math Toolbox cannot convert it.
        end
    elseif isa(value, 'sym')
        try
            out = simplify(value);
        catch
            out = value;
        end
    else
        out = value;
    end
end

function out = maybe_simplify(val)
    if isa(val, 'sym')
        out = simplify(val);
    else
        out = val;
    end
end

function R = my_rref(A)
    % Reduced Row Echelon Form with partial pivoting
    [m, n] = size(A);
    R = double(A);
    pivot_row = 1;
    for col = 1:n
        % Find pivot
        rows_below = pivot_row:m;
        [~, rel_idx] = max(abs(R(rows_below, col)));
        abs_idx = rows_below(rel_idx);
        if abs(R(abs_idx, col)) < 1e-12, continue; end
        % Swap
        R([pivot_row, abs_idx], :) = R([abs_idx, pivot_row], :);
        % Scale
        R(pivot_row, :) = R(pivot_row, :) / R(pivot_row, col);
        % Eliminate
        for r = 1:m
            if r ~= pivot_row
                R(r, :) = R(r, :) - R(r, col) * R(pivot_row, :);
            end
        end
        pivot_row = pivot_row + 1;
        if pivot_row > m, break; end
    end
    R(abs(R) < 1e-12) = 0;
end

% =========================================================================
%% CHAPTER 1
% =========================================================================

function ch1_rref()
    print_section('Ch 1 — Row Reduce to RREF');
    A = input_matrix('Enter the matrix to row reduce (can be augmented [A|b]):');
    print_result('Original matrix:', A);
    R = my_rref(A);
    print_result('RREF:', R);

    % Identify pivots
    [m, n] = size(R);
    pivot_cols = [];
    for r = 1:m
        for c = 1:n
            if abs(R(r,c) - 1) < 1e-10 && all(abs(R([1:r-1, r+1:m], c)) < 1e-10)
                pivot_cols(end+1) = c;
                break;
            end
        end
    end
    free_cols = setdiff(1:n, pivot_cols);
    fprintf('Pivot columns:  %s\n', mat2str(pivot_cols));
    fprintf('Free columns:   %s\n', mat2str(free_cols));
    fprintf('Rank:           %d\n', numel(pivot_cols));
end

function ch1_solve_system()
    print_section('Ch 1 — Solve Linear System Ax = b');
    A = input_matrix('Enter coefficient matrix A:');
    b = input_vector('Enter right-hand side vector b:');

    [m, n] = size(A);
    aug = [A, b];
    R   = my_rref(aug);
    print_result('Augmented [A|b]:', aug);
    print_result('RREF of [A|b]:', R);

    % Check consistency: last column is a pivot?
    last_col_pivot = false;
    for r = 1:m
        row = R(r,:);
        if all(abs(row(1:n)) < 1e-10) && abs(row(end)) > 1e-10
            last_col_pivot = true; break;
        end
    end

    if last_col_pivot
        fprintf('INCONSISTENT — no solution (last column is a pivot column).\n');
        return;
    end

    % Identify pivot columns in A part
    pivot_cols = [];
    for r = 1:m
        for c = 1:n
            if abs(R(r,c) - 1) < 1e-10 && all(abs(R([1:r-1,r+1:m],c)) < 1e-10)
                pivot_cols(end+1) = c;
                break;
            end
        end
    end
    free_cols = setdiff(1:n, pivot_cols);

    if isempty(free_cols)
        x = R(1:n, end);
        print_result('UNIQUE solution:', x);
    else
        fprintf('INFINITELY MANY solutions.\n');
        fprintf('Free variables: x_%s\n', mat2str(free_cols));
        fprintf('\nGeneral solution (free params = s1, s2, ...):\n');

        % Build particular solution and null space vectors
        x_part = zeros(n, 1);
        for i = 1:numel(pivot_cols)
            x_part(pivot_cols(i)) = R(i, end);
        end
        print_result('  Particular solution xp:', x_part);

        for fi = 1:numel(free_cols)
            xh = zeros(n,1);
            xh(free_cols(fi)) = 1;
            for i = 1:numel(pivot_cols)
                xh(pivot_cols(i)) = -R(i, free_cols(fi));
            end
            print_result(sprintf('  + s%d * (null vector %d):', fi, fi), xh);
        end
    end
end

function ch1_symbolic_rref()
    print_section('Ch 1 — Symbolic RREF / Consistency Conditions');
    fprintf(['This tool treats your input as an augmented matrix [A|b].\n' ...
             'It will report parameter conditions for:\n' ...
             '  1. unique solution\n' ...
             '  2. infinitely many solutions\n' ...
             '  3. inconsistent system\n\n']);

    vars_str = strtrim(input(['Enter symbolic variables separated by spaces ' ...
                              '(e.g. a b c), or press Enter for none:\n  > '], 's'));
    if ~isempty(vars_str)
        eval(['syms ', vars_str]);
    end

    fprintf(['Enter the augmented matrix [A|b] using MATLAB symbolic syntax.\n' ...
             'Example: [1 a 2; 0 a-1 b]\n']);
    Aug = sym(input('  > '));

    [m, total_cols] = size(Aug);
    if total_cols < 2
        fprintf('ERROR: augmented matrix must have at least 2 columns.\n');
        return;
    end

    A = Aug(:, 1:end-1);
    b = Aug(:, end);
    n = size(A, 2);

    print_result('Augmented matrix [A|b]:', Aug);
    print_result('Coefficient matrix A:', A);
    print_result('Right-hand side b:', b);

    try
        R = rref(Aug);
        print_result('Symbolic RREF of [A|b] (generic branch):', R);
    catch
        fprintf('Symbolic RREF could not be displayed for this input.\n');
    end

    report = build_symbolic_condition_report(A, Aug);
    print_symbolic_condition_report(report);
end

function report = build_symbolic_condition_report(A, Aug)
    params = symvar(Aug);
    report = struct( ...
        'success', false, ...
        'unique_text', '', ...
        'general_text', '', ...
        'inconsistent_text', '', ...
        'note', '');

    if numel(params) == 1
        [report.success, report.unique_text, report.general_text, report.inconsistent_text] = ...
            classify_single_parameter_system(A, Aug, params(1));
    elseif ~isempty(params)
        [report.success, report.unique_text, report.general_text, report.inconsistent_text] = ...
            classify_symbolic_system_reduced(A, Aug, params);
    end

    if ~report.success
        report = build_legacy_symbolic_condition_report(A, Aug);
    end

    max_rank_Aug = min(size(Aug, 1), size(Aug, 2));
    if size(A, 2) > max_rank_Aug
        report.note = sprintf(['this system has %d unknowns but rank([A|b]) <= %d, ' ...
                               'so a unique solution is impossible for structural reasons.'], ...
                               size(A, 2), max_rank_Aug);
    end
end

function report = build_legacy_symbolic_condition_report(A, Aug)
    n = size(A, 2);
    max_rank_A = min(size(A, 1), size(A, 2));

    unique_cond = rank_exact_condition(A, n);
    unique_cond = combine_condition_strings(unique_cond, rank_exact_condition(Aug, n), '&');

    general_terms = {};
    for r = 0:min(max_rank_A, n-1)
        general_terms{end+1} = combine_condition_strings( ...
            rank_exact_condition(A, r), rank_exact_condition(Aug, r), '&');
    end

    inconsistent_terms = {};
    for r = 0:max_rank_A
        inconsistent_terms{end+1} = combine_condition_strings( ...
            rank_at_most_condition(A, r), rank_at_least_condition(Aug, r+1), '&');
    end

    report = struct( ...
        'success', true, ...
        'unique_text', unique_cond, ...
        'general_text', join_condition_terms(general_terms, '|'), ...
        'inconsistent_text', join_condition_terms(inconsistent_terms, '|'), ...
        'note', '');
end

function print_symbolic_condition_report(report)
    fprintf('\n--- Parameter Conditions ---\n');
    fprintf('UNIQUE solution:\n  %s\n\n', report.unique_text);
    fprintf('INFINITELY MANY solutions:\n  %s\n\n', report.general_text);
    fprintf('INCONSISTENT system:\n  %s\n', report.inconsistent_text);

    if ~isempty(report.note)
        fprintf('\nNote: %s\n', report.note);
    end
end

function [success, unique_text, general_text, inconsistent_text] = ...
         classify_symbolic_system_reduced(A, Aug, params)
    success = false;
    unique_text = '';
    general_text = '';
    inconsistent_text = '';

    n = size(A, 2);
    max_rank_A = min(size(A, 1), size(A, 2));

    if size(A, 1) == size(A, 2) && numel(params) > 1
        [success, unique_text, general_text, inconsistent_text] = ...
            classify_square_by_singular_factors(A, Aug, params);
        if success
            return;
        end
    end

    if size(A, 1) == size(A, 2)
        unique_expr = (simplify(det(A)) ~= 0);
        general_expr = all_zero_expr(collect_square_minors(Aug, n));
        inconsistent_expr = (~general_expr) & (~unique_expr);

        unique_text = pretty_condition_text(unique_expr, params);
        general_text = reduce_condition_text(general_expr, params);
        inconsistent_text = reduce_condition_text(inconsistent_expr, params);
    else
        unique_expr = rank_exact_condition_expr(A, n);
        unique_text = pretty_condition_text(unique_expr, params);

        general_texts = {};
        for r = 0:min(max_rank_A, n-1)
            term = rank_exact_condition_expr(A, r) & rank_exact_condition_expr(Aug, r);
            term_text = pretty_condition_text(term, params);
            if ~strcmp(term_text, 'none')
                general_texts{end+1} = term_text; %#ok<AGROW>
            end
        end

        inconsistent_texts = {};
        for r = 0:max_rank_A
            term = rank_at_most_condition_expr(A, r) & rank_at_least_condition_expr(Aug, r+1);
            term_text = pretty_condition_text(term, params);
            if ~strcmp(term_text, 'none')
                inconsistent_texts{end+1} = term_text; %#ok<AGROW>
            end
        end

        general_text = join_condition_texts(general_texts);
        inconsistent_text = join_condition_texts(inconsistent_texts);
    end

    if isempty(unique_text) || isempty(general_text) || isempty(inconsistent_text)
        return;
    end

    success = true;
end

function [success, unique_text, general_text, inconsistent_text] = ...
         classify_square_by_singular_factors(A, Aug, params)
    success = false;
    unique_text = '';
    general_text = '';
    inconsistent_text = '';

    detA = simplify(expand(det(A)));
    unique_text = format_factored_nonzero_condition(detA);

    try
        det_factors = factor(detA);
    catch
        det_factors = detA;
    end
    det_factors = det_factors(:);

    general_branches = {};
    inconsistent_branches = {};

    for i = 1:numel(det_factors)
        fi = simplify(det_factors(i));
        if isempty(symvar(fi)) || symbolic_equal(fi, sym(1)) || symbolic_equal(fi, sym(-1))
            continue;
        end

        factor_vars = symvar(fi);
        if numel(factor_vars) ~= 1
            return;
        end

        branch_var = factor_vars(1);
        try
            branch_roots = solve(fi == 0, branch_var, 'ReturnConditions', false);
        catch
            return;
        end

        for j = 1:numel(branch_roots)
            root_j = simplify(branch_roots(j));
            A_sub = simplify(subs(A, branch_var, root_j));
            Aug_sub = simplify(subs(Aug, branch_var, root_j));
            rem_params = symvar(Aug_sub);
            branch_prefix = sprintf('%s = %s', char(branch_var), char(root_j));

            if isempty(rem_params)
                branch_case = classify_constant_system(A_sub, Aug_sub);
                switch branch_case
                    case 'general'
                        general_branches{end+1} = branch_prefix; %#ok<AGROW>
                    case 'inconsistent'
                        inconsistent_branches{end+1} = branch_prefix; %#ok<AGROW>
                end
            elseif numel(rem_params) == 1
                [ok, ~, branch_general, branch_inconsistent] = ...
                    classify_single_parameter_system(A_sub, Aug_sub, rem_params(1));
                if ~ok
                    return;
                end
                if ~strcmp(branch_general, 'none')
                    general_branches{end+1} = combine_branch_text(branch_prefix, branch_general); %#ok<AGROW>
                end
                if ~strcmp(branch_inconsistent, 'none')
                    inconsistent_branches{end+1} = combine_branch_text(branch_prefix, branch_inconsistent); %#ok<AGROW>
                end
            else
                return;
            end
        end
    end

    general_text = join_condition_texts(general_branches);
    inconsistent_text = join_condition_texts(inconsistent_branches);
    success = true;
end

function case_name = classify_constant_system(A, Aug)
    n = size(A, 2);
    rankA = rank(A);
    rankAug = rank(Aug);
    if rankA ~= rankAug
        case_name = 'inconsistent';
    elseif rankA == n
        case_name = 'unique';
    else
        case_name = 'general';
    end
end

function text = combine_branch_text(prefix, suffix)
    suffix = strtrim(suffix);
    if strcmp(suffix, 'all values of the parameter') || strcmp(suffix, 'all parameter values')
        text = prefix;
    else
        text = sprintf('%s and %s', prefix, suffix);
    end
end

function text = pretty_condition_text(expr, params)
    if is_single_nonzero_condition(expr)
        left_side = lhs(expr);
        text = format_factored_nonzero_condition(left_side);
    else
        text = reduce_condition_text(expr, params);
    end
end

function tf = is_single_nonzero_condition(expr)
    tf = false;
    try
        tf = strcmp(char(feval(symengine, 'op', expr, 0)), '_not') && ...
             symbolic_equal(lhs(expr), sym(0)) == false;
    catch
    end
end

function text = format_factored_nonzero_condition(expr)
    try
        factors = factor(simplify(expand(expr)));
    catch
        text = format_single_nonzero_factor(expr);
        return;
    end

    if isempty(factors)
        text = format_single_nonzero_factor(expr);
        return;
    end

    if ~isa(factors, 'sym')
        text = format_single_nonzero_factor(expr);
        return;
    end

    factors = factors(:);
    clean_factors = sym([]);
    for i = 1:numel(factors)
        fi = simplify(factors(i));
        if isempty(symvar(fi))
            continue;
        end
        clean_factors = append_unique_sym(clean_factors, fi);
    end

    if isempty(clean_factors)
        text = format_single_nonzero_factor(expr);
        return;
    end

    parts = cell(1, numel(clean_factors));
    for i = 1:numel(clean_factors)
        parts{i} = format_single_nonzero_factor(clean_factors(i));
    end
    text = strjoin(parts, ' and ');
end

function text = format_single_nonzero_factor(factor_expr)
    factor_expr = simplify(expand(factor_expr));
    vars = symvar(factor_expr);

    if numel(vars) == 1
        v = vars(1);
        d = feval(symengine, 'degree', factor_expr, v);
        if symbolic_equal(sym(d), sym(1))
            c0 = subs(factor_expr, v, sym(0));
            c1 = simplify(subs(factor_expr, v, sym(1)) - c0);
            if ~symbolic_equal(c1, sym(0))
                root_val = simplify(-c0 / c1);
                text = sprintf('%s ≠ %s', char(v), char(root_val));
                return;
            end
        end
    end

    text = sprintf('%s ≠ 0', char(factor_expr));
end

function text = join_condition_texts(texts)
    if isempty(texts)
        text = 'none';
        return;
    end

    filtered = {};
    for i = 1:numel(texts)
        ti = strtrim(texts{i});
        if strcmp(ti, 'none')
            continue;
        end
        if strcmp(ti, 'all parameter values')
            text = 'all parameter values';
            return;
        end
        if ~any(strcmp(filtered, ti))
            filtered{end+1} = ti; %#ok<AGROW>
        end
    end

    filtered = remove_redundant_branches(filtered);

    if isempty(filtered)
        text = 'none';
    elseif numel(filtered) == 1
        text = filtered{1};
    else
        text = strjoin(filtered, ' or ');
    end
end

function filtered = remove_redundant_branches(branches)
    keep = true(1, numel(branches));
    atom_sets = cell(1, numel(branches));

    for i = 1:numel(branches)
        atom_sets{i} = split_branch_atoms(branches{i});
    end

    for i = 1:numel(branches)
        for j = 1:numel(branches)
            if i == j || ~keep(i) || ~keep(j)
                continue;
            end
            if is_subset_atoms(atom_sets{j}, atom_sets{i})
                keep(i) = false;
            end
        end
    end

    filtered = branches(keep);
end

function atoms = split_branch_atoms(text)
    text = strrep(text, '(', '');
    text = strrep(text, ')', '');
    parts = strsplit(text, ' and ');
    atoms = cellfun(@strtrim, parts, 'UniformOutput', false);
    atoms = atoms(~cellfun(@isempty, atoms));
end

function tf = is_subset_atoms(subset_atoms, full_atoms)
    tf = true;
    for i = 1:numel(subset_atoms)
        if ~any(strcmp(subset_atoms{i}, full_atoms))
            tf = false;
            return;
        end
    end
end

function expr = rank_exact_condition_expr(M, r)
    expr = rank_at_least_condition_expr(M, r) & rank_at_most_condition_expr(M, r);
end

function expr = rank_at_least_condition_expr(M, r)
    if r == 0
        expr = symbolic_true_expr();
        return;
    end
    expr = any_nonzero_expr(collect_square_minors(M, r));
end

function expr = rank_at_most_condition_expr(M, r)
    max_rank = min(size(M, 1), size(M, 2));
    if r >= max_rank
        expr = symbolic_true_expr();
        return;
    end
    expr = all_zero_expr(collect_square_minors(M, r + 1));
end

function expr = any_nonzero_expr(minors)
    expr = symbolic_false_expr();
    for i = 1:numel(minors)
        minor_val = simplify(minors(i));
        if isAlways(minor_val == 0, 'Unknown', 'false')
            continue;
        end
        if isAlways(minor_val ~= 0, 'Unknown', 'false')
            expr = symbolic_true_expr();
            return;
        end
        expr = expr | (minor_val ~= 0);
    end
end

function expr = all_zero_expr(minors)
    expr = symbolic_true_expr();
    for i = 1:numel(minors)
        minor_val = simplify(minors(i));
        if isAlways(minor_val == 0, 'Unknown', 'false')
            continue;
        end
        if isAlways(minor_val ~= 0, 'Unknown', 'false')
            expr = symbolic_false_expr();
            return;
        end
        expr = expr & (minor_val == 0);
    end
end

function expr = symbolic_true_expr()
    expr = (sym(0) == 0);
end

function expr = symbolic_false_expr()
    expr = (sym(0) ~= 0);
end

function [success, unique_text, general_text, inconsistent_text] = ...
         classify_single_parameter_system(A, Aug, param)
    success = false;
    unique_text = '';
    general_text = '';
    inconsistent_text = '';

    n = size(A, 2);
    candidate_vals = collect_candidate_parameter_values(A, Aug, param);
    sample_val = pick_generic_sample_value(param, candidate_vals);

    if isempty(sample_val)
        return;
    end

    generic_case = classify_parameter_value(A, Aug, param, sample_val);
    if strcmp(generic_case, 'unknown')
        return;
    end

    try
        generic_rank_A = double(rank(simplify(subs(A, param, sample_val))));
        generic_rank_Aug = double(rank(simplify(subs(Aug, param, sample_val))));
    catch
        return;
    end

    candidate_vals = append_sym_list(candidate_vals, ...
        collect_exceptional_parameter_values(A, Aug, param, generic_rank_A, generic_rank_Aug));

    unique_vals = sym([]);
    general_vals = sym([]);
    inconsistent_vals = sym([]);

    for i = 1:numel(candidate_vals)
        val = candidate_vals(i);
        case_name = classify_parameter_value(A, Aug, param, val);
        switch case_name
            case 'unique'
                unique_vals = append_unique_sym(unique_vals, val);
            case 'general'
                general_vals = append_unique_sym(general_vals, val);
            case 'inconsistent'
                inconsistent_vals = append_unique_sym(inconsistent_vals, val);
            otherwise
                return;
        end
    end

    switch generic_case
        case 'unique'
            unique_text = format_complement_condition(param, ...
                append_sym_list(general_vals, inconsistent_vals));
        case 'general'
            general_text = format_complement_condition(param, ...
                append_sym_list(unique_vals, inconsistent_vals));
        case 'inconsistent'
            inconsistent_text = format_complement_condition(param, ...
                append_sym_list(unique_vals, general_vals));
        otherwise
            return;
    end

    if ~strcmp(generic_case, 'unique')
        unique_text = format_equality_condition(param, unique_vals);
    end
    if ~strcmp(generic_case, 'general')
        general_text = format_equality_condition(param, general_vals);
    end
    if ~strcmp(generic_case, 'inconsistent')
        inconsistent_text = format_equality_condition(param, inconsistent_vals);
    end

    if strcmp(generic_case, 'unique') && n > min(size(Aug, 1), size(Aug, 2))
        unique_text = 'none';
    end

    success = true;
end

function vals = collect_candidate_parameter_values(A, Aug, param)
    vals = sym([]);
    maxA = min(size(A, 1), size(A, 2));
    maxAug = min(size(Aug, 1), size(Aug, 2));

    for k = 1:maxA
        vals = append_sym_list(vals, solve_zero_set(collect_square_minors(A, k), param));
    end
    for k = 1:maxAug
        vals = append_sym_list(vals, solve_zero_set(collect_square_minors(Aug, k), param));
    end
end

function vals = collect_exceptional_parameter_values(A, Aug, param, generic_rank_A, generic_rank_Aug)
    vals = sym([]);
    gcd_A = common_factor_of_minors(A, generic_rank_A, param);
    gcd_Aug = common_factor_of_minors(Aug, generic_rank_Aug, param);

    vals = append_sym_list(vals, solve_zero_set(gcd_A, param));
    vals = append_sym_list(vals, solve_zero_set(gcd_Aug, param));
end

function g = common_factor_of_minors(M, k, param)
    g = sym(0);
    if k <= 0
        return;
    end

    minors = collect_square_minors(M, k);
    relevant = sym([]);
    for i = 1:numel(minors)
        minor_i = simplify(minors(i));
        if isAlways(minor_i == 0, 'Unknown', 'false')
            continue;
        end
        [num_i, ~] = numden(minor_i);
        relevant(end+1, 1) = expand(num_i); %#ok<AGROW>
    end

    if isempty(relevant)
        return;
    end

    g = relevant(1);
    for i = 2:numel(relevant)
        g = simplify(feval(symengine, 'gcd', g, relevant(i)));
        if isAlways(g == 1, 'Unknown', 'false') || isAlways(g == -1, 'Unknown', 'false')
            g = sym(1);
            return;
        end
    end
end

function vals = solve_zero_set(exprs, param)
    vals = sym([]);
    for i = 1:numel(exprs)
        expr = simplify(exprs(i));
        if isequal(expr, sym(0)) || isequal(expr, sym(1)) || isequal(expr, sym(-1))
            continue;
        end
        if ~has(expr, param)
            continue;
        end
        try
            roots_i = solve(expr == 0, param, 'ReturnConditions', false);
        catch
            roots_i = sym([]);
        end
        vals = append_sym_list(vals, roots_i);
    end
end

function sample_val = pick_generic_sample_value(param, candidate_vals)
    probes = sym([0, 1, -1, 2, -2, 3, -3, 4, -4, 5, -5]);
    sample_val = sym([]);

    for i = 1:numel(probes)
        ok = true;
        for j = 1:numel(candidate_vals)
            if isAlways(probes(i) == candidate_vals(j), 'Unknown', 'false')
                ok = false;
                break;
            end
        end
        if ok
            sample_val = probes(i);
            return;
        end
    end

    try
        sample_val = simplify(max(candidate_vals) + 1); %#ok<MXFND>
    catch
        sample_val = sym([]);
    end
end

function case_name = classify_parameter_value(A, Aug, param, val)
    A_sub = simplify(subs(A, param, val));
    Aug_sub = simplify(subs(Aug, param, val));
    n = size(A, 2);

    try
        rankA = double(rank(A_sub));
        rankAug = double(rank(Aug_sub));
    catch
        case_name = 'unknown';
        return;
    end

    if rankA ~= rankAug
        case_name = 'inconsistent';
    elseif rankA == n
        case_name = 'unique';
    else
        case_name = 'general';
    end
end

function vals = append_sym_list(vals, new_vals)
    for i = 1:numel(new_vals)
        vals = append_unique_sym(vals, simplify(new_vals(i)));
    end
end

function vals = append_unique_sym(vals, new_val)
    new_val = simplify(new_val);

    if isempty(vals)
        vals = new_val;
        if size(vals, 2) ~= 1
            vals = vals(:);
        end
        return;
    end

    for i = 1:numel(vals)
        if symbolic_equal(vals(i), new_val)
            return;
        end
    end
    vals(end+1, 1) = new_val; %#ok<AGROW>
end

function tf = symbolic_equal(expr1, expr2)
    try
        diff_expr = simplify(expr1 - expr2);
        if isequal(diff_expr, sym(0))
            tf = true;
            return;
        end
        tf_raw = isAlways(diff_expr == 0, 'Unknown', 'false');
        if isnumeric(tf_raw) || islogical(tf_raw)
            tf = isscalar(tf_raw) && logical(tf_raw);
        else
            tf = false;
        end
    catch
        tf = false;
    end
end

function text = reduce_condition_text(expr, params)
    try
        reduced = reduce(expr, params);
    catch
        reduced = expr;
    end

    try
        reduced = feval(symengine, 'logic::simplify', reduced);
    catch
    end

    try
        reduced = simplify(reduced);
    catch
    end

    text = char(reduced);
    text = strrep(text, '~=', '≠');
    text = strrep(text, '==', '=');
    text = strrep(text, '&', ' and ');
    text = strrep(text, '|', ' or ');
    text = strrep(text, 'symtrue', 'true');
    text = strrep(text, 'symfalse', 'false');
    text = strtrim(text);

    if strcmpi(text, 'false')
        text = 'none';
    elseif strcmpi(text, 'true')
        text = 'all parameter values';
    end
end

function text = format_equality_condition(param, vals)
    if isempty(vals)
        text = 'none';
        return;
    end

    vals = sort_symbolic_values(vals);
    if numel(vals) == 1
        text = sprintf('%s = %s', char(param), char(vals(1)));
        return;
    end

    pieces = cell(1, numel(vals));
    for i = 1:numel(vals)
        pieces{i} = sprintf('%s = %s', char(param), char(vals(i)));
    end
    text = strjoin(pieces, ' or ');
end

function text = format_complement_condition(param, excluded_vals)
    if isempty(excluded_vals)
        text = 'all values of the parameter';
        return;
    end

    excluded_vals = sort_symbolic_values(excluded_vals);
    if numel(excluded_vals) == 1
        text = sprintf('%s ≠ %s', char(param), char(excluded_vals(1)));
        return;
    end

    pieces = cell(1, numel(excluded_vals));
    for i = 1:numel(excluded_vals)
        pieces{i} = sprintf('%s ≠ %s', char(param), char(excluded_vals(i)));
    end
    text = strjoin(pieces, ' and ');
end

function vals = sort_symbolic_values(vals)
    keys = cell(numel(vals), 1);
    for i = 1:numel(vals)
        keys{i} = char(vals(i));
    end
    [~, idx] = sort(keys);
    vals = vals(idx);
end

function cond = rank_exact_condition(M, r)
    cond = combine_condition_strings(rank_at_least_condition(M, r), ...
                                     rank_at_most_condition(M, r), '&');
end

function cond = rank_at_least_condition(M, r)
    if r == 0
        cond = 'true';
        return;
    end
    minors = collect_square_minors(M, r);
    cond = any_nonzero_condition(minors);
end

function cond = rank_at_most_condition(M, r)
    max_rank = min(size(M, 1), size(M, 2));
    if r >= max_rank
        cond = 'true';
        return;
    end
    minors = collect_square_minors(M, r + 1);
    cond = all_zero_condition(minors);
end

function minors = collect_square_minors(M, k)
    [m, n] = size(M);
    if k < 1 || k > min(m, n)
        minors = sym([]);
        return;
    end

    row_sets = nchoosek(1:m, k);
    col_sets = nchoosek(1:n, k);
    minors = sym([]);

    for i = 1:size(row_sets, 1)
        for j = 1:size(col_sets, 1)
            minor_val = simplify(det(M(row_sets(i, :), col_sets(j, :))));
            minors(end+1, 1) = minor_val; %#ok<AGROW>
        end
    end
end

function cond = any_nonzero_condition(minors)
    terms = {};
    for i = 1:numel(minors)
        minor_val = simplify(minors(i));
        if isAlways(minor_val == 0, 'Unknown', 'false')
            continue;
        end
        if isAlways(minor_val ~= 0, 'Unknown', 'false')
            cond = 'true';
            return;
        end
        terms{end+1} = sprintf('(%s ~= 0)', char(minor_val)); %#ok<AGROW>
    end

    if isempty(terms)
        cond = 'false';
    else
        cond = join_condition_terms(terms, '|');
    end
end

function cond = all_zero_condition(minors)
    terms = {};
    for i = 1:numel(minors)
        minor_val = simplify(minors(i));
        if isAlways(minor_val == 0, 'Unknown', 'false')
            continue;
        end
        if isAlways(minor_val ~= 0, 'Unknown', 'false')
            cond = 'false';
            return;
        end
        terms{end+1} = sprintf('(%s == 0)', char(minor_val)); %#ok<AGROW>
    end

    if isempty(terms)
        cond = 'true';
    else
        cond = join_condition_terms(terms, '&');
    end
end

function cond = combine_condition_strings(left, right, op)
    if strcmp(left, 'false') || strcmp(right, 'false')
        cond = 'false';
        return;
    end
    if strcmp(left, 'true')
        cond = right;
        return;
    end
    if strcmp(right, 'true')
        cond = left;
        return;
    end
    if strcmp(left, right)
        cond = left;
        return;
    end
    cond = sprintf('(%s) %s (%s)', left, op, right);
end

function cond = join_condition_terms(terms, op)
    filtered = {};
    for i = 1:numel(terms)
        term = terms{i};
        if strcmp(term, 'false') && strcmp(op, '|')
            continue;
        end
        if strcmp(term, 'true') && strcmp(op, '&')
            continue;
        end
        if strcmp(term, 'true') && strcmp(op, '|')
            cond = 'true';
            return;
        end
        if strcmp(term, 'false') && strcmp(op, '&')
            cond = 'false';
            return;
        end
        filtered{end+1} = term; %#ok<AGROW>
    end

    if isempty(filtered)
        if strcmp(op, '&')
            cond = 'true';
        else
            cond = 'false';
        end
        return;
    end

    cond = filtered{1};
    for i = 2:numel(filtered)
        cond = sprintf('(%s) %s (%s)', cond, op, filtered{i});
    end
end

% =========================================================================
%% CHAPTER 2
% =========================================================================

function ch2_matrix_ops()
    print_section('Ch 2 — Matrix Operations');
    fprintf('Choose operation:\n');
    fprintf('  1. A + B    2. A - B    3. c*A    4. A*B    5. A^T\n');
    op = input('  > ', 's');

    switch strtrim(op)
        case '1'
            A = input_matrix('Enter matrix A:');
            B = input_matrix('Enter matrix B (same size):');
            print_result('A + B =', A + B);
        case '2'
            A = input_matrix('Enter matrix A:');
            B = input_matrix('Enter matrix B (same size):');
            print_result('A - B =', A - B);
        case '3'
            A = input_matrix('Enter matrix A:');
            c = input('Enter scalar c: ');
            print_result('c*A =', c*A);
        case '4'
            A = input_matrix('Enter matrix A (m x p):');
            B = input_matrix('Enter matrix B (p x n):');
            if size(A,2) ~= size(B,1)
                fprintf('ERROR: inner dimensions must agree.\n'); return;
            end
            print_result('A*B =', A*B);
            if size(A,1)==size(B,2) && size(A,2)==size(B,1)
                print_result('B*A =', B*A);
                if isequal(size(A*B), size(B*A))
                    fprintf('Note: AB == BA? %s\n', mat2str(isequal(A*B, B*A)));
                end
            end
        case '5'
            A = input_matrix('Enter matrix A:');
            print_result('A^T =', A');
            fprintf('Is A symmetric (A == A^T)? %s\n', mat2str(norm(A-A','fro') < 1e-10));
        otherwise
            fprintf('Invalid operation.\n');
    end
end

function ch2_inverse()
    print_section('Ch 2 — Matrix Inverse');
    A = input_matrix('Enter square matrix A:');
    n = size(A,1);
    assert(size(A,2)==n, 'Matrix must be square.');

    d = det(A);
    fprintf('det(A) = %.6g\n', d);

    if rank(A) < n
        fprintf('rank(A) < n  =>  A is SINGULAR (not invertible).\n');
        return;
    end

    rc = rcond(A);
    if rc < 1e-12
        fprintf('WARNING: A is invertible but very ill-conditioned (rcond = %.2e).\n', rc);
        fprintf('The numerical inverse may be unreliable.\n');
    end

    Ainv = A \ eye(n);
    fprintf('A is INVERTIBLE.\n');
    print_result('A^{-1} =', Ainv);

    % Verify
    err = norm(A*Ainv - eye(n), 'fro');
    fprintf('Verification: ||A * A^{-1} - I|| = %.2e  ✓\n', err);

    if n == 2
        fprintf('\n2×2 formula check: (1/det)*[d -b; -c a]\n');
        Af = (1/d) * [A(2,2), -A(1,2); -A(2,1), A(1,1)];
        print_result('Formula result:', Af);
    end
end

function ch2_symbolic_inverse()
    print_section('Ch 2 — Symbolic Inverse and Invertibility');
    vars_str = strtrim(input(['Enter symbolic variables separated by spaces ' ...
                              '(e.g. a b c), or press Enter for none:\n  > '], 's'));
    if ~isempty(vars_str)
        eval(['syms ', vars_str]);
    end

    fprintf(['Enter a square matrix using MATLAB symbolic syntax.\n' ...
             'Use * for multiplication, e.g. [a 1; 0 b-2] or [1 2*a; 0 3].\n']);
    A = sym(input('  > '));

    [m, n] = size(A);
    if m ~= n
        fprintf('ERROR: matrix must be square.\n');
        return;
    end

    detA = simplify(expand(det(A)));
    params = symvar(A);

    print_result('Matrix A:', A);
    print_result('det(A) =', detA);

    if isempty(params)
        if isAlways(detA == 0, 'Unknown', 'false')
            fprintf('A is NOT invertible.\n');
            fprintf('Invertibility condition:\n  none\n');
            return;
        end

        Ainv = simplify(inv(A));
        fprintf('A is invertible.\n');
        fprintf('Invertibility condition:\n  always\n');
        print_result('A^{-1} =', Ainv);
        return;
    end

    invertible_text = pretty_condition_text(detA ~= 0, params);
    singular_text = reduce_condition_text(detA == 0, params);

    fprintf('Invertibility condition:\n  %s\n', invertible_text);
    fprintf('Singular when:\n  %s\n', singular_text);

    if strcmp(invertible_text, 'none')
        fprintf('A is NOT invertible for any parameter values.\n');
        return;
    end

    Ainv = simplify(inv(A));
    print_result('A^{-1} (valid when the invertibility condition holds) =', Ainv);
end

function ch2_determinant()
    print_section('Ch 2 — Determinant');
    A = input_matrix('Enter square matrix A:');
    assert(size(A,1)==size(A,2), 'Matrix must be square.');
    d = det(A);
    fprintf('det(A) = %.6g\n', d);
    fprintf('Invertible? %s\n', mat2str(abs(d) > 1e-10));

    % Properties reminder
    fprintf('\nKey properties (from cheat sheet):\n');
    fprintf('  det(A^T)   = %.6g  (should equal det(A))\n', det(A'));
    fprintf('  det(2*A)   = %.6g  (should equal 2^n * det(A) = %.6g)\n', ...
            det(2*A), 2^size(A,1)*d);
end

% =========================================================================
%% CHAPTERS 3–4
% =========================================================================

function ch3_check_span_relations()
    print_section('Ch 3 — Check Span Relations Between S and T');
    fprintf('Enter matrices whose columns are the vectors in sets S and T.\n');
    S = input_matrix('Enter matrix S (columns = vectors in set S):');
    T = input_matrix('Enter matrix T (columns = vectors in set T):');

    if size(S, 1) ~= size(T, 1)
        fprintf('ERROR: S and T must have vectors in the same ambient space.\n');
        return;
    end

    rankS = rank(S);
    rankT = rank(T);
    rankST = rank([S, T]);

    spanS_in_spanT = (rank([T, S]) == rankT);
    spanT_in_spanS = (rank([S, T]) == rankS);
    spans_equal = spanS_in_spanT && spanT_in_spanS;

    fprintf('\nrank(S)      = %d\n', rankS);
    fprintf('rank(T)      = %d\n', rankT);
    fprintf('rank([S T])  = %d\n\n', rankST);

    fprintf('Is span(S) contained in span(T)?  %s\n', mat2str(spanS_in_spanT));
    fprintf('Is span(T) contained in span(S)?  %s\n', mat2str(spanT_in_spanS));
    fprintf('Is span(S) = span(T)?             %s\n', mat2str(spans_equal));

    if spanS_in_spanT
        fprintf('\nEvery vector in S lies in span(T), so span(S) ⊆ span(T).\n');
    else
        fprintf('\nAt least one vector in S adds a new direction beyond span(T).\n');
    end

    if spanT_in_spanS
        fprintf('Every vector in T lies in span(S), so span(T) ⊆ span(S).\n');
    else
        fprintf('At least one vector in T adds a new direction beyond span(S).\n');
    end
end



function ch3_intersection_of_subspaces()
    print_section('Ch 3 — Intersection of Two Subspaces');
    fprintf('Enter basis matrices S and T. Their columns span subspaces U and V.\n');
    fprintf('This tool returns a basis and general vector for U ∩ V.\n\n');

    S = sym(input_matrix('Enter basis matrix S for subspace U:'));
    T = sym(input_matrix('Enter basis matrix T for subspace V:'));

    if size(S, 1) ~= size(T, 1)
        fprintf('ERROR: S has %d rows but T has %d rows. The subspaces must live in the same R^n.\n', size(S, 1), size(T, 1));
        return;
    end

    print_result('Basis matrix S for U:', S);
    print_result('Basis matrix T for V:', T);

    kS = size(S, 2);
    M = [S, -T];
    N = simplify(null(M));

    fprintf('\nWe solve S*a = T*b, equivalently [S -T]*[a; b] = 0.\n');
    print_result('Null space basis for [S -T]:', N);

    if isempty(N)
        fprintf('\nIntersection U ∩ V is the zero subspace {0}.\n');
        print_result('Basis for U ∩ V:', sym(zeros(size(S, 1), 0)));
        print_result('General vector in U ∩ V:', sym(zeros(size(S, 1), 1)));
        return;
    end

    Acoeff = N(1:kS, :);
    intersection_generators = simplify(S * Acoeff);
    intersection_basis = independent_symbolic_columns(intersection_generators);

    if isempty(intersection_basis)
        fprintf('\nIntersection U ∩ V is the zero subspace {0}.\n');
        print_result('Basis for U ∩ V:', sym(zeros(size(S, 1), 0)));
        print_result('General vector in U ∩ V:', sym(zeros(size(S, 1), 1)));
        return;
    end

    print_result('Candidate generators for U ∩ V:', intersection_generators);
    print_result('Basis for U ∩ V:', intersection_basis);
    fprintf('Dimension of U ∩ V: %d\n', size(intersection_basis, 2));

    params = sym('c', [size(intersection_basis, 2), 1]);
    general_vector = simplify(intersection_basis * params);
    print_result('Parameter vector c:', params);
    print_result('General vector in U ∩ V:', general_vector);

    fprintf('Expanded linear combination:\n');
    terms = strings(1, size(intersection_basis, 2));
    for j = 1:size(intersection_basis, 2)
        terms(j) = sprintf('c%d*(%s)', j, matlab_form(intersection_basis(:, j)));
    end
    fprintf('  x = %s\n', strjoin(terms, ' + '));
end

function B_ind = independent_symbolic_columns(B)
    B = simplify(B);
    if isempty(B) || size(B, 2) == 0
        B_ind = sym(zeros(size(B, 1), 0));
        return;
    end

    try
        [~, pivot_cols] = rref(B);
        B_ind = simplify(B(:, pivot_cols));
    catch
        pivot_cols = pivot_columns_numeric(double(B));
        B_ind = simplify(B(:, pivot_cols));
    end
end

function ch3_general_vector_from_basis()
    print_section('Ch 3 — General Vector from Basis Matrix');
    fprintf('The columns of B are treated as basis vectors for a subspace W.\n');
    fprintf('This tool returns the general vector in W as x = c1*v1 + ... + ck*vk.\n\n');

    B = input_matrix('Enter basis matrix B (columns are the basis vectors):');
    B = sym(B);

    [m, k] = size(B);
    print_result('Basis matrix B:', B);

    if k == 0
        fprintf('No basis vectors were entered. The only possible subspace is the zero subspace.\n');
        print_result('General vector in W:', sym(zeros(m, 1)));
        return;
    end

    rankB = rank(B);
    fprintf('Number of columns entered: %d\n', k);
    fprintf('rank(B): %d\n', rankB);

    if rankB < k
        fprintf('\nWarning: the columns are linearly dependent, so this is not technically a basis.\n');
        fprintf('The formula below still describes the span of the columns, but it uses redundant parameters.\n');
    end

    coeffs = sym('c', [k, 1]);
    general_vector = simplify(B * coeffs);

    fprintf('\nGeneral vector form:\n');
    fprintf('  x = B*c, where c = [c1; ...; c%d]\n', k);
    print_result('Parameter vector c:', coeffs);
    print_result('General vector x in W:', general_vector);

    fprintf('Expanded linear combination:\n');
    terms = strings(1, k);
    for j = 1:k
        terms(j) = sprintf('c%d*(%s)', j, matlab_form(B(:, j)));
    end
    fprintf('  x = %s\n', strjoin(terms, ' + '));
end

function ch3_subspace_checker()
    print_section('Ch 3 — Check If a Set Is a Subspace');
    fprintf('Choose how the set is described:\n');
    fprintf('  1. Condition/equation on vector entries, e.g. 5*x1 + 3*x2 - 2*x3 + 3*x4 == 0\n');
    fprintf('  2. General vector form with parameters, e.g. [s; t; s+t]\n');
    mode = strtrim(input('Enter 1 or 2:\n  > ', 's'));

    switch mode
        case '1'
            ch3_subspace_from_conditions();
        case '2'
            ch3_subspace_from_general_form();
        otherwise
            fprintf('Invalid choice.\n');
    end
end

function ch3_subspace_from_conditions()
    vars_str = strtrim(input('Enter vector variables separated by spaces, e.g. x1 x2 x3 x4:\n  > ', 's'));
    if isempty(vars_str)
        fprintf('Need at least one vector variable.\n');
        return;
    end

    eval(['syms ', vars_str]);
    vars = str2sym(strsplit(vars_str));
    vars = vars(:).';

    fprintf('Enter one or more conditions. Use == 0, or enter left-hand side(s) assumed equal to 0.\n');
    fprintf('Examples:\n');
    fprintf('  5*x1 + 3*x2 - 2*x3 + 3*x4 == 0\n');
    fprintf('  x1 + x2 == 0; x3 - x4 == 0\n');
    fprintf('  [x1 + x2 == 0; x3 - x4 == 0]\n');
    conditions_str = strtrim(input('  > ', 's'));
    if isempty(conditions_str)
        fprintf('Need at least one condition.\n');
        return;
    end

    raw_conditions = parse_subspace_conditions_input(conditions_str, vars_str);
    if isempty(raw_conditions)
        return;
    end
    exprs = equations_to_zero_expressions(raw_conditions);
    exprs = exprs(:);

    print_result('Condition(s) rewritten as expression(s) = 0:', exprs);

    [is_linear, is_homogeneous] = check_linear_homogeneous_expressions(exprs, vars);

    fprintf('\nSubspace test:\n');
    fprintf('  Contains zero vector?           %s\n', mat2str(is_homogeneous));
    fprintf('  Defined by linear condition(s)? %s\n', mat2str(is_linear));

    if is_linear && is_homogeneous
        fprintf('\nConclusion: YES, this set is a subspace.\n');
        fprintf('Reason: it is the solution set of a homogeneous linear system.\n');

        Acond = simplify(jacobian(exprs, vars));
        print_result('Matrix form of condition A*x = 0, with A =', Acond);
        Nb = null(Acond);
        if isempty(Nb)
            fprintf('Basis for the subspace: none beyond the zero vector.\n');
            fprintf('Dimension: 0\n');
        else
            print_result('Basis for the subspace Null(A):', Nb);
            fprintf('Dimension: %d\n', size(Nb, 2));
        end
    else
        fprintf('\nConclusion: NO, this set is not guaranteed to be a subspace.\n');
        if ~is_homogeneous
            fprintf('Reason: the zero vector does not satisfy the condition(s).\n');
        elseif ~is_linear
            fprintf('Reason: the condition(s) are not linear homogeneous equations, so closure may fail.\n');
        end
    end
end

function raw_conditions = parse_subspace_conditions_input(conditions_str, vars_str)
    conditions_str = strtrim(conditions_str);
    eval(['syms ', vars_str]);
    try
        if startsWith(conditions_str, '[') && endsWith(conditions_str, ']')
            raw_conditions = eval(conditions_str);
        else
            raw_conditions = eval(['[', conditions_str, ']']);
        end
    catch ME
        fprintf('Could not parse the condition(s). Please use MATLAB syntax.\n');
        fprintf('Examples:\n');
        fprintf('  x1 + x2 == 0; x3 - x4 == 0\n');
        fprintf('  [x1 + x2 == 0; x3 - x4 == 0]\n');
        fprintf('MATLAB said: %s\n', ME.message);
        raw_conditions = [];
    end
end

function ch3_subspace_from_general_form()
    params_str = strtrim(input('Enter parameters separated by spaces, e.g. s t u. Press Enter for none:\n  > ', 's'));
    if ~isempty(params_str)
        eval(['syms ', params_str]);
        params = str2sym(strsplit(params_str));
        params = params(:).';
    else
        params = sym([]);
    end

    fprintf('Enter the general vector form, e.g. [s; t; s+t]\n');
    v = sym(input('  > '));
    v = v(:);

    print_result('General vector form:', v);

    if isempty(params)
        if isAlways(all(v == 0), 'Unknown', 'false')
            fprintf('\nConclusion: YES, this set is the zero subspace {0}.\n');
        else
            fprintf('\nConclusion: NO, a single nonzero vector alone is not a subspace.\n');
        end
        return;
    end

    [is_linear, is_homogeneous] = check_linear_homogeneous_expressions(v, params);

    fprintf('\nSubspace test:\n');
    fprintf('  Zero vector occurs when all parameters are 0? %s\n', mat2str(is_homogeneous));
    fprintf('  Vector form is linear in parameters?          %s\n', mat2str(is_linear));

    if is_linear && is_homogeneous
        B = simplify(jacobian(v, params));
        fprintf('\nConclusion: YES, this set is a subspace.\n');
        fprintf('Reason: the set is the span of the coefficient vectors in the general form.\n');
        print_result('Coefficient matrix B whose columns span the set:', B);

        pivot_cols = pivot_columns_numeric(double(B));
        if isempty(pivot_cols)
            fprintf('Basis for the subspace: none beyond the zero vector.\n');
            fprintf('Dimension: 0\n');
        else
            print_result(sprintf('Basis from independent columns %s of B:', mat2str(pivot_cols)), B(:, pivot_cols));
            fprintf('Dimension: %d\n', numel(pivot_cols));
        end
    else
        fprintf('\nConclusion: NO, this parameterisation is not in standard subspace form.\n');
        if ~is_homogeneous
            fprintf('Reason: setting all parameters to 0 does not give the zero vector.\n');
        elseif ~is_linear
            fprintf('Reason: the vector form is not linear in the parameters, so closure may fail.\n');
        end
    end
end

function exprs = equations_to_zero_expressions(raw_conditions)
    raw_conditions = raw_conditions(:);
    exprs = sym(zeros(size(raw_conditions)));
    for i = 1:numel(raw_conditions)
        try
            exprs(i) = lhs(raw_conditions(i)) - rhs(raw_conditions(i));
        catch
            exprs(i) = raw_conditions(i);
        end
    end
    exprs = simplify(exprs);
end

function [is_linear, is_homogeneous] = check_linear_homogeneous_expressions(exprs, vars)
    zero_subs = num2cell(zeros(size(vars)));
    vals_at_zero = simplify(subs(exprs, vars, zero_subs));
    is_homogeneous = isAlways(all(vals_at_zero == 0), 'Unknown', 'false');

    is_linear = true;
    for i = 1:numel(exprs)
        try
            deg = polynomialDegree(exprs(i), vars);
            if any(double(deg) > 1)
                is_linear = false;
                return;
            end
        catch
            is_linear = false;
            return;
        end
    end
end

function pivot_cols = pivot_columns_numeric(A)
    if isempty(A)
        pivot_cols = [];
        return;
    end

    [~, pivot_cols] = rref(A);
end

function ch3_linear_independence_checker()
    print_section('Ch 3 — Linear Independence Checker');
    fprintf('Enter a matrix whose columns are the vectors in the set.\n');
    A = input_matrix('Enter matrix A (columns = vectors in the set):');

    [m, n] = size(A);
    r = rank(A);

    fprintf('\nNumber of vectors = %d\n', n);
    fprintf('Ambient dimension = %d\n', m);
    fprintf('rank(A)           = %d\n', r);

    if r == n
        fprintf('\nThe vectors are LINEARLY INDEPENDENT.\n');
        return;
    end

    fprintf('\nThe vectors are LINEARLY DEPENDENT.\n');

    [~, pivot_cols] = rref(A);
    redundant_cols = setdiff(1:n, pivot_cols, 'stable');

    if isempty(redundant_cols)
        fprintf('A dependency exists, but no redundant column could be isolated numerically.\n');
        return;
    end

    red_col = redundant_cols(1);
    basis_cols = pivot_cols;
    coeffs = A(:, basis_cols) \ A(:, red_col);
    coeffs = clean_numeric_vector(coeffs);

    fprintf('Pivot columns:      %s\n', mat2str(pivot_cols));
    fprintf('Redundant columns:  %s\n', mat2str(redundant_cols));
    fprintf('\nOne redundant vector is column %d:\n', red_col);
    fprintf('  v%d =\n', red_col);
    print_result('', A(:, red_col));

    fprintf('Expression as a linear combination of pivot vectors:\n');
    fprintf('  v%d = ', red_col);
    print_linear_combination(coeffs, basis_cols);
    fprintf('\n');

    fprintf('\nCoefficient vector relative to pivot columns %s:\n', mat2str(basis_cols));
    print_result('', coeffs);

    reconstruction = A(:, basis_cols) * coeffs;
    err = norm(reconstruction - A(:, red_col));
    fprintf('Verification error: ||combination - v%d|| = %.2e\n', red_col, err);
end

function v = clean_numeric_vector(v)
    tol = 1e-10;
    v(abs(v) < tol) = 0;
    for i = 1:numel(v)
        [num_i, den_i] = rat(v(i), 1e-10);
        if den_i <= 1000 && abs(v(i) - num_i/den_i) < 1e-10
            v(i) = num_i / den_i;
        end
    end
end

function print_linear_combination(coeffs, cols)
    printed = false;
    for i = 1:numel(coeffs)
        c = coeffs(i);
        if abs(c) < 1e-10
            continue;
        end

        if printed
            if c >= 0
                fprintf(' + ');
            else
                fprintf(' - ');
            end
        elseif c < 0
            fprintf('-');
        end

        abs_c = abs(c);
        if abs(abs_c - 1) < 1e-10
            fprintf('v%d', cols(i));
        else
            fprintf('%s*v%d', coefficient_to_text(abs_c), cols(i));
        end
        printed = true;
    end

    if ~printed
        fprintf('0');
    end
end

function txt = coefficient_to_text(c)
    [num_c, den_c] = rat(c, 1e-10);
    if den_c <= 1000 && abs(c - num_c/den_c) < 1e-10
        if den_c == 1
            txt = sprintf('%g', num_c);
        else
            txt = sprintf('%d/%d', num_c, den_c);
        end
    else
        txt = sprintf('%.6g', c);
    end
end

function ch34_four_subspaces()
    print_section('Ch 3–4 — Four Fundamental Subspaces of A');
    A = input_matrix('Enter matrix A:');
    [m, n] = size(A);
    r = rank(A);

    fprintf('\nMatrix A (%d x %d), rank = %d\n\n', m, n, r);

    % Column space — pivot columns of A
    R   = my_rref([A, eye(m)]);
    Ar  = R(:, 1:n);
    pivot_cols = [];
    for row = 1:m
        for col = 1:n
            if abs(Ar(row,col)-1)<1e-10 && all(abs(Ar([1:row-1,row+1:m],col))<1e-10)
                pivot_cols(end+1)=col; break;
            end
        end
    end

    print_section('1. Column Space  Col(A)  — span of pivot columns of A');
    fprintf('Pivot columns: %s\n', mat2str(pivot_cols));
    fprintf('Basis for Col(A):\n');
    print_result('Basis for Col(A):', A(:, pivot_cols));
    fprintf('dim(Col(A)) = rank(A) = %d\n', r);

    print_section('2. Null Space  Null(A)  — solutions to Ax = 0');
    Nb = null(A, 'r');
    if isempty(Nb)
        fprintf('Null(A) = {0}  (trivial, A has full column rank)\n');
    else
        print_result('Basis for Null(A):', Nb);
    end
    fprintf('dim(Null(A)) = nullity = %d  (= n - rank = %d - %d)\n', n-r, n, r);

    print_section('3. Row Space  Row(A)  — Col(A^T)');
    Rb = null(A', 'r');   % row space = null(A')^perp, basis = pivot rows of RREF
    Ra = my_rref(A);
    nonzero_rows = Ra(any(abs(Ra)>1e-10, 2), :);
    print_result('Basis for Row(A)  (nonzero rows of RREF(A)):', nonzero_rows);
    fprintf('dim(Row(A)) = rank(A) = %d\n', r);

    print_section('4. Left Null Space  Null(A^T)  — solutions to A^T x = 0');
    LNb = null(A', 'r');
    if isempty(LNb)
        fprintf('Null(A^T) = {0}  (trivial, A has full row rank)\n');
    else
        print_result('Basis for Null(A^T):', LNb);
    end
    fprintf('dim(Null(A^T)) = %d  (= m - rank = %d - %d)\n', m-r, m, r);

    print_section('Rank–Nullity Summary');
    fprintf('  rank(A) + nullity(A)  = %d + %d = %d  (= n = %d)  ✓\n', r, n-r, n, n);
    fprintf('  rank(A) + nullity(A^T)= %d + %d = %d  (= m = %d)  ✓\n', r, m-r, m, m);
end

function ch34_basis_dimension()
    print_section('Ch 3–4 — Basis and Dimension');
    fprintf('Enter a set of vectors as columns of a matrix.\n');
    A = input_matrix('Enter matrix (each column = one vector):');
    [~, n] = size(A);
    r = rank(A);
    fprintf('\n%d vectors provided, rank = %d\n', n, r);

    if r == n
        fprintf('The vectors are LINEARLY INDEPENDENT — they form a basis for their span.\n');
    else
        fprintf('The vectors are LINEARLY DEPENDENT (%d redundant).\n', n-r);
        fprintf('A basis (maximal independent subset) can be extracted:\n');
    end

    % Extract basis via pivot columns
    R = my_rref(A);
    pivot_cols = [];
    for row = 1:size(R,1)
        for col = 1:n
            if abs(R(row,col)-1)<1e-10 && all(abs(R([1:row-1,row+1:end],col))<1e-10)
                pivot_cols(end+1)=col; break;
            end
        end
    end
    print_result(sprintf('Basis vectors (columns %s of original matrix):', mat2str(pivot_cols)), A(:, pivot_cols));
    fprintf('Dimension of span = %d\n', r);
end

function ch34_rank_nullity()
    print_section('Ch 3–4 — Rank–Nullity Theorem');
    A = input_matrix('Enter matrix A:');
    [m, n] = size(A);
    r = rank(A);
    fprintf('\nA is %d x %d\n', m, n);
    fprintf('rank(A)    = %d\n', r);
    fprintf('nullity(A) = %d\n', n - r);
    fprintf('rank + nullity = %d + %d = %d  (= n = %d)  ✓\n', r, n-r, n, n);
    fprintf('\nIs A injective (one-to-one)?    %s  (nullity = 0?)\n', mat2str(n-r==0));
    fprintf('Is A surjective (onto R^m)?     %s  (rank = m?)\n',    mat2str(r==m));
    fprintf('Is A invertible (square+both)?  %s\n', mat2str(m==n && r==n));
end

% =========================================================================
%% CHAPTER 5
% =========================================================================

function ch5_gram_schmidt()
    print_section('Ch 5 — Gram–Schmidt Orthogonalisation');
    A = input_matrix('Enter linearly independent vectors as columns of a matrix:');
    [~, k] = size(A);
    tol = 1e-10;

    V = zeros(size(A));
    for j = 1:k
        v = A(:,j);
        for i = 1:j-1
            v = v - (dot(V(:,i), A(:,j)) / dot(V(:,i), V(:,i))) * V(:,i);
        end
        if norm(v) < tol
            fprintf('WARNING: vector %d became zero — input vectors may be dependent.\n', j);
        end
        V(:,j) = v;
    end

    print_result('Orthogonal basis {v1, ..., vk}:', V);

    % Orthonormal basis
    Q = V ./ vecnorm(V);
    print_result('Orthonormal basis {u1, ..., uk}  (each column normalized):', Q);

    % Verify
    err = norm(Q'*Q - eye(k), 'fro');
    fprintf('Verification: ||Q^T Q - I|| = %.2e  ✓\n', err);
end

function ch5_projection()
    print_section('Ch 5 — Orthogonal Projection onto a Subspace');
    fprintf('The subspace V is defined by the columns of matrix A.\n');
    A = input_matrix('Enter basis matrix A (columns span V):');
    w = input_vector('Enter vector w to project:');

    Q = orth(A);
    if isempty(Q)
        fprintf('The subspace is {0}, so the projection is the zero vector.\n');
        w_p = zeros(size(w));
    else
        w_p = Q * (Q' * w);
    end
    w_n = w - w_p;

    fprintf('\nProjection of w onto V:\n');
    print_result('  w_p (in V):', w_p);
    print_result('  w_n = w - w_p (orthogonal to V):', w_n);
    fprintf('  Verification: w_n · w_p = %.2e  (should be ≈ 0)\n', dot(w_n, w_p));
    fprintf('  ||w - w_p|| = %.6g  (distance from w to V)\n', norm(w_n));
end

function ch5_general_form_of_orthogonal_projection_onto_subspace()
    print_section('Ch 5 — General Form of Orthogonal Projection onto a Subspace');
    fprintf('The subspace W is defined by the columns of matrix A.\n');
    fprintf('This tool returns the projection matrix P and the general formula proj_W(x) = Px.\n');
    A = input_matrix('Enter basis matrix A (columns span W):');

    [m, ~] = size(A);
    Q = orth(A);
    print_result('Orthonormal basis Q for W = Col(A):', Q);

    if isempty(Q)
        P = zeros(m);
    else
        P = Q * Q';
    end

    P = maybe_simplify(P);
    P = clean_output_value(P);
    print_result('Projection matrix P = QQ^T:', P);

    fprintf('General form: for any vector x in R^%d,\n', m);
    fprintf('  proj_W(x) = P x\n');

    if m <= 6
        syms x [m 1] real
        x = x(:);
        proj_x = maybe_simplify(sym(P) * x);
        fprintf('Using x = [x1; x2; ...; x%d],\n', m);
        print_result('  proj_W(x) =', proj_x);
    end

    err_sym = maybe_simplify(P*P - P);
    print_result('Verification: P^2 - P =', err_sym);
end

function ch5_least_squares()
    print_section('Ch 5 — Least Squares Solution of Ax ≈ b');
    A = input_matrix('Enter matrix A:');
    b = input_vector('Enter vector b:');

    if size(A, 1) ~= length(b)
        fprintf('A has %d rows but b has %d entries, so Ax = b is not defined.\n', size(A, 1), length(b));
        return;
    end

    fprintf('Method used: find the closest vector to b inside Col(A), then solve A*u = projection.\n');
    fprintf('That is: A*(least-squares solution) = proj_Col(A)(b).\n\n');

    Q = orth(A);
    if isempty(Q)
        b_proj = zeros(size(b));
        fprintf('Col(A) is the zero subspace, so the projection of b is the zero vector.\n');
    else
        b_proj = Q * (Q' * b);
    end

    print_result('Projection of b onto Col(A):', b_proj);

    if rank(A) == rank([A, b])
        fprintf('System Ax = b is CONSISTENT, so b is already in Col(A).\n');
    else
        fprintf('System Ax = b is INCONSISTENT, so we solve A*u = proj_Col(A)(b).\n');
    end

    if rank(A) < size(A, 2)
        fprintf('A has dependent columns, so there may be infinitely many least-squares solutions.\n');
        fprintf('Returning the minimum-norm solution from pinv(A)*proj_Col(A)(b).\n');
        u = pinv(A) * b_proj;
    else
        u = A \ b_proj;
    end

    u(abs(u) < 1e-12) = 0;
    print_result('Least squares solution u:', u);
    print_general_least_squares_solution(A, u);

    residual = b - b_proj;
    print_result('Residual b - proj_Col(A)(b):', residual);
    fprintf('||b - A*u|| (minimized distance) = %.6g\n', norm(b - A*u));
    fprintf('Verification ||A*u - proj_Col(A)(b)|| = %.2e\n', norm(A*u - b_proj));
end

function print_general_least_squares_solution(A, u0)
    fprintf('\nGeneral least-squares solution:\n');
    fprintf('All least-squares solutions have the form u = u0 + z, where z is in Null(A).\n');

    try
        N = null(A, 'r');
    catch
        N = null(A);
    end
    N(abs(N) < 1e-12) = 0;

    if isempty(N)
        fprintf('Null(A) = {0}, so the least-squares solution is unique.\n');
        fprintf('  u = %s\n', matlab_form(u0));
        return;
    end

    print_result('Minimum-norm particular solution u0:', u0);
    print_result('Basis for Null(A):', N);

    general_form = sprintf('u = %s', matlab_form(u0));
    for j = 1:size(N, 2)
        print_result(sprintf('  + t%d * n%d, where n%d =', j, j, j), N(:, j));
        general_form = sprintf('%s + t%d*%s', general_form, j, matlab_form(N(:, j)));
    end

    fprintf('Compact general form:\n  %s\n', general_form);
end

function ch5_orthogonal_matrix_check()
    print_section('Ch 5 — Check if Matrix is Orthogonal');
    A = input_matrix('Enter square matrix A:');
    [m, n] = size(A);
    assert(m==n, 'Matrix must be square.');

    tol = 1e-8;
    ATA = A'*A;
    err = norm(ATA - eye(n), 'fro');

    print_result('A^T A =', ATA);
    fprintf('||A^T A - I|| = %.2e\n', err);

    if err < tol
        fprintf('A IS ORTHOGONAL  (A^T A = I, so A^T = A^{-1}).\n');
        fprintf('Columns form an ORTHONORMAL basis for R^%d.\n', n);
        fprintf('det(A) = %.4g  (should be ±1)\n', det(A));
    else
        fprintf('A is NOT orthogonal.\n');
        % Show which columns are not unit length / not orthogonal
        for j = 1:n
            fprintf('  ||col %d|| = %.4g\n', j, norm(A(:,j)));
        end
    end
end

% =========================================================================
%% CHAPTER 6
% =========================================================================

function ch6_polynomial_factorisation()
    print_section('Ch 6 — Characteristic Polynomial Linear Factors');
    fprintf('This is for characteristic polynomials when finding eigenvalues.\n');
    fprintf('It returns a product of linear factors and eigenvalues with multiplicities.\n');
    fprintf('Enter either a symbolic polynomial or a coefficient vector.\n');
    fprintf('Examples:\n');
    fprintf('  lambda^3 - lambda^2 + lambda - 1\n');
    fprintf('  [1 -1 1 -1]   for lambda^3 - lambda^2 + lambda - 1\n\n');

    var_name = strtrim(input('Variable name? Press Enter for lambda:\n  > ', 's'));
    if isempty(var_name)
        var_name = 'lambda';
    end

    eval(['syms ', var_name]);
    x = sym(var_name);

    raw = input('Enter polynomial or coefficient vector:\n  > ');

    if isvector(raw) && numel(raw) > 1
        p = poly2sym(sym(raw), x);
    else
        p = sym(raw);
    end
    p = expand(p);

    print_result(sprintf('Polynomial p(%s):', var_name), p);

    try
        deg = polynomialDegree(p, x);
        fprintf('Degree: %d\n', double(deg));
    catch
        fprintf('Degree: unavailable. Check that the input is a polynomial in %s.\n', var_name);
    end

    try
        deg_val = double(polynomialDegree(p, x));
        exact_roots = solve(p == 0, x, 'MaxDegree', deg_val);
        exact_roots = exact_roots(:);
        if numel(exact_roots) == deg_val && ~contains(char(exact_roots), 'RootOf')
            root_reps = unique_symbolic_values(simplify(exact_roots));
            multiplicities = zeros(numel(root_reps), 1);
            for i = 1:numel(root_reps)
                multiplicities(i) = symbolic_root_multiplicity(p, x, root_reps(i));
            end
            leading_coeff = sym2poly(p);
            leading_coeff = sym(leading_coeff(1));

            fprintf('\n--- Linear Factorisation for Eigenvalues ---\n');
            linear_text = symbolic_linear_factor_product_text(var_name, leading_coeff, root_reps, multiplicities);
            fprintf('p(%s) =\n  %s\n', var_name, linear_text);
            fprintf('MATLAB form:\n  %s\n', linear_text);

            fprintf('\nEigenvalues / roots:\n');
            for i = 1:numel(root_reps)
                fprintf('  %s', char(simplify(root_reps(i))));
                if multiplicities(i) > 1
                    fprintf('    algebraic multiplicity %d', multiplicities(i));
                end
                fprintf('\n');
            end

            fprintf('\nDecimal eigenvalues / roots:\n');
            print_decimal_result('', double(root_reps));
            return;
        end
    catch
        % Fall back to numerical roots below.
    end

    try
        coeffs_exact = sym2poly(p);
        coeffs_double = double(coeffs_exact);
        leading_coeff = coeffs_double(1);
        raw_roots = clean_numeric_roots(roots(coeffs_double), 1e-7);
        [root_reps, multiplicities] = group_roots_with_multiplicity(raw_roots, 1e-7);
        root_reps = clean_numeric_roots(root_reps, 1e-7);

        fprintf('\n--- Linear Factorisation for Eigenvalues ---\n');
        linear_text = linear_factor_product_text(var_name, leading_coeff, root_reps, multiplicities);
        fprintf('p(%s) =\n  %s\n', var_name, linear_text);
        fprintf('MATLAB form:\n  %s\n', linear_text);

        fprintf('\nEigenvalues / roots:\n');
        for i = 1:numel(root_reps)
            fprintf('  %s', char(clean_output_value(root_reps(i))));
            if multiplicities(i) > 1
                fprintf('    algebraic multiplicity %d', multiplicities(i));
            end
            fprintf('\n');
        end

        fprintf('\nDecimal eigenvalues / roots:\n');
        print_decimal_result('', root_reps);
    catch
        fprintf('Linear factorisation unavailable. This usually means the coefficients are not purely numeric.\n');
        factors = factor(p);
        fprintf('\nFallback exact factorisation over the rationals:\n');
        fprintf('  %s\n', factors_to_product_text(factors));
    end
end

function roots_out = clean_numeric_roots(roots_in, tol)
    if nargin < 2
        tol = 1e-10;
    end
    roots_out = roots_in(:);
    real_part = real(roots_out);
    imag_part = imag(roots_out);
    real_part(abs(real_part) < tol) = 0;
    imag_part(abs(imag_part) < tol) = 0;
    roots_out = real_part + 1i*imag_part;
end

function [root_reps, multiplicities] = group_roots_with_multiplicity(root_values, tol)
    used = false(numel(root_values), 1);
    root_reps = [];
    multiplicities = [];

    for i = 1:numel(root_values)
        if used(i)
            continue;
        end

        same = abs(root_values - root_values(i)) < tol;
        used(same) = true;
        root_reps(end+1, 1) = mean(root_values(same)); %#ok<AGROW>
        multiplicities(end+1, 1) = nnz(same); %#ok<AGROW>
    end
end

function txt = symbolic_linear_factor_product_text(var_name, leading_coeff, roots_list, multiplicities)
    pieces = strings(1, numel(roots_list));
    for i = 1:numel(roots_list)
        pieces(i) = symbolic_linear_factor_text(var_name, roots_list(i));
        if multiplicities(i) > 1
            pieces(i) = sprintf('%s^%d', pieces(i), multiplicities(i));
        end
    end

    product_part = char(strjoin(pieces, '*'));
    leading_coeff = simplify(leading_coeff);
    if isAlways(leading_coeff == 1, 'Unknown', 'false')
        txt = product_part;
    elseif isAlways(leading_coeff == -1, 'Unknown', 'false')
        txt = ['-', product_part];
    else
        txt = sprintf('%s*%s', char(leading_coeff), product_part);
    end
end

function txt = symbolic_linear_factor_text(var_name, root_value)
    root_value = simplify(root_value);
    if isAlways(root_value == 0, 'Unknown', 'false')
        txt = sprintf('(%s)', var_name);
    else
        txt = sprintf('(%s - (%s))', var_name, char(root_value));
    end
end

function txt = linear_factor_product_text(var_name, leading_coeff, roots_list, multiplicities)
    pieces = strings(1, numel(roots_list));
    for i = 1:numel(roots_list)
        pieces(i) = linear_factor_text(var_name, roots_list(i));
        if multiplicities(i) > 1
            pieces(i) = sprintf('%s^%d', pieces(i), multiplicities(i));
        end
    end

    product_part = char(strjoin(pieces, '*'));
    leading_sym = clean_output_value(leading_coeff);
    if abs(leading_coeff - 1) < 1e-10
        txt = product_part;
    elseif abs(leading_coeff + 1) < 1e-10
        txt = ['-', product_part];
    else
        txt = sprintf('%s*%s', char(leading_sym), product_part);
    end
end

function txt = linear_factor_text(var_name, root_value)
    root_sym = clean_output_value(root_value);

    if abs(imag(root_value)) < 1e-10
        real_root = real(root_value);
        if real_root < 0
            txt = sprintf('(%s + %s)', var_name, char(clean_output_value(abs(real_root))));
        elseif abs(real_root) < 1e-10
            txt = sprintf('(%s)', var_name);
        else
            txt = sprintf('(%s - %s)', var_name, char(root_sym));
        end
    elseif abs(real(root_value)) < 1e-10
        imag_root = imag(root_value);
        if imag_root < 0
            txt = sprintf('(%s + %si)', var_name, char(clean_output_value(abs(imag_root))));
        else
            txt = sprintf('(%s - %si)', var_name, char(clean_output_value(imag_root)));
        end
    else
        txt = sprintf('(%s - (%s))', var_name, char(root_sym));
    end
end

function txt = factors_to_product_text(factors)
    pieces = strings(1, numel(factors));
    for i = 1:numel(factors)
        pieces(i) = sprintf('(%s)', char(factors(i)));
    end
    txt = char(strjoin(pieces, '*'));
end

function print_factor_multiplicities(factors)
    used = false(size(factors));

    for i = 1:numel(factors)
        if used(i)
            continue;
        end

        current = factors(i);
        mult = 0;
        for j = i:numel(factors)
            if ~used(j) && isAlways(simplify(factors(j) - current) == 0, 'Unknown', 'false')
                used(j) = true;
                mult = mult + 1;
            end
        end

        fprintf('  (%s)', char(current));
        if mult > 1
            fprintf('^%d', mult);
        end
        fprintf('\n');
    end
end

function ch6_eigenanalysis()
    print_section('Ch 6 — Eigenvalues, Eigenvectors & Multiplicities');
    A = input_matrix('Enter square matrix A:');
    n = size(A,1);
    assert(size(A,2)==n, 'Matrix must be square.');

    if ch6_symbolic_eigenanalysis(A)
        return;
    end

    [~, D] = eig(A);
    lambdas = diag(D);

    % Group eigenvalues by value (algebraic multiplicity)
    tol = 1e-8;
    visited = false(n,1);
    total_geom = 0;
    has_complex = false;
    print_result('Matrix A:', A);
    fprintf('\nEigenvalue Summary:\n');

    for k = 1:n
        if visited(k), continue; end
        lam = lambdas(k);
        same = find(abs(lambdas - lam) < tol);
        visited(same) = true;
        alg  = numel(same);
        Nb = eigenspace_basis(A, lam, tol);
        geom = size(Nb,2);
        total_geom = total_geom + geom;
        diagble = (geom == alg);
        has_complex = has_complex || abs(imag(lam)) >= tol;

        lam_str = format_eigenvalue_text(lam, tol);

        fprintf('\n------------------------------------------\n');
        fprintf('Eigenvalue:                 %s\n', lam_str);
        fprintf('Algebraic multiplicity:     %d\n', alg);
        fprintf('Geometric multiplicity:     %d\n', geom);
        fprintf('Enough eigenvectors here?   %s\n', mat2str(diagble));

        fprintf('Eigenspace basis:\n');
        for j = 1:size(Nb,2)
            print_result(sprintf('  v%d =', j), Nb(:,j));
        end

        if isempty(Nb)
            fprintf('  none\n');
        end
    end

    % Overall diagonalizability
    is_diag = (~has_complex) && (total_geom == n);
    fprintf('\n------------------------------------------\n');
    fprintf('Overall diagonalizable over R?  %s\n', mat2str(is_diag));

    if has_complex
        fprintf('Reason: A has complex eigenvalues.\n');
    elseif total_geom < n
        fprintf('Reason: there are not enough linearly independent eigenvectors.\n');
    else
        fprintf('Reason: total number of independent eigenvectors is %d.\n', total_geom);
    end
end

function success = ch6_symbolic_eigenanalysis(A)
    success = false;
    tol = 1e-10;

    try
        A_sym = sym(A, 'r');
        n = size(A_sym, 1);
        syms lambda;
        char_poly = expand(det(lambda*eye(n) - A_sym));
        eigenvalues = solve(char_poly == 0, lambda, 'MaxDegree', n);
        eigenvalues = eigenvalues(:);

        if isempty(eigenvalues)
            return;
        end

        print_result('Matrix A:', A_sym);
        print_result('Characteristic polynomial det(lambda*I - A):', char_poly);
        fprintf('\nEigenvalue Summary:\n');

        total_geom = 0;
        has_complex = false;

        for k = 1:numel(eigenvalues)
            lam = simplify(eigenvalues(k));
            alg = symbolic_root_multiplicity(char_poly, lambda, lam);
            Nb = simplify(null(A_sym - lam*eye(n)));
            geom = size(Nb, 2);
            total_geom = total_geom + geom;
            diagble = (geom == alg);

            has_complex = has_complex || eigenvalue_is_complex(lam);

            fprintf('\n------------------------------------------\n');
            fprintf('Eigenvalue:                 %s\n', char(lam));
            fprintf('Algebraic multiplicity:     %d\n', alg);
            fprintf('Geometric multiplicity:     %d\n', geom);
            fprintf('Enough eigenvectors here?   %s\n', mat2str(diagble));

            fprintf('Eigenspace basis:\n');
            if isempty(Nb)
                fprintf('  none\n');
            else
                for j = 1:size(Nb, 2)
                    v = simplify_symbolic_eigenvector(Nb(:, j));
                    print_result(sprintf('  v%d =', j), v);
                end
            end
        end

        is_diag = (~has_complex) && (total_geom == n);
        fprintf('\n------------------------------------------\n');
        fprintf('Overall diagonalizable over R?  %s\n', mat2str(is_diag));

        if has_complex
            fprintf('Reason: A has complex eigenvalues.\n');
        elseif total_geom < n
            fprintf('Reason: there are not enough linearly independent eigenvectors.\n');
        else
            fprintf('Reason: total number of independent eigenvectors is %d.\n', total_geom);
        end

        success = true;
    catch
        success = false;
    end
end

function mult = symbolic_root_multiplicity(poly_expr, var, root_value)
    mult = 0;
    test_poly = poly_expr;

    while true
        val = simplify(subs(test_poly, var, root_value));
        if ~isAlways(val == 0, 'Unknown', 'false')
            break;
        end

        mult = mult + 1;
        test_poly = simplify(diff(test_poly, var));
        if isAlways(test_poly == 0, 'Unknown', 'false')
            break;
        end
    end
end

function tf = eigenvalue_is_complex(lam)
    lam_imag = simplify(imag(lam));
    tf = ~isAlways(lam_imag == 0, 'Unknown', 'false');
end

function v_out = simplify_symbolic_eigenvector(v)
    v = simplify(v(:));
    nz = find(~isAlways(v == 0, 'Unknown', 'false'), 1, 'last');
    if isempty(nz)
        v_out = v;
        return;
    end

    v_out = simplify(v / v(nz));
    [~, den] = numden(v_out);
    den = den(:);
    scale = sym(1);

    for i = 1:numel(den)
        if ~isAlways(den(i) == 1, 'Unknown', 'false')
            scale = simplify(scale * den(i));
        end
    end

    v_out = simplify(v_out * scale);
end

function txt = format_eigenvalue_text(lam, tol)
    if abs(real(lam)) < tol
        lam = 1i * imag(lam);
    end
    if abs(imag(lam)) < tol
        lam = real(lam);
    end

    txt = char(clean_output_value(lam));
end

function Nb = eigenspace_basis(A, lam, tol)
    B = A - lam*eye(size(A,1));
    B(abs(B) < tol) = 0;
    Nb = null(B, tol);

    if isempty(Nb)
        return;
    end

    if abs(imag(lam)) < tol
        Nb = real(Nb);
        Nb(abs(Nb) < tol) = 0;
        for j = 1:size(Nb,2)
            Nb(:,j) = pedagogical_basis_vector(Nb(:,j), tol);
        end
    else
        Nb(abs(real(Nb)) < tol) = 1i * imag(Nb(abs(real(Nb)) < tol));
        Nb(abs(imag(Nb)) < tol) = real(Nb(abs(imag(Nb)) < tol));
        for j = 1:size(Nb,2)
            Nb(:,j) = pedagogical_complex_basis_vector(Nb(:,j), tol);
        end
    end
end

function v_out = pedagogical_complex_basis_vector(v, tol)
    v = v(:);
    nz = find(abs(v) > tol);

    if isempty(nz)
        v_out = v;
        return;
    end

    pivot_idx = nz(1);
    ratios = v / v(pivot_idx);
    v_out = zeros(size(v));

    for i = 1:numel(ratios)
        re = clean_scalar(real(ratios(i)), tol);
        im = clean_scalar(imag(ratios(i)), tol);
        v_out(i) = re + 1i*im;
    end
end

function x = clean_scalar(x, tol)
    if abs(x) < tol
        x = 0;
        return;
    end

    [num_x, den_x] = rat(x, 1e-8);
    if den_x <= 1000 && abs(x - num_x/den_x) < 1e-8
        x = num_x / den_x;
    end
end

function v_out = pedagogical_basis_vector(v, tol)
    v = real(v(:));
    v(abs(v) < tol) = 0;
    nz = find(abs(v) > tol);

    if isempty(nz)
        v_out = v;
        return;
    end

    [~, rel_idx] = min(abs(v(nz)));
    pivot_idx = nz(rel_idx);
    ratios = v / v(pivot_idx);

    try
        [N, D] = rat(ratios, 1e-8);
    catch
        v_out = v;
        return;
    end

    den_lcm = 1;
    for i = 1:numel(D)
        di = abs(D(i));
        if di == 0
            continue;
        end
        den_lcm = lcm(den_lcm, di);
    end

    ints = N .* (den_lcm ./ D);
    ints = round(ints);
    ints(abs(ints) < tol) = 0;

    nz_ints = ints(abs(ints) > 0);
    if isempty(nz_ints)
        v_out = v;
        return;
    end

    g = abs(nz_ints(1));
    for i = 2:numel(nz_ints)
        g = gcd(g, abs(nz_ints(i)));
    end
    ints = ints / g;

    if max(abs(ints)) > 1e4
        v_out = v;
        return;
    end

    last_nz = find(abs(ints) > 0, 1, 'last');
    if ints(last_nz) < 0
        ints = -ints;
    end

    v_out = ints(:);
end

function [is_diag, P, D] = real_diagonalization_basis(A, tol)
    n = size(A, 1);
    [~, D_num] = eig(A);
    lambdas = diag(D_num);

    P = [];
    D = [];
    d_entries = [];
    visited = false(n, 1);
    is_diag = false;

    for k = 1:n
        if visited(k)
            continue;
        end

        lam = lambdas(k);
        if abs(imag(lam)) >= tol
            return;
        end

        same = find(abs(real(lambdas) - real(lam)) < tol & abs(imag(lambdas)) < tol);
        visited(same) = true;

        Nb = eigenspace_basis(A, real(lam), tol);
        if size(Nb, 2) ~= numel(same)
            return;
        end

        P = [P, Nb]; %#ok<AGROW>
        d_entries = [d_entries; repmat(real(lam), size(Nb, 2), 1)]; %#ok<AGROW>
    end

    if size(P, 2) == n && rank(P) == n
        D = diag(d_entries);
        is_diag = true;
    end
end

function ch6_diagonalize()
    print_section('Ch 6 — Diagonalise A = PDP⁻¹');
    A = input_matrix('Enter square matrix A:');
    tol = 1e-8;

    [is_diag, P, D] = real_diagonalization_basis(A, tol);
    if ~is_diag
        fprintf('A is NOT diagonalizable over R (complex eigenvalues or insufficient eigenvectors).\n');
        return;
    end

    Pinv = P \ eye(size(P));

    fprintf('\nA = P * D * P^{-1}\n\n');
    print_result('P (eigenvectors as columns):', P);
    print_result('D (diagonal eigenvalues):', D);
    print_result('P^{-1}:', Pinv);

    err = norm(P*D*Pinv - A, 'fro');
    fprintf('Verification: ||P*D*P^{-1} - A|| = %.2e  ✓\n', err);
end

function ch6_orthogonal_diagonalize()
    print_section('Ch 6 — Orthogonal Diagonalisation (Symmetric A)');
    A = input_matrix('Enter symmetric matrix A:');
    n = size(A,1);

    if norm(A - A','fro') > 1e-8
        fprintf('WARNING: A is not symmetric. Orthogonal diagonalisation requires A = A^T.\n');
        return;
    end

    [V, D] = eig(A);
    lambdas = diag(D);

    print_result('Eigenvalues (all real for symmetric A):', lambdas');

    % Gram-Schmidt within each eigenspace
    tol = 1e-8;
    Q   = zeros(n);
    col = 1;
    visited = false(n,1);

    for k = 1:n
        if visited(k), continue; end
        lam  = lambdas(k);
        same = find(abs(lambdas - lam) < tol);
        visited(same) = true;

        % Basis for this eigenspace
        Ek = V(:, same);

        % Gram-Schmidt within Ek
        Qk = zeros(size(Ek));
        for j = 1:size(Ek,2)
            v = Ek(:,j);
            for i = 1:j-1
                v = v - dot(Qk(:,i),Ek(:,j))/dot(Qk(:,i),Qk(:,i))*Qk(:,i);
            end
            Qk(:,j) = v / norm(v);
        end
        Q(:, col:col+size(Ek,2)-1) = Qk;
        col = col + size(Ek,2);
    end

    fprintf('\nA = Q * D * Q^T  (Q is orthogonal)\n\n');
    print_result('Q (orthonormal eigenvectors):', Q);
    print_result('D (diagonal eigenvalues):', D);

    err = norm(Q*D*Q' - A, 'fro');
    fprintf('Verification: ||Q*D*Q^T - A|| = %.2e  ✓\n', err);
    fprintf('Orthogonality check: ||Q^T Q - I|| = %.2e  ✓\n', norm(Q'*Q - eye(n),'fro'));
end

function ch6_matrix_power()
    print_section('Ch 6 — Matrix Power Aᵏ via Diagonalisation');
    A = input_matrix('Enter diagonalizable square matrix A:');
    k = input('Enter integer power k: ');
    tol = 1e-8;

    [is_diag, P, D] = real_diagonalization_basis(A, tol);
    if ~is_diag
        fprintf('A may not be diagonalizable over R — using direct computation.\n');
        Ak = A^k;
        print_result(sprintf('A^%d =', k), Ak);
        return;
    end

    Dk = diag(diag(D).^k);
    Ak = P * Dk * (P \ eye(size(P)));
    Ak = real(Ak);   % clean tiny imaginary residuals

    fprintf('\nA^%d = P * D^%d * P^{-1}\n', k, k);
    print_result(sprintf('D^%d (diagonal entries raised to power %d):', k, k), Dk);
    print_result(sprintf('A^%d =', k), Ak);

    % Verify for small k
    if abs(k) <= 10
        err = norm(Ak - double(A^k), 'fro');
        fprintf('Verification: ||A^%d (formula) - A^%d (direct)|| = %.2e  ✓\n', k, k, err);
    end
end

function ch6_markov()
    print_section('Ch 6 — Markov Chain: Steady-State Vector');
    fprintf('Enter a stochastic matrix P (columns must sum to 1).\n');
    P = input_matrix('Enter stochastic matrix P:');
    n = size(P,1);
    tol = 1e-8;

    % Check stochastic
    col_sums = sum(P, 1);
    if any(abs(col_sums - 1) > 1e-6)
        fprintf('WARNING: Column sums: %s — not all 1. Matrix may not be stochastic.\n', ...
                mat2str(double(col_sums), 4));
    end

    steady_basis = null(P - eye(n), tol);
    if isempty(steady_basis)
        fprintf('No eigenvalue lambda = 1 found.\n'); return;
    end

    if size(steady_basis, 2) > 1
        fprintf('\nThere are infinitely many steady-state vectors.\n');
        print_decimal_result('Basis for solutions of (P - I)q = 0:', steady_basis);
        fprintf('A valid steady-state probability vector must be a linear combination with entries >= 0 and sum = 1.\n');
        return;
    end

    q = real(steady_basis(:, 1));
    if abs(sum(q)) < tol
        fprintf('A lambda = 1 eigenvector was found, but it cannot be normalized to sum 1.\n');
        return;
    end
    q = q / sum(q);   % normalise to probability vector
    q(abs(q) < tol) = 0;

    print_decimal_result('Steady-state (equilibrium) vector q (Pq = q):', q);
    fprintf('Sum of entries = %.6g  (should be 1)\n', sum(q));

    err = norm(P*q - q, 'inf');
    fprintf('Verification: ||Pq - q||_inf = %.2e  ✓\n', err);

    % Long-run simulation
    x0 = input_vector('Enter initial probability vector x0 (or press Enter to skip):');
    if ~isempty(x0) && abs(sum(x0) - 1) < 1e-6
        steps = 30;
        x = x0(:);
        for i = 1:steps, x = P*x; end
        print_decimal_result(sprintf('After %d steps starting from x0:', steps), x);
        fprintf('Distance to equilibrium: %.2e\n', norm(x - q));
    end
end

function print_decimal_result(label, value)
    fprintf('%s\n', label);
    value = double(value);
    value(abs(value) < 1e-12) = 0;
    disp(value);
    fprintf('MATLAB form:\n  %s\n', mat2str(value, 12));
end

function tf = ask_yes_no(prompt)
    answer = strtrim(input(prompt, 's'));
    tf = strcmp(answer, '1') || any(strcmpi(answer, {'y', 'yes'}));
end

% =========================================================================
%% CHAPTER 7
% =========================================================================

function ch7_ode_solver()
    print_section('Ch 7 — Solve y''(t) = A*y(t)');
    syms t lambda;
    A = input_matrix('Enter coefficient matrix A (real, square):');
    n = size(A,1);
    assert(isreal(A), 'A must have real entries.');
    assert(size(A,2)==n, 'A must be square.');

    has_ic = input('Solve an IVP? (1 = yes, 0 = no): ');
    if has_ic
        t0 = input('Enter t0: ');
        y0 = input_vector('Enter initial condition y0:');
    end
    show_phi = ask_yes_no('Show full matrix exponential Phi(t)? (1 = yes, 0 = no): ');

    modes = print_ode_solution_modes(A, false);

    % IVP
    if has_ic
        x_part = print_ode_ivp_solution_from_modes(modes, t0, y0, false);

        % Plot
        t_span = linspace(t0, t0+5, 500);
        Y = zeros(n, numel(t_span));
        for idx = 1:numel(t_span)
            Y(:,idx) = real(double(subs(x_part, t, t_span(idx))));
        end
        figure('Name','MA1508E Ch7 IVP Solution','NumberTitle','off');
        hold on; colors = lines(n);
        for i = 1:n
            plot(t_span, Y(i,:), 'LineWidth', 2, 'Color', colors(i,:), ...
                 'DisplayName', sprintf('y_%d(t)', i));
        end
        hold off;
        xlabel('t'); ylabel('y_i(t)');
        title(sprintf('IVP: y''=Ay, y(%g)=y_0', t0));
        legend('Location','best'); grid on;
    end

    if show_phi
        fprintf('\n--- Matrix Exponential Reference ---\n');
        fprintf('Computing fundamental matrix Phi(t) = exp(A*t)...\n');
        Phi = simplify(expm(sym(A)*t));

        print_result('Fundamental matrix Phi(t) = exp(A*t):', Phi);
    end
end

function ch7_higher_order_ode_solver()
    print_section('Ch 7 — Higher-Order Linear ODE');
    syms t lambda;

    fprintf('This solves homogeneous constant-coefficient ODEs:\n');
    fprintf('  a_n*y^(n) + a_{n-1}*y^(n-1) + ... + a_1*y'' + a_0*y = 0\n');
    fprintf('Enter coefficients in descending derivative order.\n');
    coeffs = input('Example [1 3 2] means y'''' + 3y'' + 2y = 0:\n  > ');
    coeffs = coeffs(:).';

    if numel(coeffs) < 2
        fprintf('Need at least two coefficients.\n');
        return;
    end
    if abs(coeffs(1)) < 1e-12
        fprintf('Leading coefficient cannot be zero.\n');
        return;
    end

    coeffs = coeffs / coeffs(1);
    n = numel(coeffs) - 1;

    A = zeros(n);
    if n > 1
        A(1:n-1, 2:n) = eye(n-1);
    end
    A(n, :) = -fliplr(coeffs(2:end));

    fprintf('\nUsing state vector x = [y; y''; ...; y^(n-1)].\n');
    fprintf('Then x'' = A*x, where:\n');
    print_result('Companion matrix A:', A);

    char_coeffs = sym(coeffs, 'r');
    print_result('Characteristic polynomial coefficients:', char_coeffs);
    char_poly = poly2sym(char_coeffs, lambda);
    print_result('Characteristic roots:', solve(char_poly == 0, lambda).');

    modes = print_ode_solution_modes(A, true);

    show_phi = ask_yes_no('Show full companion-system Phi(t)? (1 = yes, 0 = no): ');
    if show_phi
        fprintf('\n--- Matrix Exponential Reference ---\n');
        fprintf('Computing fundamental matrix Phi(t) = exp(A*t)...\n');
        Phi = simplify(expm(sym(A)*t));

        print_result('Fundamental matrix Phi(t) = exp(A*t):', Phi);
    end

    has_ic = input('Solve an IVP? (1 = yes, 0 = no): ');
    if has_ic
        t0 = input('Enter t0: ');
        fprintf('Enter initial state [y(t0); y''(t0); ...; y^(n-1)(t0)].\n');
        y0 = input_vector('Initial state:');
        if length(y0) ~= n
            fprintf('Expected %d initial values, but received %d.\n', n, length(y0));
            return;
        end

        x_part = print_ode_ivp_solution_from_modes(modes, t0, y0, true);
        y_part = simplify(x_part(1));

        t_span = linspace(t0, t0+5, 500);
        y_vals = zeros(1, numel(t_span));
        for idx = 1:numel(t_span)
            y_vals(idx) = real(double(subs(y_part, t, t_span(idx))));
        end
        figure('Name','MA1508E Ch7 Higher-Order ODE Solution','NumberTitle','off');
        plot(t_span, y_vals, 'LineWidth', 2);
        xlabel('t'); ylabel('y(t)');
        title(sprintf('Higher-order IVP solution, t_0 = %g', t0));
        grid on;
    end
end

function all_real_modes = print_ode_solution_modes(A, include_scalar_y)
    try
        [all_real_modes, ok] = print_ode_solution_modes_symbolic(A, include_scalar_y);
        if ok
            return;
        end
    catch
        % Fall back to numerical modes below if symbolic mode construction fails.
    end

    all_real_modes = print_ode_solution_modes_numeric(A, include_scalar_y);
end

function [all_real_modes, ok] = print_ode_solution_modes_symbolic(A, include_scalar_y)
    syms t lambda;
    ok = false;
    A_sym = sym(A, 'r');
    n = size(A_sym, 1);

    char_poly = expand(det(lambda*eye(n) - A_sym));
    eigenvalues = solve(char_poly == 0, lambda, 'MaxDegree', n);
    eigenvalues = eigenvalues(:);

    if isempty(eigenvalues)
        all_real_modes = sym([]);
        return;
    end

    fprintf('\n--- Eigenvalue Solution Modes ---\n');
    fprintf('Use this section for exam questions that ask whether listed functions are solutions.\n');

    real_lambdas = sym([]);
    complex_lambdas = sym([]);
    for k = 1:numel(eigenvalues)
        lam = simplify(eigenvalues(k));
        im_val = double(vpa(imag(lam)));
        if abs(im_val) < 1e-10
            real_lambdas(end+1, 1) = simplify(real(lam)); %#ok<AGROW>
        elseif im_val > 0
            complex_lambdas(end+1, 1) = lam; %#ok<AGROW>
        end
    end

    if ~isempty(real_lambdas)
        [~, order] = sort(double(vpa(real_lambdas)), 'descend');
        real_lambdas = real_lambdas(order);
        real_lambdas = unique_symbolic_values(real_lambdas);
    end

    real_modes = sym([]);
    complex_real_modes = sym([]);
    mode_no = 1;

    for k = 1:numel(real_lambdas)
        lam = simplify(real_lambdas(k));
        M = A_sym - lam*eye(n);
        alg = symbolic_root_multiplicity(char_poly, lambda, lam);
        Nb = simplify(null(M));
        if isempty(Nb)
            continue;
        end

        fprintf('\nReal eigenvalue mode(s): lambda = %s\n', char(lam));
        geom = size(Nb, 2);
        if alg > geom
            fprintf('  repeated eigenvalue: algebraic multiplicity %d, geometric multiplicity %d\n', alg, geom);
            fprintf('  generalized eigenvector mode(s) are needed.\n');
        end

        for j = 1:size(Nb, 2)
            v = simplify_symbolic_eigenvector(Nb(:, j));
            sol = simplify(exp(lam*t) * v);
            print_ode_result(sprintf('Eigenvector v_%d:', mode_no), v);
            fprintf('Factored mode form:\n  r_%d(t) = exp((%s)*t) * v_%d\n', mode_no, char(lam), mode_no);
            print_ode_result(sprintf('Solution r_%d(t) = exp(lambda*t)*v:', mode_no), sol);
            real_modes(:, end+1) = sol; %#ok<AGROW>

            if include_scalar_y
                print_ode_result(sprintf('Scalar solution y_%d(t):', mode_no), sol(1));
            end

            mode_no = mode_no + 1;
        end

        missing_modes = alg - geom;
        for j = 1:missing_modes
            v = simplify_symbolic_eigenvector(Nb(:, min(j, size(Nb, 2))));
            w = solve_generalized_eigenvector(M, v);
            sol = simplify(exp(lam*t) * (t*v + w));

            print_ode_result(sprintf('Generalized eigenvector w_%d satisfying (A - lambda I)w_%d = v:', mode_no, mode_no), w);
            fprintf('Factored generalized mode form:\n');
            fprintf('  r_%d(t) = exp((%s)*t) * (t*v + w_%d)\n', mode_no, char(lam), mode_no);
            print_ode_result(sprintf('Solution r_%d(t):', mode_no), sol);
            real_modes(:, end+1) = sol; %#ok<AGROW>

            if include_scalar_y
                print_ode_result(sprintf('Scalar solution y_%d(t):', mode_no), sol(1));
            end

            mode_no = mode_no + 1;
        end
    end

    if ~isempty(complex_lambdas)
        fprintf('\nComplex eigenvalue mode(s):\n');
        fprintf('For z(t) = exp(lambda*t)*v, both Re(z(t)) and Im(z(t)) are real solutions.\n');
    end

    for k = 1:numel(complex_lambdas)
        lam = simplify(complex_lambdas(k));
        Nb = simplify(null(A_sym - lam*eye(n)));
        if isempty(Nb)
            continue;
        end

        alpha = simplify(real(lam));
        beta = simplify(imag(lam));

        fprintf('\nComplex pair:\n');
        fprintf('  lambda = %s, conjugate lambda = %s\n', char(lam), char(conj(lam)));

        for j = 1:size(Nb, 2)
            v = normalize_symbolic_complex_ode_vector(Nb(:, j));
            a = simplify(real(v));
            b = simplify(imag(v));

            z = simplify(exp(lam*t) * v);
            real_sol = expand(exp(alpha*t) * (a*cos(beta*t) - b*sin(beta*t)));
            imag_sol = expand(exp(alpha*t) * (a*sin(beta*t) + b*cos(beta*t)));

            print_ode_result(sprintf('Complex eigenvector v_%d:', mode_no), v);
            fprintf('Factored complex mode form:\n  z_%d(t) = exp((%s)*t) * v_%d\n', mode_no, char(lam), mode_no);
            print_ode_result(sprintf('Complex solution z_%d(t) = exp(lambda*t)*v:', mode_no), z);
            print_ode_result(sprintf('Real solution %dA = Re(z_%d(t)):', mode_no, mode_no), real_sol);
            print_ode_result(sprintf('Real solution %dB = Im(z_%d(t)):', mode_no, mode_no), imag_sol);
            complex_real_modes(:, end+1) = real_sol; %#ok<AGROW>
            complex_real_modes(:, end+1) = imag_sol; %#ok<AGROW>

            if include_scalar_y
                print_ode_result(sprintf('Scalar complex solution y_%d(t):', mode_no), z(1));
                print_ode_result(sprintf('Scalar real solution %dA:', mode_no), real_sol(1));
                print_ode_result(sprintf('Scalar real solution %dB:', mode_no), imag_sol(1));
            end

            mode_no = mode_no + 1;
        end
    end

    all_real_modes = [real_modes, complex_real_modes];
    print_real_general_solution_from_modes(all_real_modes, include_scalar_y);
    ok = ~isempty(all_real_modes);
end

function all_real_modes = print_ode_solution_modes_numeric(A, include_scalar_y)
    syms t;
    tol = 1e-8;
    [~, D] = eig(A);
    lambdas = diag(D);
    real_lambdas = lambdas(abs(imag(lambdas)) <= tol);
    real_lambdas = sort(real(real_lambdas), 'descend');
    complex_lambdas = lambdas(imag(lambdas) > tol);

    fprintf('\n--- Eigenvalue Solution Modes ---\n');
    fprintf('Use this section for exam questions that ask whether listed functions are solutions.\n');

    real_modes = sym([]);
    complex_real_modes = sym([]);
    mode_no = 1;

    visited_real = false(numel(real_lambdas), 1);
    for k = 1:numel(real_lambdas)
        if visited_real(k)
            continue;
        end

        lam = real_lambdas(k);
        same = abs(real_lambdas - lam) < tol;
        visited_real(same) = true;

        lam_num = real(lam);
        if abs(lam_num) < tol
            lam_num = 0;
        end

        Nb = eigenspace_basis(A, lam_num, tol);
        if isempty(Nb)
            continue;
        end

        fprintf('\nReal eigenvalue mode(s): lambda = %s\n', char(clean_output_value(lam_num)));
        for j = 1:size(Nb, 2)
            v = pedagogical_basis_vector(Nb(:, j), tol);
            v_sym = sym(v, 'r');
            sol = expand(exp(sym(lam_num, 'r')*t) * v_sym);
            print_ode_result(sprintf('Solution r_%d(t) = exp(lambda*t)*v:', mode_no), sol);
            real_modes(:, end+1) = sol; %#ok<AGROW>

            if include_scalar_y
                print_ode_result(sprintf('Scalar solution y_%d(t):', mode_no), sol(1));
            end

            mode_no = mode_no + 1;
        end
    end

    if ~isempty(complex_lambdas)
        fprintf('\nComplex eigenvalue mode(s):\n');
        fprintf('For z(t) = exp(lambda*t)*v, both Re(z(t)) and Im(z(t)) are real solutions.\n');
    end

    visited = false(numel(complex_lambdas), 1);

    for k = 1:numel(complex_lambdas)
        if visited(k)
            continue;
        end

        lam = complex_lambdas(k);
        same = abs(complex_lambdas - lam) < tol;
        visited(same) = true;

        Nb = eigenspace_basis(A, lam, tol);
        if isempty(Nb)
            continue;
        end

        alpha_num = real(lam);
        beta_num = imag(lam);
        if abs(alpha_num) < tol
            alpha_num = 0;
        end
        if abs(beta_num) < tol
            beta_num = 0;
        end

        alpha = sym(alpha_num, 'r');
        beta = sym(beta_num, 'r');
        lam_clean = alpha_num + 1i*beta_num;

        fprintf('\nComplex pair:\n');
        fprintf('  lambda = %s, conjugate lambda = %s\n', ...
            char(clean_output_value(lam_clean)), char(clean_output_value(conj(lam_clean))));

        for j = 1:size(Nb, 2)
            v = normalize_complex_ode_vector(Nb(:, j), tol);
            v(abs(real(v)) < tol) = 1i * imag(v(abs(real(v)) < tol));
            v(abs(imag(v)) < tol) = real(v(abs(imag(v)) < tol));
            a = sym(real(v), 'r');
            b = sym(imag(v), 'r');
            v_sym = a + 1i*b;

            z = simplify(exp((alpha + 1i*beta)*t) * v_sym);
            real_sol = expand(exp(alpha*t) * (a*cos(beta*t) - b*sin(beta*t)));
            imag_sol = expand(exp(alpha*t) * (a*sin(beta*t) + b*cos(beta*t)));

            print_ode_result(sprintf('Complex solution z_%d(t) = exp(lambda*t)*v:', mode_no), z);
            print_ode_result(sprintf('Real solution %dA = Re(z_%d(t)):', mode_no, mode_no), real_sol);
            print_ode_result(sprintf('Real solution %dB = Im(z_%d(t)):', mode_no, mode_no), imag_sol);
            complex_real_modes(:, end+1) = real_sol; %#ok<AGROW>
            complex_real_modes(:, end+1) = imag_sol; %#ok<AGROW>

            if include_scalar_y
                print_ode_result(sprintf('Scalar complex solution y_%d(t):', mode_no), z(1));
                print_ode_result(sprintf('Scalar real solution %dA:', mode_no), real_sol(1));
                print_ode_result(sprintf('Scalar real solution %dB:', mode_no), imag_sol(1));
            end

            mode_no = mode_no + 1;
        end
    end

    all_real_modes = [real_modes, complex_real_modes];
    print_real_general_solution_from_modes(all_real_modes, include_scalar_y);
end

function print_real_general_solution_from_modes(all_real_modes, include_scalar_y)
    if isempty(all_real_modes)
        return;
    end

    fprintf('\n--- Real General Solution ---\n');
    fprintf('The real general solution is a linear combination of these modes:\n');
    for j = 1:size(all_real_modes, 2)
        print_ode_result(sprintf('  k%d * mode%d(t), where mode%d(t) =', j, j, j), all_real_modes(:, j));
    end

    fprintf('Compact form:\n');
    terms = strings(1, size(all_real_modes, 2));
    for j = 1:size(all_real_modes, 2)
        terms(j) = sprintf('k%d*(%s)', j, char(all_real_modes(:, j)));
    end
    fprintf('  x(t) = %s\n', strjoin(terms, ' + '));

    if include_scalar_y
        scalar_terms = strings(1, size(all_real_modes, 2));
        for j = 1:size(all_real_modes, 2)
            scalar_terms(j) = sprintf('k%d*(%s)', j, char(all_real_modes(1, j)));
        end
        fprintf('  y(t) = %s\n', strjoin(scalar_terms, ' + '));
    end
end

function vals_out = unique_symbolic_values(vals)
    vals_out = sym([]);
    for i = 1:numel(vals)
        current = simplify(vals(i));
        seen = false;
        for j = 1:numel(vals_out)
            if isAlways(simplify(current - vals_out(j)) == 0, 'Unknown', 'false')
                seen = true;
                break;
            end
        end
        if ~seen
            vals_out(end+1, 1) = current; %#ok<AGROW>
        end
    end
end

function w = solve_generalized_eigenvector(M, v)
    warning_state = warning('off', 'all');
    cleanup = onCleanup(@() warning(warning_state));
    w0 = simplify(M \ v);
    w = simplify(make_generalized_vector_pedagogical(w0, v));
end

function w_best = make_generalized_vector_pedagogical(w0, v)
    w_best = simplify(w0);
    best_score = generalized_vector_score(w_best);

    for i = 1:numel(v)
        if isAlways(v(i) == 0, 'Unknown', 'false')
            continue;
        end

        candidate = simplify(w0 - (w0(i) / v(i)) * v);
        score = generalized_vector_score(candidate);
        if score < best_score
            w_best = candidate;
            best_score = score;
        end
    end
end

function score = generalized_vector_score(v)
    score = 0;
    for i = 1:numel(v)
        if isAlways(v(i) == 0, 'Unknown', 'false')
            continue;
        end
        score = score + 1 + strlength(char(v(i))) / 100;
    end
end

function x_part = print_ode_ivp_solution_from_modes(modes, t0, y0, include_scalar_y)
    syms t;
    fprintf('\n--- Initial Value Problem ---\n');
    fprintf('Substitute t = %s into the real general solution and solve for the constants.\n', char(clean_output_value(t0)));

    M0 = simplify(subs(modes, t, t0));
    constants = simplify(M0 \ sym(y0));
    x_part = simplify(expand(modes * constants));

    print_result('Mode matrix at the initial time:', M0);
    print_result('Initial vector y0:', y0);
    print_result('Constants k:', constants);
    fprintf('Particular solution by substituting constants into the general solution:\n');
    fprintf('  x(t) = %s\n', mode_combination_text(modes, constants));
    print_ode_result('Particular solution x(t):', x_part);

    if include_scalar_y
        fprintf('  y(t) = %s\n', mode_combination_text(modes(1, :), constants));
        print_ode_result('Particular scalar solution y(t):', x_part(1));
    end
end

function txt = mode_combination_text(modes, constants)
    terms = strings(1, numel(constants));
    for j = 1:numel(constants)
        terms(j) = sprintf('(%s)*(%s)', char(constants(j)), char(modes(:, j)));
    end
    txt = char(strjoin(terms, ' + '));
end

function print_ode_result(label, value)
    fprintf('%s\n', label);
    disp(value);
    fprintf('MATLAB form:\n  %s\n', char(value));
end

function v_out = normalize_symbolic_complex_ode_vector(v)
    v = simplify(v(:));
    v_out = v;

    for i = 1:numel(v)
        if isAlways(real(v(i)) == 0, 'Unknown', 'false') && ...
           ~isAlways(imag(v(i)) == 0, 'Unknown', 'false')
            v_out = simplify(v / v(i));
            return;
        end
    end

    for i = 1:numel(v)
        if isAlways(imag(v(i)) == 0, 'Unknown', 'false') && ...
           ~isAlways(real(v(i)) == 0, 'Unknown', 'false')
            v_out = simplify(v / v(i));
            if isAlways(real(v_out(i)) < 0, 'Unknown', 'false')
                v_out = -v_out;
            end
            return;
        end
    end
end

function v_out = normalize_complex_ode_vector(v, tol)
    v = v(:);
    v_out = v;

    pure_imag_idx = find(abs(real(v)) < tol & abs(imag(v)) > tol, 1);
    if ~isempty(pure_imag_idx)
        v_out = v / v(pure_imag_idx);
        return;
    end

    pure_real_idx = find(abs(imag(v)) < tol & abs(real(v)) > tol, 1);
    if ~isempty(pure_real_idx)
        v_out = v / v(pure_real_idx);
        if real(v_out(pure_real_idx)) < 0
            v_out = -v_out;
        end
    end
end
