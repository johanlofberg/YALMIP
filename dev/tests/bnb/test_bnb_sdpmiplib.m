function tests = test_bnb_sdpmiplib
tests = functiontests(localfunctions);

function test_bma(testCase)
[F,h] = loadsdpafile('bma2_10.dat-s');
sol = optimize(F,h,sdpsettings('solver','bnb','savesolveroutput',1));
testCase.assertTrue(sol.problem == 0);
testCase.assertTrue(abs(value(h) - 973) <= 1e-2);
if strcmpi(sol.solveroutput.localsolver,'mosek')
    testCase.assertTrue(sol.solveroutput.solved_nodes <= 101);
end

function test_map(testCase)
[F,h] = loadsdpafile('map2_10.dat-s');
sol = optimize(F,h,sdpsettings('solver','bnb','savesolveroutput',1));
testCase.assertTrue(sol.problem == 0);
testCase.assertTrue(abs(value(h) - 1023) <= 1e-2);
if strcmpi(sol.solveroutput.localsolver,'mosek')
    testCase.assertTrue(sol.solveroutput.solved_nodes <= 129);
end

function test_ml(testCase)
[F,h] = loadsdpafile('ml2_10.dat-s');
sol = optimize(F,h,sdpsettings('solver','bnb','savesolveroutput',1));
testCase.assertTrue(sol.problem == 0);
testCase.assertTrue(abs(value(h) - 886) <= 1e-2);
if strcmpi(sol.solveroutput.localsolver,'mosek')
    testCase.assertTrue(sol.solveroutput.solved_nodes <= 93);
end

function test_diw(testCase)
[F,h] = loadsdpafile('diw_15.dat-s');
sol = optimize(F,h,sdpsettings('solver','bnb','savesolveroutput',1));
testCase.assertTrue(sol.problem == 0);
testCase.assertTrue(abs(value(h) - -95) <= 1e-2);
if strcmpi(sol.solveroutput.localsolver,'mosek')
    testCase.assertTrue(sol.solveroutput.solved_nodes <= 21);
end

[F,h] = loadsdpafile('diw_37.dat-s');
sol = optimize(F,h,sdpsettings('solver','bnb','savesolveroutput',1,'sedumi.free',0));
testCase.assertTrue(sol.problem == 0);
testCase.assertTrue(abs(value(h) - -211) <= 1e-2);
if strcmpi(sol.solveroutput.localsolver,'mosek')
    testCase.assertTrue(sol.solveroutput.solved_nodes <= 27);
end


function test_colon(testCase)
[F,h] = loadsdpafile('coloncancer_1_100_5.dat-s')
sol = optimize(F,h,sdpsettings('solver','bnb','savesolveroutput',1));
testCase.assertTrue(sol.problem == 0);
testCase.assertTrue(abs(value(h) - 127.47) <= 1e-2);
if strcmpi(sol.solveroutput.localsolver,'mosek')
    testCase.assertTrue(sol.solveroutput.solved_nodes <= 53);
end

function test_random(testCase)
[F,h] = loadsdpafile('random_64_2_a.dat-s')
sol = optimize(F,h,sdpsettings('solver','bnb','savesolveroutput',1));
testCase.assertTrue(sol.problem == 0);
testCase.assertTrue(abs(value(h) - 11.56) <= 1e-2);
if strcmpi(sol.solveroutput.localsolver,'mosek')
    testCase.assertTrue(sol.solveroutput.solved_nodes <= 17);
end

function test_clique(testCase)
[F,h] = loadsdpafile('clique_20_k3_6_7.dat-s')
sol = optimize(F,h,sdpsettings('solver','bnb','savesolveroutput',1));
testCase.assertTrue(sol.problem == 0);
testCase.assertTrue(abs(value(h) - 147) <= 1e-2);
if strcmpi(sol.solveroutput.localsolver,'mosek')
    testCase.assertTrue(sol.solveroutput.solved_nodes <= 4);
end

function test_bar(testCase)
[F,h] = loadsdpafile('2x3_3bars.dat-s')
sol = optimize(F,h,sdpsettings('solver','bnb','savesolveroutput',1));
testCase.assertTrue(sol.problem == 0);
testCase.assertTrue(abs(value(h) - 2.118) <= 1e-2);
if strcmpi(sol.solveroutput.localsolver,'mosek')
    testCase.assertTrue(sol.solveroutput.solved_nodes <= 51);
end