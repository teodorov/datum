# The Datum Language Semantics as CESK machine

## Rules

```scheme
symbol_lookup ≜ 
    ⟨ symbol, ρ, σ, κ ⟩ ⟶ ⟨ σ[ρ[symbol]], ρ, σ, κ ⟩

quote ≜
    ⟨ (quote e), ρ, σ, κ ⟩ ⟶ ⟨ e, ρ, σ, κ ⟩

lambda ≜
    ⟨ (lambda e), ρ, σ, κ ⟩ ⟶ ⟨ (Closure e ρ), ρ, σ, κ ⟩

if ≜
    ⟨ (if ce e₁ e₂), ρ, σ, κ ⟩ ⟶ ⟨ ce, ρ, σ, (IfFrame e₁ e₂ κ) ⟩

if_true ≜
    ⟨ v, ρ, σ, (IfFrame e₁ e₂ κ) ⟩ ⟶ ⟨ e₁, ρ, σ, κ ⟩
        where (is-value? v) ∧ v ≠ #f
    
    ⟨ #f, ρ, σ, (IfFrame e₁ e₂ κ) ⟩ ⟶ ⟨ e₂, ρ, σ, κ ⟩

set! ≜
    ⟨ (set! s e), ρ, σ, κ ⟩ ⟶ ⟨ e, ρ, σ, (SetFrame ρ[s] κ) ⟩
        where s ∈ Symbol ∧ ρ[s] ≠ ⊥

    ⟨ v, ρ, σ, (SetFrame a κ) ⟩ ⟶ ⟨ null, ρ, σ[a ↦ v], κ ⟩

begin ≜ 
    ⟨ (begin e₁ e₂), ρ, σ, κ ⟩ ⟶ ⟨ e₁, ρ, σ, (SequenceFrame e₂ κ) ⟩

    ⟨ v, ρ, σ, (SequenceFrame () κ) ⟩ ⟶ ⟨ v, ρ, σ, κ ⟩
    
    ⟨ v, ρ, σ, (SequenceFrame (e₁ e₂) κ) ⟩ ⟶ ⟨ e₁, ρ, σ, (SequenceFrame e₂ κ) ⟩

application ≜ 
    ⟨ (e₁ e₂), ρ, σ, κ ⟩ ⟶ ⟨ e₁, ρ, σ, (ApplicationFrame null () e₂ ρ #f κ) ⟩
        where !primitiveForm(e₁) 

    ⟨ (closure (() b) ρ'), ρ, σ, (ArgumentsFrame () () κ) ⟩ ⟶ ⟨ b, ρ', σ, (CallFrame ρ κ) ⟩

    ⟨ v, ρ, σ, (ArgumentsFrame () (e₁ e₂) κ) ⟩ ⟶ ⟨ e₁, ρ, σ, (ArgumentsFrame () e₂ (CallFrame v ρ κ) ⟩
        where v = (closure _)

    ⟨ v, ρ, σ, (ArgumentsFrame vᵢ (e₁ e₂) κ) ⟩ ⟶ ⟨ e₁, ρ, σ, (ArgumentsFrame (append vᵢ v) e₂ κ) ⟩

    ⟨ v, ρ, σ, (ArgumentsFrame vᵢ () κ) ⟩ ⟶ ⟨ e₁, ρ, σ, (ArgumentsFrame (append vᵢ v) e₂ κ) ⟩
        

    ⟨ v, ρ', σ, (CallFrame c ρ κ) ⟩ ⟶ ⟨ v, ρ, σ, κ ⟩

```

[//]: <> ( ⟨ e, ρ, σ, κ ⟩ ⟶ ⟨ e', ρ', σ', κ' ⟩ )

### Define form

```clojure
define_symbol ≜ 
    ⟨ (define symbol e), ρ, σ, κ ⟩  ⟶  ⟨ e, ρ, σ, DefFrame(symbol, κ) ⟩
        where symbol ∈ Symbol

define_function ≜ 
    ⟨ (define (symbol args) body), ρ, σ, κ ⟩ ⟶ ⟨ (lambda args body), ρ, σ, DefFrame(symbol, κ) ⟩ 
        where symbol is Symbol

bind_value ≜ 
    ⟨ v, ρ, σ, DefFrame(s, κ) ⟩ ⟶ ⟨ null, ρ[s ↦ a], σ[a ↦ v], k ⟩
```


### Errors

```scheme
set!_error ≜
    ⟨ (set! s e), ρ, σ, κ ⟩ ⟶ ⟨ null, ρ, σ, (ErrorFrame κ) ⟩
        where s ∉ Symbol ∨ ρ[s] = ⊥
```
