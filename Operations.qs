namespace QuantumComputing {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation HelloQ() : Unit {
        //let message = [RandomInt(2), RandomInt(2)];
        //Message($"Message is : {message}");

        using ( (Q1, Q2, Bridge) = (Qubit(), Qubit(), Qubit())) {
            H(Q1);
            let initial = M(Q1);
            Message($"Q1 initially is at : {initial}");
            Entangle(Bridge, Q2);
            Decode(Q1, Bridge);
            let place = [initial, M(Bridge)];
            Message($"{place}");
            let measured = [ResultArrayAsInt([place[0]]), ResultArrayAsInt([place[1]])];
            Encode(Q2, measured);
            let final = M(Q2);
            Message($"The measured state of Q2 : {final}");
            Reset(Q1); Reset(Q2); Reset(Bridge);
        }
    }

    operation Entangle(Qubit1 : Qubit, Qubit2 : Qubit) : Unit {
        H(Qubit1);
        CNOT(Qubit1, Qubit2);
    }

    operation Encode(Qubit1 : Qubit, message : Int[]) : Unit {
        if (message[0] == 1) {
            Z(Qubit1);
        }
        if (message[1] == 1) {
            X(Qubit1);
        }
    }

    operation Decode(Qubit1 : Qubit, Qubit2 : Qubit) : Unit {
        CNOT(Qubit1, Qubit2);
        H(Qubit1);
    }

    operation ShowMessage(Qubit1 : Qubit, Qubit2 : Qubit) : Unit {
        let result = [M(Qubit1), M(Qubit2)];
        Message($"Result is : {result}");

    }

}